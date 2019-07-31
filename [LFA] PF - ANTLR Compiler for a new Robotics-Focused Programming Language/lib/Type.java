package lib;

public abstract class Type {
    private final String name;

    public Type(String name){
        if(name == null) throw new IllegalArgumentException();
        this.name = name;
    }

    public String getName() {
        return name;
    }

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Type))
			return false;
		Type other = (Type) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	
	public boolean conforms(Type t) {
		return equals(t);
	}

	@Override
    public String toString() {
        return name;
    }
}
