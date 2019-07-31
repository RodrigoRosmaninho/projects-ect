package lib;

import java.util.HashMap;
import java.util.Map;
import org.antlr.v4.runtime.ParserRuleContext;

public class SymbolTable {
	
	public Map<String,BehaviourSymbol> behavs;
	public Map<String,FunctionSymbol> funcs;
	public Map<String, Call> calls;
	public Call apply;
	public Call init;
	public Context vars;
	
	public Context root;
	public Context curr;
	public Context last;
	
	public SymbolTable() {
		behavs = new HashMap<>();
		funcs = new HashMap<>();
		calls = new HashMap<>();
		vars = new Context(null,null);

		root = vars;
		curr = root;
		add_hardcoded();
	}
	
	public BehaviourSymbol getBehav(String id) {
		return behavs.get(id);
	}
	
	public boolean containsBehav(String id) {
		return behavs.containsKey(id);
	}
	
	public boolean putBehav(String id, BehaviourSymbol sym) {
		if (behavs.containsKey(id)) return false;
		behavs.put(id, sym);
		return true;
	}
	
	public FunctionSymbol getFunc(String id) {
		return funcs.get(id);
	}
	
	public boolean containsFunc(String id) {
		return funcs.containsKey(id);
	}
	
	public boolean putFunc(String id, FunctionSymbol sym) {
		if (funcs.containsKey(id)) return false;
		funcs.put(id, sym);
		return true;
	}

	public Call getCall(String id) {
		return calls.get(id);
	}

	public boolean containsCall(String id) {
		return calls.containsKey(id);
	}

	public boolean putCall(String id, Call sym) {
		if (calls.containsKey(id)) return false;
		if(sym.isApply()) {
			if (this.apply==null) this.apply = sym;
		}
		if(sym.isInit()) {
			if (this.init==null) this.init = sym;
		}
		calls.put(id, sym);
		return true;
	}

	public Call getApply() {
		return this.apply;
	}
	
	public VariableSymbol getVar(String id) {
		//if (root.symbolTable.containsKey(id)) return root.symbolTable.get(id);
		Context aux=curr;
		while (aux!=null) {
			if (aux.symbolTable.containsKey(id)) {
				last=aux;
				return aux.symbolTable.get(id);
			}
			aux=aux.parent;
		}
		return null;
	}
	
	public boolean containsVar(String id, boolean inRoot) {
		if (inRoot) return root.symbolTable.containsKey(id);
		return curr.symbolTable.containsKey(id);
	}
	
	public boolean putVar(String id, VariableSymbol sym, boolean inRoot) {
		if (inRoot) {
			if (root.symbolTable.containsKey(id)) return false;
			root.symbolTable.put(id, sym);
			return true;
		}
		if (curr.symbolTable.containsKey(id)) return false;
		curr.symbolTable.put(id, sym);
		return true;
	}
	
	public void goToNewContext(ParserRuleContext id) {
		curr=new Context(curr,id);
	}
	
	public boolean goDownContext(ParserRuleContext id) {
		if (!curr.contextTree.containsKey(id)) return false;
		curr=curr.contextTree.get(id);
		return true;
	}
	
	public void goUpContext() {
		curr=curr.parent;
	}

	private void add_hardcoded(){
		Call len = new Call("len");
		len.addMethod(new String[]{"str"}, "len(<str>)");
		len.setReturnType(new IntegerType());
		len.addArg(new Argument(new StringType(), "str"));
		calls.put("len", len);
	}
	
}
