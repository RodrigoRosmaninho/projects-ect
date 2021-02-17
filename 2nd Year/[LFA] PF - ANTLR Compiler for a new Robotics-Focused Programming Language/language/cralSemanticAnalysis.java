package language;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.TerminalNode;

import language.cralParser.BlockContext;
import language.cralParser.ExprContext;
import language.cralParser.TypeContext;
import lib.*;

public class cralSemanticAnalysis extends cralBaseVisitor<Boolean> {
	private final BoolType boolType = new BoolType();
	private final CondType condType = new CondType();
	private final NumberType numType = new NumberType();
	private final StringType stringType = new StringType();
	private final VoidType voidType = new VoidType();
	
	private SymbolTable symTable;
	
	private int inCycle=0; //whether current context is cycle (stack to use in break semantics)
	private boolean varInUse=false; //whether a variable is in use (to use in call semantics)
	private boolean inAction=false; //whether current context is a call (to check for variables as arguments)
	private boolean inFunction=false; //whether current context is function (to use in return semantics)
	private boolean inBehaviour=false; //whether current context is behaviour (to use in call warning)
	private boolean hasReturn=false; //whether the current function has a return statement
	private boolean hasBreak=false; //whether a break statement is present in the context
	private Type retType=null; //the current function's return type (to use in return semantics)
	
	private boolean main=false; //whether there is a main function
	private boolean init=false;
	
	private boolean inCondAssign=false; //whether the current instruction is an assign to a condition
	private String condName=null; //if the above is true, stores that condition's id
	private Context condContext=null; //if above is true, stores that condition's context
	
	public cralSemanticAnalysis(SymbolTable symTable) {
		this.symTable = symTable;
	}
	
	@Override public Boolean visitProgram(cralParser.ProgramContext ctx) {
		visitChildren(ctx);
		if (!main) ErrorHandling.printError("The program must have a main function.");
		else if (!init && symTable.init!=null) ErrorHandling.printError("The initialization call is never used, even though it is defined. Use the initialization call as the first instruction of main.");
		return true;
	}
	
	//--Literals--
	
	@Override public Boolean visitLiteralBool(cralParser.LiteralBoolContext ctx) {
		ctx.res = boolType;
		return true;
	}
	
	@Override public Boolean visitLiteralNum(cralParser.LiteralNumContext ctx) {
		ctx.res = numType;
		return true;
	}

	@Override public Boolean visitLiteralString(cralParser.LiteralStringContext ctx) {
		ctx.res = stringType;
		return visit(ctx.string());
	}
	
	//--Atoms--
	
	@Override public Boolean visitAtomLiteral(cralParser.AtomLiteralContext ctx) {
		visit(ctx.literal());
		ctx.res = ctx.literal().res;
		return true;
	}
	
	@Override public Boolean visitAtomCall(cralParser.AtomCallContext ctx) {
		Boolean res = visit(ctx.actionCall());
		if (res) ctx.res = ctx.actionCall().res;
		return res;
	}
	
	@Override public Boolean visitAtomFunction(cralParser.AtomFunctionContext ctx) {
		Boolean res = visit(ctx.functionCall());
		if (res) ctx.res = ctx.functionCall().res;
		return res;
	}
	
	@Override public Boolean visitAtomID(cralParser.AtomIDContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		VariableSymbol sym=symTable.getVar(id);
		if (sym==null) {
			//Error: symbol does not exist
			EHvariableDoesNotExist(ctx,id);
			res=false;
		}
		else {
			if (!sym.getValDefined()) {
				//Error: variable not defined
				EHvariableNotDefined(ctx, id);
				res=false;
			}
			else ctx.res=sym.getType();
			if (inCondAssign) {
				if (id.equals(condName)) {
					//Error: cond variable in its own expression
					ErrorHandling.printError(ctx, "Can't use the cond variable " + ErrorHandling.colourVar(id) + " in its own expression");
					res=false;
				}
				if (!condContext.isChildOf(symTable.last)) {
					//Error: lower hierarchy variable in cond expression
					ErrorHandling.printError(ctx, "Can't use the lower variable " + ErrorHandling.colourVar(id) + " in the expression of the cond variable " + ErrorHandling.colourVar(condName) + ".",
											"Try declaring a local cond variable or declaring " + ErrorHandling.colourVar(id) + " in the same context of " + ErrorHandling.colourVar(condName) + ".");
					res=false;
				}
			}
		}
		varInUse=true;
		return res;
	}
	
	//--Symbol Related--
	
	@Override public Boolean visitDeclaration(cralParser.DeclarationContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		if (ctx.op != null && ctx.op.getText().equals("local")) {
			if (symTable.containsVar(id, false)) {
				//Error: symbol already exists
				EHvariableAlreadyExists(ctx, id);
				res=false;
			}
			else {
				if (ctx.type().res.equals(condType)) symTable.putVar(id, new CondVariableSymbol(id,ctx.type().res),false);
				else symTable.putVar(id, new VariableSymbol(id,ctx.type().res),false);
			}
		}
		else {
			if (symTable.containsVar(id, true)) {
				//Error: symbol already exists
				EHvariableAlreadyExists(ctx, id);
				res=false;
			}
			else {
				if (ctx.type().res.equals(condType)) symTable.putVar(id, new CondVariableSymbol(id,ctx.type().res),true);
				else symTable.putVar(id, new VariableSymbol(id,ctx.type().res),true);
			}
		}
		return res;
	}
	
	@Override public Boolean visitAssignDeclare(cralParser.AssignDeclareContext ctx) {
		Boolean res = visit(ctx.declaration());
		String id = ctx.declaration().ID().getText();
		VariableSymbol sym=symTable.getVar(id);
		if (sym==null) {
			//Error: variable does not exist
			EHvariableDoesNotExist(ctx, id);
			res=false;
		}
		else {
			boolean cond=sym instanceof CondVariableSymbol;
			if (cond) {
				if (sym.getValDefined()) {
					//Error: cannot redefine a cond variable
					ErrorHandling.printError(ctx, "Cond type variable " + ErrorHandling.colourVar(id) + " can't be redefined.", "Try using a new cond type variable.");
					return false;
				}
				inCondAssign=true;
				condName=id;
				condContext=symTable.last;
			}
			res=visit(ctx.expr());
			inCondAssign=false;
			if (!res) return false;
			if (!sym.getType().conforms(ctx.expr().res)) {
				//Error: type does not conform
				EHtypeDoesNotConform(ctx, sym.getType(), ctx.expr().res);
				res=false;
			}
			else {
				sym.setValDefined();
				if (cond) ((CondVariableSymbol)sym).expr=ctx.expr();
			}
		}
		return res;
	}
	
	@Override public Boolean visitAssignID(cralParser.AssignIDContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		VariableSymbol sym=symTable.getVar(id);
		if (sym==null) {
			//Error: variable does not exist
			EHvariableDoesNotExist(ctx, id);
			res=false;
		}
		else {
			boolean cond=sym instanceof CondVariableSymbol;
			if (cond) {
				if (sym.getValDefined()) {
					//Error: cannot redefine a cond variable
					ErrorHandling.printError(ctx, "Cond type variable " + ErrorHandling.colourVar(id) + " can't be redefined.", "Try using a new cond type variable.");
					return false;
				}
				inCondAssign=true;
				condName=id;
				condContext=symTable.last;
			}
			res=visit(ctx.expr());
			inCondAssign=false;
			if (!res) return false;
			if (!sym.getType().conforms(ctx.expr().res)) {
				//Error: type does not conform
				EHtypeDoesNotConform(ctx, sym.getType(), ctx.expr().res);
				res=false;
			}
			else {
				sym.setValDefined();
				if (cond) ((CondVariableSymbol)sym).expr=ctx.expr();
			}
		}
		return res;
	}
	
	@Override public Boolean visitAssignOp(cralParser.AssignOpContext ctx) {
		Boolean res = visit(ctx.expr());
		String id = ctx.ID().getText();
		VariableSymbol sym=symTable.getVar(id);
		if (sym==null) {
			//Error: variable does not exist
			EHvariableDoesNotExist(ctx, id);
			res=false;
		}
		else if (!sym.getValDefined()) {
			//Error: variable not defined
			EHvariableNotDefined(ctx, id);
			res=false;
		}
		else {
			if (!sym.getType().conforms(ctx.expr().res)) {
				//Error: type does not conform
				EHtypeDoesNotConform(ctx, sym.getType(), ctx.expr().res);
				res=false;
			}
			else {
				if (!ctx.expr().res.equals(numType)) {
					//Error: type must be num
					EHtypeMustBe(ctx, numType, ctx.expr().res);
					res=false;
				}
			}
		}
		return res;
	}
	
	@Override public Boolean visitAssignInc(cralParser.AssignIncContext ctx) {
		return visit(ctx.increment());
	}

	public Boolean visitString(cralParser.StringContext ctx) {
		Boolean res=true;
		ctx.exprs = new ArrayList<>();
		for (cralParser.RefContext rc : ctx.ref()) {
			res = res && visit(rc);
			if (!res) return false;
			ctx.exprs.add(rc);
		}
		return res;
	}

	public Boolean visitRef(cralParser.RefContext ctx) {
		return visit(ctx.expr());
	}
	
	@Override public Boolean visitBehaviourSet(cralParser.BehaviourSetContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		BehaviourSymbol sym=symTable.getBehav(id);
		if (sym==null) {
			//Error: behaviour does not exist
			EHbehaviourDoesNotExist(ctx, id);
			res=false;
		}
		return res;
	}
	
	@Override public Boolean visitBehaviourDeclare(cralParser.BehaviourDeclareContext ctx) {
		Boolean res = visit(ctx.expr());
		String id = ctx.ID().getText();
		
		if (!res) return false;
		
		//test condition
		if (!ctx.expr().res.equals(condType)) {
			//Error: expression type must be condition
			EHtypeMustBe(ctx, condType, ctx.expr().res);
			res=false;
		}
		//test body
		
		//ENTER NEW CONTEXT
		inBehaviour=true;
		symTable.goToNewContext(ctx);
		for (BlockContext blk : ctx.block()) {
			if (!res) break;
			res=res && visit(blk);
		}
		inBehaviour=false;
		//LEAVE NEW CONTEXT
		symTable.goUpContext();
		
		//test duplicates
		if (symTable.containsBehav(id)) {
			//Error: symbol already exists
			EHbehaviourAlreadyExists(ctx, id);
			res=false;
		}
		else symTable.putBehav(id, new BehaviourSymbol(id));
		return res;
	}
	
	@Override public Boolean visitActionCall(cralParser.ActionCallContext ctx) {
		inAction=true;
		Boolean res = true;
		String id = ctx.ID().getText();
		Call call=symTable.getCall(id);
		if (call==null) {
			//Error: call does not exist
			EHcallDoesNotExist(ctx, id);
			res=false;
		}
		else {
			if (call.isCritical() && !inBehaviour && !inCondAssign) {
				//Warning: Should be used inside Behaviour
				ErrorHandling.printWarning(ctx, "This call assumes a synchronized context and, thus, should be used inside a behaviour.");
			}
			ctx.res=call.getReturnType();
			String[] names;
			Type[] types;
			String[] vals;
			if (ctx.argumentCall()==null) {
				names=new String[0];
				types=new Type[0];
				vals=new String[0];
				String err=call.valid(names, types, vals);
				if (err!="") {
					//Error: (message is the value of err)
					ErrorHandling.printError(ctx, "CALL ERROR: " + ErrorHandling.colourCall(id) + ": " + err);
					res=false;
				}
			}
			else {
				res=res && visit(ctx.argumentCall());
				if (res) {
					names=ctx.argumentCall().names.toArray(new String[ctx.argumentCall().names.size()]);
					types=ctx.argumentCall().types.toArray(new Type[ctx.argumentCall().types.size()]);
					vals=ctx.argumentCall().vals.toArray(new String[ctx.argumentCall().vals.size()]);
					String err=call.valid(names, types, vals);
					if (err!="") {
						//Error: (value of err)
						ErrorHandling.printError(ctx, "CALL ERROR: " + ErrorHandling.colourCall(id) + ": " + err);
						res=false;
					}
					else if (call.isInit()) {
						init=true;
						call.setContext(ctx);
					}
				}
			}
		}
		inAction=false;
		return res;
	}
	
	@Override public Boolean visitFunctionCall(cralParser.FunctionCallContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		FunctionSymbol sym=symTable.getFunc(id);
		if (sym==null) {
			EHfunctionDoesNotExist(ctx, id, symTable.containsCall(id));
			res=false;
		}
		else {
			ctx.res=sym.getType();
			if (ctx.argumentCall()==null) {
				if (!sym.args.isEmpty()) {
					//Error: no arguments provided
					ErrorHandling.printError(ctx, "No arguments were provided when calling function " + ErrorHandling.colourFunc(id) + ".",
											"Call the function with arguments or remove the arguments from the function declaration");
					res=false;
				}
			}
			else {
				res = res && visit(ctx.argumentCall());
				if (res) {
					Map<String,Type> args=sym.args;
					List<String> names=ctx.argumentCall().names;
					List<Type> types=ctx.argumentCall().types;
					if (names.size()<args.size()) {
						//Error: insufficient arguments
						ErrorHandling.printError(ctx, "Insufficient arguments passed to function " + ErrorHandling.colourFunc(id) + ". Only " + names.size() + " out of " + args.size() + " provided.",
												"Check the function declaration for which arguments to use.");
					}
					for (int i=0;i<names.size();i++) {
						String n=names.get(i);
						Type t=types.get(i);
						if (!args.containsKey(n)) {
							//Error: Non-existent argument
							ErrorHandling.printError(ctx, "The argument " + ErrorHandling.colourVar(n) + " does not belong to the argument list of function " + ErrorHandling.colourFunc(id) + ".",
														"Use only the arguments declared");
							res=false;
						}
						else if (!args.get(n).conforms(t)) {
							//Error: type does not conform
							EHtypeDoesNotConform(ctx, args.get(n), t);
							res=false;
						}
					}
				}
			}
		}
		return res;
	}
	
	@Override public Boolean visitArgumentCall(cralParser.ArgumentCallContext ctx) {
		Boolean res = true;
		if (ctx.ID()==null || (ctx.ID().size()!=ctx.expr().size())) {
			//Error: failed to identify all arguments
			ErrorHandling.printError(ctx, "Not all arguments of identified.", "Identify all arguments as such: '<arg>=<expression>'");
			return false;
		}
		ctx.names=ctx.ID().stream()
							.map(t->t.getText())
							.collect(Collectors.toList());
		ctx.types=new ArrayList<>();
		ctx.vals=new ArrayList<>();
		for (int i=0;i<ctx.names.size();i++) {
			ExprContext expr=ctx.expr(i);
			varInUse=false;
			res=res && visit(expr);
			if (!res) return false;
			if (inAction && varInUse) {
				//Warning: Cannot validate variable use
				ErrorHandling.printWarning(ctx, "Can't validate value of variables when using calls. Make sure the variable you're using respects the argument restrictions.");
				ctx.vals.add(null);
			}
			else ctx.vals.add(expr.getText());
			varInUse=false;
			ctx.types.add(expr.res);
		}
		return res;
	}
	
	@Override public Boolean visitFunctionDeclare(cralParser.FunctionDeclareContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		
		main=main || (id.equals("main"));
		
		//test arguments and body
		
		//ENTER NEW CONTEXT
		symTable.goToNewContext(ctx);
		if(ctx.argumentDeclare() != null) {
			res=res && visit(ctx.argumentDeclare());
			if (id.equals("main")) {
				//Error: main function can't have arguments
				ErrorHandling.printError(ctx, "Main function can't have arguments.");
				res=false;
			}
		}
		
		if (!res) return false;
		
		inFunction=true;
		if (ctx.type()!=null) {
			if (ctx.type().res.equals(condType)) {
				//Error: cannot declare cond functions
				ErrorHandling.printError(ctx, "Function " + ErrorHandling.colourFunc(id) + " can't be of return type " + ErrorHandling.colourLiteral(condType.getName()) + ".",
										"Try using " + ErrorHandling.colourLiteral(boolType.getName()) + " instead.");
				return false;
			}
			retType=ctx.type().res;
		}
		else retType=voidType;
		for (BlockContext blk : ctx.block()) {
			if (!res) break;
			res=res && visit(blk);
		}

		inFunction=false;
		//LEAVE NEW CONTEXT
		symTable.goUpContext();
		
		if (!retType.conforms(voidType)) {
			if (id.equals("main")) {
				//Error: main is not void
				ErrorHandling.printError(ctx, "The main function should be of type " + ErrorHandling.colourLiteral(voidType.getName()) + ".");
				res=false;
			}
			else if (!hasReturn) {
				//Error: Missing return statement
				ErrorHandling.printError(ctx, "Function " + ErrorHandling.colourFunc(id) + " should have a return statement of type " + ErrorHandling.colourLiteral(retType.getName()) + ".",
										"Add a return statement or change function declaration to " + ErrorHandling.colourLiteral(voidType.getName()) + " type.");
				res=false;
			}
			else hasReturn=false;
		}
		
		//test duplicates
		if (symTable.containsFunc(id)) {
			//Error: symbol already exists
			EHfunctionAlreadyExists(ctx, id);
			res=false;
		}
		
		//function must be global
		Map<String,Type> argMap = new HashMap<>();
		List<VariableSymbol> argList = new ArrayList<>();
		if(ctx.argumentDeclare() != null) {
			List<VariableSymbol> args=ctx.argumentDeclare().args;
			for (VariableSymbol vs : args) {
				argMap.put(vs.getName(), vs.getType());
				argList.add(vs);
			}
		}
		FunctionSymbol fs = new FunctionSymbol(id,retType,argMap,argList);
		symTable.putFunc(id, fs);
		return res;
	}
	
	@Override public Boolean visitArgumentDeclare(cralParser.ArgumentDeclareContext ctx) {
		Boolean res = true;
		ctx.args=new ArrayList<>();
		List<TypeContext> types=ctx.type();
		List<TerminalNode> ids=ctx.ID();
		for (int i=0;i<types.size();i++) {
			String id = ids.get(i).getText();
			if (symTable.containsVar(id,false)) {
				//Error: symbol already exists
				EHvariableAlreadyExists(ctx, id);
				res=false;
			}
			else {
				Type t=types.get(i).res;
				VariableSymbol vs = new VariableSymbol(id,t);
				vs.setValDefined();
				symTable.putVar(id, vs, false);
				ctx.args.add(vs);
			}
		}
		return res;
	}
	
	//--Statements--
	
	@Override public Boolean visitReturnStat(cralParser.ReturnStatContext ctx) {
		hasReturn=true;
		Boolean res=(ctx.expr()==null?true:visit(ctx.expr()));
		if (!res) return false;
		if (!inFunction) {
			//Error: return statement outside of function
			ErrorHandling.printError(ctx, "Return statements can't be used outside function contexts.");
			res=false;
		}
		else if (ctx.expr()!=null) {
			if (!ctx.expr().res.conforms(retType)) {
				//Error: return type must conform to declared type
				ErrorHandling.printError(ctx, "The return type " + ErrorHandling.colourLiteral(ctx.expr().res.getName()) + " must conform to the declared type " + ErrorHandling.colourLiteral(retType.getName()) + ".", "Check which type is declared.");
				res=false;
			}
		}
		else if (!retType.conforms(voidType)) {
			//Error: return type must conform to declared type
			ErrorHandling.printError(ctx, "The return type " + ErrorHandling.colourLiteral(ctx.expr().res.getName()) + " must conform to the declared type" + ErrorHandling.colourLiteral(retType.getName()) + ".", "Check which type is declared.");
			res=false;
		}
		return res;
	}
	
	@Override public Boolean visitWhileStat(cralParser.WhileStatContext ctx) {
		inCycle++;
		Boolean res=visit(ctx.checkStat());
		inCycle--;
		return res;
	}
	
	@Override public Boolean visitUntilStat(cralParser.UntilStatContext ctx) {
		inCycle++;
		Boolean res=visit(ctx.checkStat());
		inCycle--;
		return res;
	}
	
	@Override public Boolean visitForStat(cralParser.ForStatContext ctx) {
		inCycle++;
		Boolean res=visit(ctx.forRange());
		inCycle--;
		return res;
	}
	
	@Override public Boolean visitForRange(cralParser.ForRangeContext ctx) {
		Boolean res = visit(ctx.interval());
		
		//test body
		
		//ENTER NEW CONTEXT
		symTable.goToNewContext(ctx);
		if (!ctx.type().res.equals(numType)) {
			//Error: type must be num
			EHtypeMustBe(ctx, numType, ctx.type().res);
			res=false;
		}
		else {
			VariableSymbol vs=new VariableSymbol(ctx.ID().getText(), ctx.type().res);
			vs.setValDefined();
			symTable.putVar(ctx.ID().getText(), vs, false);
		}
		
		hasBreak=false;
		for (BlockContext blk : ctx.block()) {
			if (hasBreak) {
				//Error: instruction after break
				ErrorHandling.printError(blk,"Can't have any instructions after a break statement in the same context.");
				res=false;
			}
			if (!res) break;
			res=res && visit(blk);
		}
		//LEAVE NEW CONTEXT
		hasBreak=false;
		symTable.goUpContext();
		
		return res;
	}

	@Override public Boolean visitWhenStat(cralParser.WhenStatContext ctx) {
		Boolean res = true;
		for(cralParser.CheckStatContext csc : ctx.checkStat()){
			res = res && visit(csc);
		}
		if (ctx.otherStat() != null) res = res && visit(ctx.otherStat());
		return res;
	}
	
	@Override public Boolean visitBreakStat(cralParser.BreakStatContext ctx) {
		hasBreak=true;
		if (inCycle>0) return true;
		//Error: break statement outside of loop
		ErrorHandling.printError(ctx, "Break statements can't be used outside of loop contexts.");
		return false;
	}
	
	@Override public Boolean visitCheckStat(cralParser.CheckStatContext ctx) {
		Boolean res = visit(ctx.expr());
		
		if (!res) return false;
		
		//test condition
		if (!ctx.expr().res.conforms(condType)) {
			//Error: expression type must be of boolean value
			EHtypeMustBe(ctx, boolType, ctx.expr().res);
			res=false;
		}
		//test body
		
		//ENTER NEW CONTEXT
		symTable.goToNewContext(ctx);
		hasBreak=false;
		for (BlockContext blk : ctx.block()) {
			if (hasBreak) {
				//Error: instruction after break
				ErrorHandling.printError(blk,"Can't have any instructions after a break statement in the same context.");
				res=false;
			}
			if (!res) break;
			res=res && visit(blk);
		}
		//LEAVE NEW CONTEXT
		hasBreak=false;
		symTable.goUpContext();
		
		return res;
	}
	
	@Override public Boolean visitOtherStat(cralParser.OtherStatContext ctx) {
		Boolean res = true;
		
		//test body
		
		//ENTER NEW CONTEXT
		symTable.goToNewContext(ctx);
		for (BlockContext blk : ctx.block()) {
			if (!res) break;
			res=res && visit(blk);
		}
		//LEAVE NEW CONTEXT
		symTable.goUpContext();
		
		return res;
	}
	
	//--Expressions--
	
	@Override public Boolean visitParExpr(cralParser.ParExprContext ctx) {
		Boolean res = visit(ctx.expr());
		ctx.res=ctx.expr().res;
		return res;
	}
	
	@Override public Boolean visitUnaryExpr(cralParser.UnaryExprContext ctx) {
		Boolean res = visit(ctx.expr());
		if (!res) return false;
		switch(ctx.op.getText()) {
		case "not":
			if (!ctx.expr().res.conforms(condType)) {
				//Error: type must be of boolean value
				EHtypeMustBe(ctx, boolType, ctx.expr().res);
				res=false;
			}
			ctx.res=condType;
		break;
		case "+":
		case "-":
			if (!ctx.expr().res.equals(numType)) {
				//Error: type must be num
				EHtypeMustBe(ctx, numType, ctx.expr().res);
				res=false;
			}
			ctx.res=numType;
		break;
		default:
			//Error: uknown operator
			ErrorHandling.printError(ctx,  "The operator " +  ctx.op.getText() + " is unknown. "
					+ "Check if the expression has the format \"op expr\". "
					+ "The permitted operators are: '+', '-', 'not'.");
			ctx.res=voidType;
		break;
		}
		
		return res;
	}
	
	@Override public Boolean visitIncExpr(cralParser.IncExprContext ctx) {
		Boolean res = visit(ctx.increment());
		ctx.res=numType;
		return res;
	}
	
	@Override public Boolean visitIncLeftExpr(cralParser.IncLeftExprContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		VariableSymbol sym=symTable.getVar(id);
		//test variable
		if (sym==null) {
			//Error: variable does not exist
			EHvariableDoesNotExist(ctx, id);
			res=false;
		}
		else {
			if (!sym.getValDefined()) {
				//Error: variable not defined
				EHvariableNotDefined(ctx, id);
				res=false;
			}
		}
		if (!res) return res;
		//test type
		if (!sym.getType().equals(numType)) {
			//Error: type must be num
			EHtypeMustBe(ctx, boolType, sym.getType());
			res=false;
		}
		return res;
	}
	
	@Override public Boolean visitIncRightExpr(cralParser.IncRightExprContext ctx) {
		Boolean res = true;
		String id = ctx.ID().getText();
		VariableSymbol sym=symTable.getVar(id);
		//test variable
		if (sym==null) {
			//Error: variable does not exist
			EHvariableDoesNotExist(ctx, id);
			res=false;
		}
		else {
			if (!sym.getValDefined()) {
				//Error: variable not defined
				EHvariableNotDefined(ctx, id);
				res=false;
			}
		}
		if (!res) return res;
		//test type
		if (!sym.getType().equals(numType)) {
			//Error: type must be num
			EHtypeMustBe(ctx, numType, sym.getType());
			res=false;
		}
		return res;
	}
	
	@Override public Boolean visitTernaryExpr(cralParser.TernaryExprContext ctx) {
		Boolean res = true;
		for (ExprContext exp : ctx.expr()) {
			res=res && visit(exp);
			if (!res) break;
			if (!exp.res.equals(numType)) {
				//Error: type must be num
				EHtypeMustBe(ctx, boolType, exp.res);
				res=false;
			}
		}
		ctx.res=condType;
		return res;
	}
	
	@Override public Boolean visitBinaryExpr(cralParser.BinaryExprContext ctx) {
		Boolean res = true;
		String op=ctx.op.getText();
		boolean arit=op.matches("\\^|\\*|\\+|\\/|%|<|>|-|<=|>=");
		boolean mixed=op.matches("is|==");
		
		res=res && visit(ctx.expr(0)) && visit(ctx.expr(1));
		if (!res) return false;
		if (!ctx.expr(0).res.conforms(ctx.expr(1).res)) {
			//Error: types must conform
			EHtypeDoesNotConform(ctx, ctx.expr(0).res, ctx.expr(1).res);
			res=false;
		}
		else if (arit) {
			if (!ctx.expr(0).res.conforms(numType)) {
				//Error: type must be num
				EHtypeMustBe(ctx, numType, ctx.expr(0).res);
				res=false;
			}
		}
		else if (!mixed) {
			if (!ctx.expr(0).res.conforms(boolType)) {
				//Error: type must be bool
				EHtypeMustBe(ctx, boolType, ctx.expr(0).res);
				res=false;
			}
		}
		
		if (op.matches("\\^|\\*|\\+|\\/|%|-")) ctx.res=numType;
		else if (op.matches("<|>|<=|>=|is|==|!=|or|and")) ctx.res=condType;

		return res;
	}

	@Override public Boolean visitAtomExpr(cralParser.AtomExprContext ctx) {
		Boolean res=visit(ctx.value());
		if (!res) return false;
		ctx.res=ctx.value().res;
		return true;
	}
	
	@Override public Boolean visitIntervalExpr(cralParser.IntervalExprContext ctx) {
		ctx.res=condType;
		return visit(ctx.expr()) && visit(ctx.interval());
	}
	
	@Override public Boolean visitInterval(cralParser.IntervalContext ctx) {
		Boolean res = true;
		for (ExprContext exp : ctx.expr()) {
			res=res && visit(exp);
			if (!res) return false;
			if (!exp.res.equals(numType)) {
				//Error: type must be num
				EHtypeMustBe(ctx, numType, exp.res);
				res=false;
			}
		}
		return res;
	}
	
	//---||PRIVATE||---
	
	private void EHvariableDoesNotExist(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The variable " + ErrorHandling.colourVar(id) + " you are trying to use was not declared.", "Try declaring it before you use it.");
	}
	
	private void EHbehaviourDoesNotExist(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The behaviour " + ErrorHandling.colourBehav(id) + " you are trying to set was not declared.", "Try declaring it before you use it.");
	}
	
	private void EHcallDoesNotExist(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The call " + ErrorHandling.colourCall(id) + " you are trying to use does not exist.", "Check the available calls.");
	}
	
	private void EHfunctionDoesNotExist(ParserRuleContext ctx, String id, boolean call) {
		if (call) ErrorHandling.printError(ctx, "The function " + ErrorHandling.colourFunc(id) + " you are trying to call does not exist. ",
												"However, a call with the same name exists. If using it was your intention don't forget to use the keyword \"call\".");
		else ErrorHandling.printError(ctx, "The function " + ErrorHandling.colourFunc(id) + " you are trying to call does not exist. ",
												"Check if there is any function with the functionality you want or create a new function.");
	}
	
	private void EHvariableNotDefined(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The variable " + ErrorHandling.colourVar(id) + " you're trying to use has no value.", "Try to initialize the variable, before you use it.");
	}
	
	private void EHvariableAlreadyExists(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The symbol " + ErrorHandling.colourVar(id) + " you are trying to create already exists.", "Try to create a new symbol.");
	}
	
	private void EHbehaviourAlreadyExists(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The symbol " + ErrorHandling.colourBehav(id) + " you are trying to create already exists.", "Try to create a new symbol.");
	}
	
	private void EHfunctionAlreadyExists(ParserRuleContext ctx, String id) {
		ErrorHandling.printError(ctx, "The symbol " + ErrorHandling.colourFunc(id) + " you are trying to create already exists.", "Try to create a new symbol.");
	}
	
	private void EHtypeDoesNotConform(ParserRuleContext ctx, Type correct, Type offending) {
		ErrorHandling.printError(ctx, "The type " + ErrorHandling.colourLiteral(offending.getName()) + " is not in conformity. The type must be equal to " + ErrorHandling.colourLiteral(correct.getName()) + ".");
	}
	
	private void EHtypeMustBe(ParserRuleContext ctx, Type correct, Type offending) {
		ErrorHandling.printError(ctx, "The type " + ErrorHandling.colourLiteral(offending.getName()) + " is not acceptable in this case, type must be " + ErrorHandling.colourLiteral(correct.getName()) + ".");
	}
	
}
