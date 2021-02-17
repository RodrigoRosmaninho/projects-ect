package lib;

import java.util.List;
import java.util.Map;

public class FunctionSymbol extends Symbol {
	//public List<Type> args;
	public Map<String,Type> args;
	public List<VariableSymbol> orderedArgs;
	
	public FunctionSymbol(String name, Type type, Map<String,Type> args, List<VariableSymbol> orderedArgs) {
		super(name,type);
		this.args = args;
		this.orderedArgs = orderedArgs;
		setValDefined();
	}
}