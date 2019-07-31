package lib;

import java.util.LinkedList;

public class Argument{

    private Type type;

    private String name, errorMesg;

    private double min, max;

    private LinkedList<String> acepted;

    public Argument(Type tp, String nm, double max, double min) {
        name = nm;
        type = tp;

        this.min = min;
        this.type = type;

        this.max = max;
        this.name = name;
    }



    public Argument(Type tp, String nm) {
        this(tp,nm, Double.MAX_VALUE, Double.MIN_VALUE);
    }

    public void addAcepted(String value){
        if(acepted == null)acepted = new LinkedList<>();
        acepted.add(value);
    }


    public double getMin() {
        return min;
    }

    public Type getType() {
        return type;
    }


    public double getMax() {
        return max;
    }

    public String getErrorMesg() {
        return errorMesg;
    }

    public void setErrorMesg(String errorMesg) {
        this.errorMesg = errorMesg;
    }

    public void setInterval(double max, double min){
        this.max = max;
        this.min = min;
    }

    public String getName() {
        return name;
    }

    public boolean checkValid(double value){
        return min <= value && max >= value;
    }
    public boolean checkValid(String value){
        if(!asAceptedList())return false;
        return acepted.contains(value);
    }

    public boolean asLimits(){
        return min != Double.MIN_VALUE || max != Double.MAX_VALUE;
    }

    public boolean asAceptedList(){
        return acepted != null;
    }


    


    


}