package lib;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;

import language.cralParser;
import org.stringtemplate.v4.ST;

import language.cralParser.ArgumentCallContext;

public class Call{

    private LinkedList<Argument> args ;
    private String name;
    private HashMap<String, String> tableOfMethods;
    private Type returnType;
    private cralParser.ActionCallContext context;
    private boolean apply;
    private boolean critical;
    private boolean init;
    public LinkedList<Argument> getArgs() {
        return args;
    }
    
    public void setContext(cralParser.ActionCallContext ctx) {
    	this.context=ctx;
    }
    
    public cralParser.ActionCallContext getContext() {
    	return context;
    }

    public HashMap<String, String> getTableOfMethods() {
        return tableOfMethods;
    }

    public String getName() {
        return name;
    }

    public Type getReturnType() {

        return returnType;
    }

    public void setReturnType(Type returnType) {
        this.returnType = returnType;
    }

    public Call(String name){
        this.name = name;
        tableOfMethods = new HashMap<>();
        args = new LinkedList<>();
        apply = false;
    }

    public void addArg(Argument arg){
        args.add(arg);
    }

    public void addMethod(String[] argNames, String template){
        Arrays.sort(argNames);
        String concArgs = "";
        for(String str : argNames)concArgs+=str;
        tableOfMethods.put(concArgs, template);
    }

    public void setApply(boolean apply) {
        this.apply = apply;
    }

    public boolean isApply() {
        return apply;
    }

    public boolean isCritical() {
        return critical;
    }

    public void setCritical(boolean critical) {
        this.critical = critical;
    }
    
    public boolean isInit() {
        return init;
    }

    public void setInit(boolean init) {
        this.init = init;
    }

    public String getCodeForCall(String[] argNames, String[] argValues){
        if(argNames.length != argValues.length)throw new IllegalArgumentException();
        
        
        String[] argsCp = Arrays.copyOf(argNames, argNames.length, String[].class);
        Arrays.sort(argsCp);
        String concArgs = "";


        for(String str : argsCp)concArgs+=str;


        ST template = new ST(tableOfMethods.get(concArgs));

        

        for(int i = 0; i < argNames.length; i++){
            Argument arg = getArgByName(argNames[i]);
            if(arg != null && arg.getType() instanceof StringType){
                template.add(argNames[i], "&" + argValues[i] + "[0u]");
            }
            else template.add(argNames[i], argValues[i]);
        }

        return template.render();
    }

    public String valid(String[] argNames, Type[] argTypes, String[] argValues){
        if(argNames.length != argTypes.length)throw new IllegalArgumentException();
        
        
        String[] argsCp = Arrays.copyOf(argNames, argNames.length, String[].class);
        Arrays.sort(argsCp);
        String concArgs = "";
        for(String str : argsCp)concArgs+=str;


        if(!tableOfMethods.containsKey(concArgs)){
            //to do mensagem melhor 
            return "Invalid Arguments";
        }


        for(int i = 0; i < argNames.length; i++){
            Argument arg = getArgByName(argNames[i]);
            Type type = argTypes[i];
            String value = argValues[i];
            if(!arg.getType().equals(type)){
                return "Invalid Argument Type" + argNames[i];
            }
            if(arg.asAceptedList()){
                if(arg.checkValid(value)){
                    continue;
                }else{
                    return arg.getErrorMesg();
                }
            }
            if(value == null || !arg.asLimits())continue;
            double compareValue;
            if(type.equals(new StringType())){
                compareValue = value.length();
            }else{
                try{
                    compareValue = Double.parseDouble(value);
                }catch(NumberFormatException e){
                    continue;
                }         
            }
            if(!arg.checkValid(compareValue)){
                return arg.getErrorMesg();
            }
            
        }
        return "";

    }

    private Argument getArgByName(String name){
        for(Argument arg : args){
            if(arg.getName().equals(name))return arg;
        }
        return null;
    }



}