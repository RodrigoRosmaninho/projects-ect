package lib;

public class VariableSymbol extends Symbol {
	boolean imported;
	public VariableSymbol(String name, Type type) {

		super(name,type);
		imported = false;
	}

	public boolean isImported() {
		return imported;
	}

	public void setImported(boolean imported) {
		this.imported = imported;
	}
}