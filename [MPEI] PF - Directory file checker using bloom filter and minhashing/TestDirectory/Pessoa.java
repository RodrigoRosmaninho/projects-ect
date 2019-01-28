package aula9.ex3;

public class Pessoa {
    private String nome;
    private int cc;
    private Data dataNasc;

    public Pessoa(String nome, int cc, Data dataNasc){
        this.nome = nome;
        this.cc = cc;
        this.dataNasc = dataNasc;
    }

    public String nome() { // getNome()
        return nome;
    }

    public int getCC() {
        return cc;
    }

    public Data getDataNasc() {
        return dataNasc;
    }

    @Override
    public String toString(){
        return nome + ", BI: " + cc + ", Nasc. Data: " + dataNasc;
    }


}
