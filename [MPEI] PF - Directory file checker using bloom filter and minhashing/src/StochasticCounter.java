/*

   Métodos Probabilísticos para Engenharia Informática - 2018/2019
   Universidade de Aveiro

   Trabalho Prático
   Entregue a 11/12/2018

   Efetuado por:
   Rodrigo Rosmaninho - Nº MEC: 88802
   André Alves - Nº MEC: 88811

*/

public class StochasticCounter {
    private int count;
    private int prob;

    public StochasticCounter(int prob) {
        count = 0;
        this.prob = prob;
    }

    public void increment(){
        if(shouldIncrement()) count++;
    }

    public void decrement(){
        if(shouldIncrement()) count--;
    }

    public boolean shouldIncrement(){
        double r = Math.random();
        double s = 1.0 / (double) prob;
        return r < s;
    }

    public int getCount() {
        return count;
    }

    public int getResult() {
        return count * prob;
    }
}
