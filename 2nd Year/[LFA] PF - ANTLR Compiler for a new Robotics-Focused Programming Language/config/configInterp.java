// Generated from config.g4 by ANTLR 4.7.2

package config;
import lib.*;
import java.util.*;
import java.util.stream.*;


public class configInterp extends configBaseVisitor<Object>{
	private SymbolTable symTable;

	public configInterp(SymbolTable symTable) {
		this.symTable = symTable;
	}

	@Override
	public Object visitProgram(configParser.ProgramContext ctx) {
		return visitChildren(ctx);
	}

	@Override
	public Object visitHeader(configParser.HeaderContext ctx) {

		Header.setHeader(ctx.getText().substring(ctx.getText().indexOf(':')+1, ctx.getText().length() - 3));

		return null;
	}


	@Override
	public Object visitLiteral(configParser.LiteralContext ctx){
		String id = ctx.STRING().getText().substring(1,ctx.STRING().getText().length()-1);
		Type type = ctx.type().res;
		VariableSymbol var = new VariableSymbol(id,type);
		var.setValDefined();
		var.setImported(true);
		symTable.putVar(id,var ,true);
		return null;
	}


	
	@Override
	public Object visitCall(configParser.CallContext ctx) {


		Call call = new Call(ctx.STRING().getText().substring(1, ctx.STRING().getText().length()-1));

		LinkedList<Argument> args = null;
		List<String> argNames = new ArrayList<>();
		Type returnType = null;
		configParser.MethodsContext methodsCtx = (configParser.MethodsContext)visit(ctx.methods());

 		if(ctx.vars() != null){
 			args = (LinkedList<Argument>)visit(ctx.vars());

 			argNames = args.stream().map(argument -> argument.getName()).collect(Collectors.toList());
		}

 		if(ctx.returnType() != null) returnType = (Type)visit(ctx.returnType());

 		int i = 0;
		configParser.MethodContext methodCtx;
        methodCtx = methodsCtx.method(i++);
 		while(methodCtx != null){

 			String[] array = (String[])visit(methodCtx);

 			String template = array[array.length-1];
 			String[] arguments = new String[array.length-1];
 			if(args == null && arguments.length > 0){
 				ErrorHandling.printConfigError(ctx,"The call " + ErrorHandling.colourCall(ctx.STRING().getText()) + " has no declared arguments.", 
 												"Declare arguments in " + ErrorHandling.colourLiteral("vars") + " block or remove them from " + ErrorHandling.colourLiteral("methods") + " block.");
 				return null;
			}

 			for(int j = 0; j < arguments.length; j++){

                arguments[j] = array[j];
 				if(!argNames.contains(arguments[j])){
 					ErrorHandling.printConfigError(ctx,"The call " + ErrorHandling.colourCall(ctx.STRING().getText()) + " has no argument " + ErrorHandling.colourVar(arguments[j]) + ".",
 												"Try adding it to the " + ErrorHandling.colourLiteral("vars") + " block or remove it from the " + ErrorHandling.colourLiteral("methods") + " block.");
 					return null;
				}

			}

			call.addMethod(arguments,template);

            methodCtx = methodsCtx.method(i++);

		}

		if(args != null){
 			for(Argument arg : args) {
                call.addArg(arg);
            }
		}
		if(returnType != null){
 			call.setReturnType(returnType);
		}else{
 			call.setReturnType(new VoidType());
		}
		call.setApply(ctx.apply() != null);
		call.setCritical(ctx.critical() != null);
		call.setInit(ctx.init() != null);
		// adicionar call à symbolTable
		if(!symTable.putCall(call.getName(), call)){
			ErrorHandling.printConfigError(ctx,"Call " + ErrorHandling.colourCall(call.getName()) + " already exists.", "Try changing its name.");
		}
		else if (call.isInit() && symTable.init!=call) {
			ErrorHandling.printConfigError(ctx, "Can't have two calls tagged as " + ErrorHandling.colourLiteral("init") + ".", "Remove " + ErrorHandling.colourLiteral("init") + " tag form either of " + ErrorHandling.colourCall(call.getName()) + " or " + ErrorHandling.colourCall(symTable.init.getName()) + ".");
		}
		else if (call.isApply() && symTable.apply!=call) {
			ErrorHandling.printConfigError(ctx, "Can't have two calls tagged as " + ErrorHandling.colourLiteral("apply") + ".", "Remove " + ErrorHandling.colourLiteral("apply") + " tag form either of " + ErrorHandling.colourCall(call.getName()) + " or " + ErrorHandling.colourCall(symTable.apply.getName()) + ".");
		}

		return null;
	}
	
	@Override
	public Object visitReturnType(configParser.ReturnTypeContext ctx) {

		return ctx.type().res;
	}


	@Override
	public Object visitVars(configParser.VarsContext ctx) {


		LinkedList<Argument> list = new LinkedList<>();

        int i =0;
        configParser.VarContext var = ctx.var(i++);
		while(var != null){

			list.add((Argument)visit(var));
			var = ctx.var(i++);

		}

		return list;
	}
	
	@Override
	public Object visitVar(configParser.VarContext ctx) {
        visit(ctx.STRING());
		Argument arg = new Argument(ctx.type().res,ctx.STRING().getText().substring(1, ctx.STRING().getText().length()-1));

		if(ctx.interval() != null) {
			Argument auxInterval = (Argument) visit(ctx.interval());
			arg.setInterval(auxInterval.getMax(),auxInterval.getMin());

			if(ctx.message() != null) {
				String msg = (String) visit(ctx.message());
				arg.setErrorMesg(msg.substring(1));
			}
		}

		return arg;
	}
	
	@Override
	public Object visitInterval(configParser.IntervalContext ctx) {
	    visitChildren(ctx);
	    double min,max;
        if(ctx.min != null){
	        min = Double.parseDouble(ctx.min.getText());
        }else{
	        min = Double.MIN_VALUE;
        }
        if(ctx.max != null){
            max = Double.parseDouble(ctx.max.getText());
        }else{
            max = Double.MAX_VALUE;
        }
		Argument arg = new Argument(null,null,max,min);
		return arg;
	}
	
	@Override
	public Object visitMessage(configParser.MessageContext ctx) {

		return ctx.STRING().getText().substring(0,ctx.STRING().getText().length()-1);
	}

	@Override
	public Object visitMethods(configParser.MethodsContext ctx) {
		return ctx;
	}
	
	@Override
	public Object visitMethod(configParser.MethodContext ctx) {
		String[] array = new String[ctx.Name().size()+1];
		int i;
		for(i = 0; i < array.length-1; i++){
			array[i] = ctx.Name(i).getText();
		}
		array[i] = ctx.STRING().getText().substring(1,ctx.STRING().getText().length()-1);
		return array;
	}
	
}