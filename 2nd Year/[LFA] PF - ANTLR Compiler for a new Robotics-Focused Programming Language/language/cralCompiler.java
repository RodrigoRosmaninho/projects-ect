package language;

import lib.*;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.misc.Interval;
import org.stringtemplate.v4.*;

import java.nio.file.*;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class cralCompiler extends cralBaseVisitor<ST> {

	private String target;
	private int numVars;
	private int numFunctions;
	private int numBehaviours;
	private int isInLoop;
	private boolean uncondBreak;

	private STGroup stg;
	private SymbolTable symbolTable;

	public cralCompiler(SymbolTable symbolTable, String target) {
		if (!hasSTGFile(target)) {
			this.stg = null;
			this.target = "";
		}
		else
			this.target = target;

		this.stg = new STGroupFile(this.target);

		this.numVars = 0;
		this.numFunctions = 0;
		this.numBehaviours = 0;
		this.symbolTable = symbolTable;
		this.isInLoop = 0;
		this.uncondBreak = false;
	}


	private boolean hasSTGFile(String filename) {
		if (filename == null || filename.equals("") || !filename.contains(".stg")) {
			return false;
		}

		Path p = Paths.get(filename);
		return p != null && Files.exists(p) && Files.isRegularFile(p) && Files.isReadable(p);
	}

	private ST setDeclarations(Symbol s, cralParser.DeclarationContext ctx) {
		if (s == null && ctx == null) {
			return null;
		}

		ST st = stg.getInstanceOf("declarations");
		ST decl = stg.getInstanceOf("decl");

		decl.add("var", "var" + (++numVars));
		if (s != null) {
			decl.add("type", s.getType().toString());
			s.setSymbolName("var" + numVars);
		}
		else {
			decl.add("type", ctx.type().res.getName());
		}

		st.add("decl", decl.render());

		return st;
	}

	@Override public ST visitProgram(cralParser.ProgramContext ctx) {

		ST st = stg.getInstanceOf("module");
		ST func = stg.getInstanceOf("function");
		func.add("type", "void");
		func.add("name", "topReserved_");
		func.add("argDefine", null);
		st.add("header", Header.getHeader());

		symbolTable.vars.symbolTable.values()
				.stream()
                .filter(s -> !s.isImported())
				.forEach(s ->  {
			ST decl = setDeclarations(s, null);
			st.add("decl", decl.render());
		});

		ctx.top().stream()
				.filter(t -> t != null && t instanceof cralParser.TopAssignContext)
				.map(t -> visit(t))
				.filter(temp -> temp != null)
				.forEach(temp -> func.add("stat",  temp.render()));

		st.add("top", func.render());

		ST stnew = stg.getInstanceOf("tops");

		ctx.top().stream()
				.filter(t -> t != null && !(t instanceof cralParser.TopAssignContext))
				.map(t -> visit(t))
				.filter(temp -> temp != null)
				.forEach(temp -> stnew.add("top",  temp.render()));

		st.add("top", stnew.render());
		return st;
	}

	@Override public ST visitDeclaration(cralParser.DeclarationContext ctx) {
		String id = ctx.ID().getText();
		Symbol s = symbolTable.getVar(id);
		if (ctx.op != null) {
			if (s == null)
				return setDeclarations(null, ctx);
			return setDeclarations(s, null);
		}
		else {
			return null;
		}
	}

	@Override public ST visitAssignDeclare(cralParser.AssignDeclareContext ctx) {
		String id = ctx.declaration().ID().getText();
		Symbol s = symbolTable.getVar(id);

		ST st = stg.getInstanceOf("stats");
		ST assign;

		ST expr = visit(ctx.expr());

		if (ctx.declaration().op != null) {
			setDeclarations(s, null);
			assign = stg.getInstanceOf("decl");
			assign.add("type", ctx.expr().res);
		}
		else
			assign = stg.getInstanceOf("assignment");

		if (!(ctx.expr() instanceof cralParser.AtomExprContext)
				|| ((cralParser.AtomExprContext) ctx.expr()).value() instanceof cralParser.AtomFunctionContext
				|| ((cralParser.AtomExprContext) ctx.expr()).value() instanceof cralParser.AtomCallContext
				|| ((cralParser.AtomExprContext) ctx.expr()).value().res instanceof StringType
				|| ((cralParser.AtomExprContext) ctx.expr()).value().res instanceof CondType
		) {
			st.add("stat", expr.render());
			assign.add("val", ctx.expr().varName);
		}
		else if(((cralParser.AtomExprContext)ctx.expr()).value() instanceof cralParser.AtomIDContext) {
			assign.add("val", expr.render());
		}
		else {
			assign.add("val", ctx.expr().getText());
		}
		assign.add("var", s.getSymbolName());

		st.add("stat", assign.render());

		return st;
	}

	@Override public ST visitAssignID(cralParser.AssignIDContext ctx) {
		String id = ctx.ID().getText();
		Symbol s = symbolTable.getVar(id);

		ST st = stg.getInstanceOf("stats");
		ST assign = stg.getInstanceOf("assignment");
		ST expr = visit(ctx.expr());
		if (!(ctx.expr() instanceof cralParser.AtomExprContext)
				|| ((cralParser.AtomExprContext) ctx.expr()).value() instanceof cralParser.AtomFunctionContext
				|| ((cralParser.AtomExprContext) ctx.expr()).value().res instanceof StringType
				|| ((cralParser.AtomExprContext) ctx.expr()).value().res instanceof CondType
		) {
			st.add("stat", expr.render());
			assign.add("val", ctx.expr().varName);
		}
		else if (((cralParser.AtomExprContext)ctx.expr()).value() instanceof cralParser.AtomIDContext) {
			assign.add("val", expr.render());
		}
		else {
			assign.add("val", ctx.expr().getText());
		}

		assign.add("var", s.getSymbolName());


		st.add("stat", assign.render());
		return st;
	}

	public ST visitAssignID(cralParser.ExprContext ctx, String varName) {

		ST st = stg.getInstanceOf("stats");
		ST assign = stg.getInstanceOf("assignment");
		ST expr = visit(ctx);
		if (!(ctx instanceof cralParser.AtomExprContext)
				|| ((cralParser.AtomExprContext) ctx).value() instanceof cralParser.AtomFunctionContext
				|| ((cralParser.AtomExprContext) ctx).value() instanceof cralParser.AtomCallContext
				|| ((cralParser.AtomExprContext) ctx).value().res instanceof StringType
				|| ((cralParser.AtomExprContext) ctx).value().res instanceof CondType
		) {
			st.add("stat", expr.render());
			assign.add("val", ctx.varName);
		}
		else if(((cralParser.AtomExprContext)ctx).value() instanceof cralParser.AtomIDContext) {
			assign.add("val", expr.render());
		}
		else {
			assign.add("val", ctx.getText());
		}

		assign.add("var", varName);


		st.add("stat", assign.render());
		return st;
	}

	@Override public ST visitAssignInc(cralParser.AssignIncContext ctx) {
		 return wrapInTerminalStat(visit(ctx.increment()));
	}

	@Override public ST visitAssignOp(cralParser.AssignOpContext ctx) {
		Symbol s = symbolTable.getVar(ctx.ID().getText());

		ST st = stg.getInstanceOf("assignOp");
		ST expr = visit(ctx.expr());

		if (!(ctx.expr() instanceof cralParser.AtomExprContext)
				|| ((cralParser.AtomExprContext) ctx.expr()).value() instanceof cralParser.AtomFunctionContext
				|| ((cralParser.AtomExprContext) ctx.expr()).value() instanceof cralParser.AtomCallContext
				|| ((cralParser.AtomExprContext) ctx.expr()).value().res instanceof StringType
				|| ((cralParser.AtomExprContext) ctx.expr()).value().res instanceof CondType
		) {
			st.add("pre_stat", expr.render());
			st.add("val", ctx.expr().varName);
		}
		else if(((cralParser.AtomExprContext)ctx.expr()).value() instanceof cralParser.AtomIDContext) {
			st.add("val", expr.render());
		}
		else {
			st.add("val", ctx.expr().getText());
		}

		st.add("op", ctx.op.getText());
		st.add("var", s.getSymbolName());

		return st;
	}

	@Override public ST visitBlock(cralParser.BlockContext ctx) {
		if(ctx.functionCall() != null) return wrapInTerminalStat(visit(ctx.functionCall()));
		return visitChildren(ctx);
	}

	@Override public ST visitBehaviourSet(cralParser.BehaviourSetContext ctx) {
		String id = ctx.ID().getText();
		Symbol s = symbolTable.getBehav(id);

		ST st = stg.getInstanceOf("functionCall");

		st.add("name", s.getSymbolName());
		st.add("arg", null);
		return wrapInTerminalStat(st);
	}

	@Override public ST visitBehaviourDeclare(cralParser.BehaviourDeclareContext ctx) {
		String id = ctx.ID().getText();
		ST st = stg.getInstanceOf("behaviour");
		BehaviourSymbol s = symbolTable.getBehav(id);
		s.setSymbolName("b" + (++numBehaviours));

		ST expr = visit(ctx.expr());
		st.add("pre_decl", expr.render());
		st.add("name", s.getSymbolName());
		st.add("var", ctx.expr().varName);

		String[] names = {"time"};
		String[] vals = {"1"};
		st.add("apply", symbolTable.getApply().getCodeForCall(names, vals));

		symbolTable.goDownContext(ctx);

		for (cralParser.BlockContext block : ctx.block()) {
			ST blk = visit(block);
			if (blk != null)
				st.add("stat", blk.render());
		}

		expr = visit(ctx.expr());
		st.add("pre_stat", expr.render());
		symbolTable.goUpContext();

		return st;
	}

	public ST visitActionCall(cralParser.ActionCallContext ctx, String varName) {
		ST st = stg.getInstanceOf("stats");
		ST decl = stg.getInstanceOf("decl");
		decl.add("type", ctx.res.getName());
		decl.add("var", varName);
		if (ctx.argumentCall() != null) {
			List<String> varNames = new ArrayList<>();
			for (cralParser.ExprContext expr : ctx.argumentCall().expr()) {
				ST exprST = visit(expr);
				if (expr.res instanceof CondType || !exprST.getName().equals("/atom")) {
					st.add("stat", exprST.render());
				}
				varNames.add(expr.varName);
			}
			ctx.argumentCall().vals = varNames;
			decl.add("val", visit(ctx.argumentCall()).render());
			st.add("stat", decl.render());
			return st;
		}
		else {
			Call c = symbolTable.getCall(ctx.ID().getText());
			String[] names = new String[0];
			String[] types = new String[0];
			decl.add("val",  c.getCodeForCall(names, types));
			st.add("stat", decl.render());

			return st;
		}
	}

	@Override public ST visitActionCall(cralParser.ActionCallContext ctx) {
		ST st = stg.getInstanceOf("stats");

		if (ctx.argumentCall() != null) {
			List<String> varNames = new ArrayList<>();
			for (cralParser.ExprContext expr : ctx.argumentCall().expr()) {
				ST exprST = visit(expr);
				if (expr.res instanceof CondType || !exprST.getName().equals("/atom")) {
					st.add("stat", exprST.render());
				}
				varNames.add(expr.varName);
			}
			ctx.argumentCall().vals = varNames;
			st.add("stat", wrapInTerminalStat(visit(ctx.argumentCall())).render());
			return st;
		}
		else {
			Call c = symbolTable.getCall(ctx.ID().getText());
			if (c.isInit())
				return null;
			String[] names = new String[0];
			String[] types = new String[0];
			st.add("stat", wrapInTerminalStat(c.getCodeForCall(names, types)));

			return st;
		}
	}

	@Override public ST visitFunctionCall(cralParser.FunctionCallContext ctx) {
		return visitFunctionCall(ctx, null);
	}

	public ST visitFunctionCall(cralParser.FunctionCallContext ctx, String varName) {
		ST st = stg.getInstanceOf("functionCall");

		String id = ctx.ID().getText();
		FunctionSymbol s = symbolTable.getFunc(id);

		if (ctx.argumentCall() != null) {
			for (cralParser.ExprContext expr : ctx.argumentCall().expr()) {
				ST exprST = visit(expr);
				if (expr.res instanceof CondType || !exprST.getName().equals("/atom")) {
					st.add("pre_decl", exprST.render());
				}
			}


			ST argCall = visit(ctx.argumentCall());
			st.add("arg", argCall.render());
		}

		st.add("type", s.getType().getName());
		st.add("var", varName);
		st.add("name", s.getSymbolName());

		return st;
	}

	@Override public ST visitArgumentCall(cralParser.ArgumentCallContext ctx) {
		ST st;

		String f_id;

		if ((ctx.parent instanceof cralParser.FunctionCallContext)) {
			st = stg.getInstanceOf("args");
			f_id = ((cralParser.FunctionCallContext) ctx.parent).ID().getText();
			FunctionSymbol fs = symbolTable.getFunc(f_id);


			for (Symbol s : fs.orderedArgs) {
				int index = ctx.names.indexOf(s.getName());
				st.add("arg", ctx.expr(index).varName);
			}
		}
		else {
			st = stg.getInstanceOf("stats");
			cralParser.ActionCallContext actionContext = (cralParser.ActionCallContext)ctx.parent;
			f_id = actionContext.ID().getText();

			Call c = symbolTable.getCall(f_id);

			String[] argNames = new String[ctx.names.size()];
			String[] exprVars = new String[ctx.vals.size()];

			ctx.names.toArray(argNames);
			ctx.vals.toArray(exprVars);

			st.add("stat", c.getCodeForCall(argNames, exprVars));
		}

		return st;
	}

	@Override public ST visitFunctionDeclare(cralParser.FunctionDeclareContext ctx) {
		String id = ctx.ID().getText();
		Symbol s = symbolTable.getFunc(id);
		ST st;
		ST stats = stg.getInstanceOf("stats");

		symbolTable.goDownContext(ctx);
		if (ctx.argumentDeclare() != null) {
			st = visit(ctx.argumentDeclare());
		}
		else
			st = stg.getInstanceOf("function");

		if (id.equals("main") && symbolTable.init != null) {
			for (int i = 1; i < ctx.block().size(); i++) {
				ST blk = visit(ctx.block(i));
				if (blk != null)
					stats.add("stat", blk.render());
			}
		}
		else {
			for (cralParser.BlockContext block : ctx.block()) {
				ST blk = visit(block);
				if (blk != null)
					stats.add("stat", blk.render());
			}
		}
		symbolTable.goUpContext();

		if (id.equals("main")) {
			st.add("type", "integer");
			st.add("name", "main");
			if (symbolTable.init != null) {
				st.add("stat", visit(symbolTable.init.getContext()).render());
			}
			st.add("stat", "topReserved_();");
			st.add("stat", stats.render());
			st.add("stat", "return 0;");
			s.setSymbolName("main");
		}
		else {
			if (!(s.getType() instanceof VoidType))
				st.add("type", s.getType().getName());

			st.add("name", "f" + (++numFunctions));
			s.setSymbolName("f" + numFunctions);
			st.add("stat", stats.render());
		}

		return st;
	}

	@Override public ST visitArgumentDeclare(cralParser.ArgumentDeclareContext ctx) {
		ST st = stg.getInstanceOf("function");

		for (int i = 0; i < ctx.args.size(); i++) {
			String id = ctx.ID(i).getText();
			Symbol s = symbolTable.getVar(id);

			ST argDecl = stg.getInstanceOf("argDefine");

			argDecl.add("type", s.getType().getName());
			argDecl.add("arg", "arg" + (i+1));
			s.setSymbolName("arg" + (i+1));
			st.add("argDefine", argDecl.render());
		}

		return st;

	}

	@Override public ST visitReturnStat(cralParser.ReturnStatContext ctx) {
		ST st = stg.getInstanceOf("return");

		if (ctx.expr() != null) {
			ST expr = visit(ctx.expr());
			if (ctx.expr().res instanceof CondType || !expr.getName().equals("/atom"))
				st.add("pre_stat", visit(ctx.expr()).render());

			st.add("var", ctx.expr().varName);
		}

		return st;
	}

	@Override public ST visitWhenStat(cralParser.WhenStatContext ctx) {
		ST st = stg.getInstanceOf("stats");
		ST when = stg.getInstanceOf("when");

		for (cralParser.CheckStatContext check : ctx.checkStat()) {
			ST expr = visit(check.expr());
			if (check.expr().res instanceof CondType || !expr.getName().equals("/atom")) {
				st.add("stat", expr.render());
			}

			ST conditional = stg.getInstanceOf("conditional");

			conditional.add("var", check.expr().varName);

			conditional.add("stat", visit(check).render());

			when.add("conditional", conditional.render());
		}
		if (ctx.otherStat() != null) {
			when.add("else_stat", visit(ctx.otherStat()).render());
		}

		st.add("stat", when.render());
		return st;
	}

	@Override public ST visitWhileStat(cralParser.WhileStatContext ctx) {
		isInLoop++;
		uncondBreak = false;
		ST st = stg.getInstanceOf("stats");
		ST wh = stg.getInstanceOf("while");

		wh.add("stat", visit(ctx.checkStat()));

		ST check = visit(ctx.checkStat().expr());
		if (!check.getName().equals("/atom") || ctx.checkStat().expr().res instanceof CondType) {
			wh.add("pre_decl", check.render());
			String varName = ctx.checkStat().expr().varName;
			ST assign = stg.getInstanceOf("assignment");
			ST preStat = visit(ctx.checkStat().expr());
			if (!uncondBreak)
				wh.add("pre_stat", preStat.render());
			assign.add("var", varName);
			assign.add("val", ctx.checkStat().expr().varName);
			wh.add("var", varName);
			if (!uncondBreak)
				wh.add("pre_stat", assign.render());
		}
		else {
			wh.add("var", check.render());
		}

		st.add("stat", wh.render());

		isInLoop--;
		return st;
	}

	@Override public ST visitUntilStat(cralParser.UntilStatContext ctx) {
		isInLoop++;
		uncondBreak = false;
		ST st = stg.getInstanceOf("stats");
		ST until = stg.getInstanceOf("until");

		until.add("stat", visit(ctx.checkStat()));

		ST check = visit(ctx.checkStat().expr());
		if (!check.getName().equals("/atom") || ctx.checkStat().expr().res instanceof CondType) {
			until.add("pre_decl", check.render());
			String varName = ctx.checkStat().expr().varName;
			ST assign = stg.getInstanceOf("assignment");

			ST preStat = visit(ctx.checkStat().expr());
			if (!uncondBreak)
				until.add("pre_stat", preStat.render());

			assign.add("var", varName);
			assign.add("val", ctx.checkStat().expr().varName);
			until.add("var", varName);
			if (!uncondBreak)
				until.add("pre_stat", assign.render());
		}
		else {
			until.add("var", check.render());
		}

		st.add("stat", until.render());

		isInLoop--;
		uncondBreak = false;
		return st;
	}

	@Override public ST visitForStat(cralParser.ForStatContext ctx) {
		isInLoop++;
		uncondBreak = false;
		ST st = visit(ctx.forRange());
		isInLoop--;
		uncondBreak = false;
		return st;
	}

	@Override public ST visitForRange(cralParser.ForRangeContext ctx) {
		ST st = stg.getInstanceOf("for");

		symbolTable.goDownContext(ctx);
		String id = ctx.ID().getText();
		Symbol s = symbolTable.getVar(id);
		ST decl = setDeclarations(s, null);

		ST assignVar = stg.getInstanceOf("assignment");
		assignVar.add("stat", decl.render());

		ST e1 = visit(ctx.interval().expr(0));

		assignVar.add("stat", e1.render());
		assignVar.add("var", s.getSymbolName());

		String thisVar = "var"+(++numVars);

		if (ctx.interval().del1.getText().equals("]"))
			assignVar.add("val", ctx.interval().expr(0).varName + " + 1");
		else
			assignVar.add("val", ctx.interval().expr(0).varName);

		st.add("pre_decl", assignVar.render());

		ST e2 = visit(ctx.interval().expr(1));

		st.add("pre_decl", e2.render());

		ST assignBool = stg.getInstanceOf("decl");
		assignBool.add("type", "bool");
		assignBool.add("var", thisVar);

		ST interval = visit(ctx.interval());
		interval.add("var", s.getSymbolName());
		interval.add("e1", ctx.interval().expr(0).varName);
		interval.add("e2", ctx.interval().expr(1).varName);
		assignBool.add("val", interval.render());

		st.add("pre_decl", assignBool.render());

		st.add("var", thisVar);

		for (cralParser.BlockContext block : ctx.block()) {
			ST blk = visit(block);
			if (blk != null)
				st.add("stat", blk.render());
			if (block.getText().equals("break"))
				uncondBreak = true;
		}
		symbolTable.goUpContext();

		if (!uncondBreak)
			st.add("pre_stat", wrapInTerminalStat(s.getSymbolName() + "++"));

		ST postAssign = stg.getInstanceOf("assignment");
		ST gtExpr = new ST("<e1> <op> <e2>");

		Map<String, Object> map  = stg.rawGetDictionary("lessThanOperators");
		String del2 = (String)map.get(ctx.interval().del2.getText());
		gtExpr.add("op", del2);
		gtExpr.add("e1", s.getSymbolName());
		gtExpr.add("e2", ctx.interval().expr(1).varName);

		postAssign.add("var", thisVar);
		postAssign.add("val", gtExpr.render());

		if (!uncondBreak)
			st.add("pos_stat", postAssign.render());

		uncondBreak = false;
		return st;
	}

	@Override public ST visitBreakStat(cralParser.BreakStatContext ctx) {
		return stg.getInstanceOf("stats").add("stat", wrapInTerminalStat("break"));
	}

	@Override public ST visitCheckStat(cralParser.CheckStatContext ctx) {
		ST st = stg.getInstanceOf("stats");

		symbolTable.goDownContext(ctx);
		for (cralParser.BlockContext block : ctx.block()) {
			ST blk = visit(block);
			if (blk != null)
				st.add("stat", blk.render());
			if (isInLoop > 0 && (block.getText().equals("break")))
				uncondBreak = true;

		}
		symbolTable.goUpContext();

		return st;
	}

	@Override public ST visitOtherStat(cralParser.OtherStatContext ctx) {
		ST st = stg.getInstanceOf("stats");

		symbolTable.goDownContext(ctx);
		for (cralParser.BlockContext block : ctx.block()) {
			ST blk = visit(block);
			if (blk != null)
				st.add("stat", blk.render());
			if (isInLoop > 0 && (block.getText().equals("break")))
				uncondBreak = true;
		}
		symbolTable.goUpContext();

		return st;
	}

	@Override public ST visitParExpr(cralParser.ParExprContext ctx) {
		ST st = visit(ctx.expr());
		ctx.varName = ctx.expr().varName;
		return st;
	}

	@Override public ST visitUnaryExpr(cralParser.UnaryExprContext ctx) {
		ctx.varName = "var" + (++numVars);
		ST st = stg.getInstanceOf("stats");
		ST expr = visit(ctx.expr());

		if (ctx.op.getText().equals("-")) {
			ST decl = stg.getInstanceOf("decl");
			decl.add("type", ctx.expr().res);
			decl.add("var", ctx.varName);
			decl.add("val", "-");
			if (ctx.expr().res instanceof CondType || !expr.getName().equals("/atom")) {
				st.add("stat", expr.render());
				decl.add("val", ctx.expr().varName);
			}
			else {
				decl.add("val", expr.render());
			}

			st.add("stat", decl.render());
		}
		else if (ctx.op.getText().equals("not")) {
			ST decl = stg.getInstanceOf("decl");
			decl.add("type", ctx.expr().res);
			decl.add("var", ctx.varName);
			decl.add("val", "!");
			if (ctx.expr().res instanceof CondType || !expr.getName().equals("/atom")) {
				st.add("stat", expr.render());
				decl.add("val", ctx.expr().varName);
			}
			else {
				decl.add("val", expr.render());
			}

			st.add("stat", decl.render());
		}
		else
			return visit(ctx.expr());


		return st;
	}

	@Override public ST visitIncLeftExpr(cralParser.IncLeftExprContext ctx) {
		ST st = stg.getInstanceOf("atom");
		Symbol s = symbolTable.getVar(ctx.ID().getText());
		st.add("val", ctx.op.getText() + s.getSymbolName());
		return st;
	}

	@Override public ST visitIncRightExpr(cralParser.IncRightExprContext ctx) {
		ST st = stg.getInstanceOf("atom");
		Symbol s = symbolTable.getVar(ctx.ID().getText());
		st.add("val", s.getSymbolName() + ctx.op.getText());
		return st;
	}

	@Override public ST visitIncExpr(cralParser.IncExprContext ctx) {
		ctx.varName = "var" + (++numVars);
		ST st = stg.getInstanceOf("decl");
		ST incr = visit(ctx.increment());
		st.add("type", ctx.res);
		st.add("var", ctx.varName);
		st.add("val", incr.render());
		return st;
	}

	@Override public ST visitBinaryExpr(cralParser.BinaryExprContext ctx) {
		ctx.varName = "var" + (++numVars);
		ST st = stg.getInstanceOf("stats");
		ST bin = stg.getInstanceOf("binaryExpression");

		ST e1 = visit(ctx.expr(0));
		if (ctx.expr(0).res instanceof CondType || !e1.getName().equals("/atom")) {
			st.add("stat", e1.render());

		}

		ST e2 = visit(ctx.expr(1));
		if (ctx.expr(1).res instanceof CondType|| !e2.getName().equals("/atom")) {
			st.add("stat", e2.render());
		}

		bin.add("type", ctx.res.getName());
		bin.add("var", ctx.varName);
		bin.add("e1", ctx.expr(0).varName);
		bin.add("op", ctx.op.getText());
		bin.add("e2", ctx.expr(1).varName);

		st.add("stat", bin.render());

		return st;
	}

	@Override public ST visitTernaryExpr(cralParser.TernaryExprContext ctx) {
		ctx.varName = "var"+(++numVars);
		ST st = stg.getInstanceOf("stats");
		ST tern = stg.getInstanceOf("ternaryExpression");

		tern.add("type", ctx.res.getName());
		tern.add("var", ctx.varName);
		int k = 1;
		for (cralParser.ExprContext expr : ctx.expr()) {
			ST e = visit(expr);
			if (expr.res instanceof CondType || !e.getName().equals("/atom"))
				st.add("stat", e.render());
			tern.add("e" + (k++), expr.varName);
		}

		tern.add("op1", ctx.op1.getText());
		tern.add("op2", ctx.op2.getText());

		st.add("stat", tern.render());

		return st;
	}

	@Override public ST visitAtomExpr(cralParser.AtomExprContext ctx) {

		if (ctx.value() instanceof cralParser.AtomIDContext) {
			ST st = visitAtomID((cralParser.AtomIDContext) ctx.value());
			String id = ((cralParser.AtomIDContext) (ctx.value())).ID().getText();
			Symbol s = symbolTable.getVar(id);

			if(s instanceof CondVariableSymbol)
				ctx.varName = s.getSymbolName();
			else
				ctx.varName = st.render();

			return st;
		}

		ctx.varName = "var" + (++numVars);

		if (ctx.value() instanceof cralParser.AtomFunctionContext) {
			return visitAtomFunction((cralParser.AtomFunctionContext) ctx.value(), ctx.varName);
		}

		if (ctx.value() instanceof cralParser.AtomCallContext) {
			return visitAtomCall((cralParser.AtomCallContext) ctx.value(), ctx.varName);
		}

		if (ctx.value().res instanceof StringType) {
			return visitValue(ctx.value(), ctx.varName);
		}

		ST st = stg.getInstanceOf("stats");
		ST decl = stg.getInstanceOf("decl");


		decl.add("type", ctx.res);
		decl.add("var", ctx.varName);
		decl.add("val", visit(ctx.value()));

		st.add("stat", decl.render());

		return st;
	}

	@Override public ST visitIntervalExpr(cralParser.IntervalExprContext ctx) {
		ctx.varName = "var" + (++numVars);

		ST st = stg.getInstanceOf("stats");

		ST expr = visit(ctx.expr());
		if (!expr.getName().equals("/atom"))
			st.add("stat", expr.render());

		ST e1 = visit(ctx.interval().expr(0));
		ST e2 = visit(ctx.interval().expr(1));

		st.add("stat", e1.render());
		st.add("stat", e2.render());

		ST interval = visit(ctx.interval());
		interval.add("var", ctx.expr().varName);
		interval.add("e1", ctx.interval().expr(0).varName);
		interval.add("e2", ctx.interval().expr(1).varName);

		ST decl = stg.getInstanceOf("decl");
		decl.add("type", ctx.res);
		decl.add("var", ctx.varName);
		decl.add("val", interval.render());
		st.add("stat", decl.render());

		return st;
	}

	@Override public ST visitInterval(cralParser.IntervalContext ctx) {
		ST st = stg.getInstanceOf("squareBracketsInterval");

		st.add("bracket1", ctx.del1.getText());
		st.add("bracket2", ctx.del2.getText());

		return st;
	}

	public ST visitValue(cralParser.ValueContext ctx, String varName) {
		return visitAtomLiteral((cralParser.AtomLiteralContext)ctx, varName);
	}

	@Override public ST visitAtomLiteral(cralParser.AtomLiteralContext ctx) {
		return visit(ctx.literal());
	}

	public ST visitAtomLiteral(cralParser.AtomLiteralContext ctx, String varName) {
		return visitLiteralString((cralParser.LiteralStringContext)ctx.literal(), varName);
	}

	@Override public ST visitAtomID(cralParser.AtomIDContext ctx) {
		String id = ctx.ID().getText();
		Symbol s = symbolTable.getVar(id);

		ST atom = stg.getInstanceOf("atom");
		if(s instanceof CondVariableSymbol) {
			atom.add("val", visitAssignID(((CondVariableSymbol) s).expr, s.getSymbolName()).render());
		}
		else if (s instanceof VariableSymbol && ((VariableSymbol) s).isImported()) {
				atom.add("val", s.getName());
		}
		else atom.add("val", s.getSymbolName());
		return atom;
	}

	public ST visitAtomFunction(cralParser.AtomFunctionContext ctx, String varName) {
		return visitFunctionCall(ctx.functionCall(), varName);
	}

	public ST visitAtomCall(cralParser.AtomCallContext ctx, String varName) {
		return visitActionCall(ctx.actionCall(), varName);
	}

	@Override public ST visitLiteralNum(cralParser.LiteralNumContext ctx) {
		ST st = stg.getInstanceOf("atom");
		st.add("val", ctx.NUM().getText());
		return st;
	}

	@Override public ST visitLiteralBool(cralParser.LiteralBoolContext ctx) {
		ST st = stg.getInstanceOf("atom");

		st.add("val", ctx.BOOL().getText());
		return st;
	}

	public ST visitLiteralString(cralParser.LiteralStringContext ctx, String varName) {
		return visitString(ctx.string(), varName);
	}

	public ST visitString(cralParser.StringContext ctx, String varName) {
		ST st = stg.getInstanceOf("stats");
		String str = ctx.start.getInputStream().getText(new Interval(ctx.start.getStartIndex(),ctx.stop.getStopIndex()));

		ST assign = stg.getInstanceOf("decl");
		assign.add("type", "string");
		assign.add("var", varName);
		if (ctx.exprs.isEmpty()) {
			str = str.replaceAll("\\\\\\$", "\\$");
			assign.add("val", str);
			st.add("stat", assign.render());
		}
		else
		{
			st.add("stat", assign.render());
			str = str.substring(1, str.length()-1);
			int baseIndex = -1;
			int index = str.indexOf("$");
			ST strcats = stg.getInstanceOf("stringConcats");
			for (ParserRuleContext context : ctx.exprs) {
				cralParser.RefContext ref = (cralParser.RefContext) context;
				ST refST = visit(ref);
				if (!refST.getName().equals("/atom"))
					st.add("stat", refST.render());

				// Accept escaped dollars onto final string, unescaped for C++
				String subLeft = str.substring(baseIndex+1, index);
				while (subLeft.lastIndexOf('\\') == subLeft.length()-1 && !subLeft.isEmpty()) {
					subLeft = subLeft.substring(0, subLeft.length()-1);
					subLeft += str.substring(index, str.indexOf("$",index+1));
					index = str.indexOf("$", index+1);
				}

				ST strcat = strcat = stg.getInstanceOf("stringConcatStr");

				if (!subLeft.isEmpty()) {
					strcat.add("var", varName);
					strcat.add("val", subLeft);

					strcats.add("strCat", strcat.render());
				}


				strcat = strcat = stg.getInstanceOf("stringConcatOthers");
				strcat.add("var", varName);
				strcat.add("valVar", ref.expr().varName);

				strcats.add("strCat", strcat.render());

				baseIndex = str.indexOf("$", index + 1);
				index = str.indexOf("$", baseIndex + 1);
			}

			if (baseIndex != -1) {
				String subRight = str.substring(baseIndex+1);
				if (!subRight.isEmpty()) {
					ST strcat = stg.getInstanceOf("stringConcatStr");
					strcat.add("var", varName);
					strcat.add("val", subRight);

					strcats.add("strCat", strcat.render());
				}
			}
			st.add("stat", strcats.render());
		}

		return st;
	}

	@Override public ST visitRef(cralParser.RefContext ctx) {
		return visit(ctx.expr());
	}

	private ST wrapInTerminalStat(Object obj){
		ST st = stg.getInstanceOf("terminalStat");
		st.add("stat", obj);
		return st;
	}
}
