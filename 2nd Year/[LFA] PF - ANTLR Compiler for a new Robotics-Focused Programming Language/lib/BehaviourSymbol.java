package lib;

import language.*;

public class BehaviourSymbol extends Symbol {
	public cralParser.ExprContext expr;
	
	public BehaviourSymbol(String name) {
		super(name,new VoidType());
		setValDefined();
	}
}