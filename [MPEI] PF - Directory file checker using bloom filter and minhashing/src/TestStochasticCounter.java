/*

   Métodos Probabilísticos para Engenharia Informática - 2018/2019
   Universidade de Aveiro

   Trabalho Prático
   Entregue a 11/12/2018

   Efetuado por:
   Rodrigo Rosmaninho - Nº MEC: 88802
   André Alves - Nº MEC: 88811

*/

public class TestStochasticCounter {
    public static void main(String[] args){
        System.out.println("\n*** Testes do Módulo de Contagem Estocástica ***");
        printTable1(2);
        printTable1(16);
        printTable1(32);
    }

    public static void printTable1(int prob){
        System.out.println("\n** Probabilidade de incremento: 1/" + prob + " **");

        System.out.println("\n|------------|-----------------|-------------|----------------|-----------|");
        System.out.println(  "| Valor Real | Valor Registado | Aproximação |  Real - Aprox  | Erro em % |");
        System.out.println(  "|------------|-----------------|-------------|----------------|-----------|");

        for (int i = 1; i < 9; i++) {
            int k = (int) Math.pow(10,i);

            System.out.printf("| %-10d ", k);

            StochasticCounter counter = new StochasticCounter(prob);
            for(int j = 0; j < k; j++) {
                counter.increment();
            }

            System.out.printf("| %-15d ", counter.getCount());
            System.out.printf("| %-11d ", counter.getResult());
            System.out.printf("| %-14d ", Math.abs(counter.getResult() - k));
            System.out.printf("| %-8.4f%% |%n", (double) (Math.abs(counter.getResult() - k) * 100) / (double) k);
        }
        System.out.println("|------------|-----------------|-------------|----------------|-----------|");
    }
}
