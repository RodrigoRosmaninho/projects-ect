package lib;

import org.antlr.v4.runtime.ParserRuleContext;
import java.util.Map;
import java.util.HashMap;

public class Context {
	
	public Map<String,VariableSymbol> symbolTable;
	public Map<ParserRuleContext,Context> contextTree;
	public Context parent;
	
	public Context(Context parent, ParserRuleContext id) {
		symbolTable=new HashMap<>();
		contextTree=new HashMap<>();
		this.parent=parent;
		if(parent != null) parent.contextTree.put(id, this);
	}
	
	public boolean isChildOf(Context c) {
		Context aux=this;
		while (aux!=null) {
			if (aux==c) return true;
			aux=aux.parent;
		}
		return false;
	}
	
}