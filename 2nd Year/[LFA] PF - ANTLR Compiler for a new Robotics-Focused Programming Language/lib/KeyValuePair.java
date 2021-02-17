package lib;

import java.util.Map;

public class KeyValuePair<T, K> implements Map.Entry {
    private final T key;
    private K value;

    public KeyValuePair(T key, K value) {
        this.key = key;
        this.value = value;
    }

    @Override
    public Object getKey() {
        return key;
    }

    @Override
    public Object getValue() {
        return value;
    }

    @Override
    public Object setValue(Object o) {
        value = (K) o;
        return o;
    }
}
