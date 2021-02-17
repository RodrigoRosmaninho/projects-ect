package lib;

public class BoolType extends Type {
	public BoolType() {
		super("bool");
	}

	@Override
	public boolean conforms(Type t) {
		return super.conforms(t) || (t).getName().equals("cond");
	}
}
