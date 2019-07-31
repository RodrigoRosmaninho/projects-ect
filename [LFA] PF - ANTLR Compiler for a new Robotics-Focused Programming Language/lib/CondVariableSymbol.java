package lib;

import language.*;

public class CondVariableSymbol extends VariableSymbol {
	public cralParser.ExprContext expr;
	
	public CondVariableSymbol(String name, Type type) {
		super(name,type);
	}
}