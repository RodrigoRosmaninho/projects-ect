package lib;

public class CondType extends Type {
    public CondType() {
        super("cond");
    }

    @Override
    public boolean conforms(Type t) {
        return super.conforms(t) || (t).getName().equals("bool");
    }
}
