package lib;

public abstract class Symbol {
	private String name;
	private Type type;
	private boolean valDefined;
	private String symbolName;
	
	public Symbol (String name, Type type) {
		if(name == null || type == null) throw new IllegalArgumentException();
		this.name = name;
		this.type = type;
		
		valDefined=false;
		symbolName=null;
	}
	
	public String getName() {
		return name;
	}
	
	public Type getType() {
		return type;
	}
	
	public boolean getValDefined() {
		return valDefined;
	}
	
	public void setValDefined() {
		valDefined=true;
	}
	
	public String getSymbolName() {
		return symbolName;
	}
	
	public void setSymbolName(String name) {
		if(name == null) throw new IllegalArgumentException();
		symbolName=name;
	}
}