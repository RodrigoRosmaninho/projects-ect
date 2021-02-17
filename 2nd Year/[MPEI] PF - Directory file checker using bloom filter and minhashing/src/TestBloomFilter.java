import java.util.function.Function;

 /*

    Métodos Probabilísticos para Engenharia Informática - 2018/2019
    Universidade de Aveiro

    Trabalho Prático
    Entregue a 11/12/2018

    Efetuado por:
    Rodrigo Rosmaninho - Nº MEC: 88802
    André Alves - Nº MEC: 88811

 */

public class TestBloomFilter {
    public static void main(String[] args){

        System.out.println("\n*** Testes do Módulo do Counting Bloom Filter ***");

        int m = 1000;

        int size = CountingBloomFilter.getOptimumSize(m,0.001); // 0.1%
        int size2 = CountingBloomFilter.getOptimumSize(3,0.001); // 0.1%
        int size3 = CountingBloomFilter.getOptimumSize(100,0.001); // 0.1%
        CountingBloomFilter<String> filter = new CountingBloomFilter<>(size, 6, getHashFunctions1(m, size));
        CountingBloomFilter<String> filter2 = new CountingBloomFilter<>(size2,6,getHashFunctions1(3,size2));
        CountingBloomFilter<String> filter3 = new CountingBloomFilter<>(size3,6,getHashFunctions1(100,size3));

        int tests = m*10;

        System.out.println("\nTeste de percentagem de falsos positivos\n\nAdicionaram-se " + m + " strings aleatórias de 40 carateres ao Counting Bloom Filter.\n" +
                "De seguida, foram geradas " + tests + " novas strings aleatórias, cuja pertença ao bloom filter foi averiguada.\n" +
                "Como a probabilidade de qualquer uma das novas strings ser igual a qualquer uma das originais é ínfima (40 carateres aleatórios),\n" +
                "as strings cujo teste de pertença foi positivo são falsos positivos.");

        for (int i = 0; i < m; i++) {
            filter.insert(randomString(40));
        }
        int cnt =0;


        for (int i = 0; i < tests; i++) {
            if(filter.contains(randomString(40))) cnt++;

        }

        double percent = (double)cnt/tests;
        percent *= 100;
        System.out.println("\nFalsos Positivos esperados (aproximadamente) : "+ (int) (0.001*tests));
        System.out.println("Percentagem esperada: 0.1%");
        System.out.println("\nFalsos Positivos (valor real): "+cnt);
        System.out.printf("Percentagem real: %.2f %% \n",percent);

        System.out.println("\n------------------------------\nTeste de inserção, verificação de pertença, e remoção\n" +
                "\nCriou-se um novo Counting Bloom Filter, filtro 2");


        String[] strings = new String[3];
        for(int i=0;i<strings.length;i++){

            strings[i] = randomString(40);
            filter2.insert(strings[i]);
            System.out.printf("\nAdicionou-se a string %s.",strings[i]); // should be true
        }


        System.out.printf("\n\nO filtro 2 tem a string %s ?\t->\t%b \n",strings[0],filter2.contains(strings[0])); // should be true
        System.out.printf("O filtro 2 tem a string %s ?\t->\t%b \n",strings[1],filter2.contains(strings[1])); // should be true
        String teststring = randomString(39);
        System.out.printf("O filtro 2 tem a string %s ?\t->\t%b \n",teststring,filter2.contains(teststring));  // should be false
        filter2.remove(strings[0]); // Testar tb a função remove
        System.out.printf("\nRemoveu-se do filtro 2 a string %s\n",strings[0]);
        System.out.printf("O filtro 2 tem a string %s ?\t->\t%b \n",strings[0],filter2.contains(strings[0])); // should be false


        System.out.println("\n------------------------------\nTeste das funções count() e remove()\n");

        for (int i = 0; i < 100; i++) {
            filter3.insert(strings[(int)(Math.random()*2)]);
        }

        filter3.insert(strings[1]);
        filter3.insert(strings[1]);

        System.out.println("Adicionaram-se 100 strings ao filtro 3.\n");

        System.out.printf("A string %s encontra-se %d vezes no filtro 3\n",strings[1],filter3.count(strings[1]));

        int countremove=0;
        for (countremove=0; countremove < (int)(Math.random()*10)+3; countremove++) {
            filter3.remove(strings[1]);
        }

        System.out.println("A string "+strings[1]+" foi removida "+countremove+" vezes do filtro 3");
        System.out.printf("A string %s encontra-se %d vezes no filtro 3\n",strings[1],filter3.count(strings[1]));




    }

    public static Function<String, Integer>[] getHashFunctions1(int m, int n) {
        final int p = 1086216277; // big prime number
        int k = CountingBloomFilter.getOptimumK(m,n);
        Function[] res = new Function[k];
        for(int i = 0; i < k; i++){
            final int a = Math.round((float) Math.random() * (p - 1)) + 1;
            final int b = Math.round((float) Math.random() * (p - 1));
            res[i] = (string) -> Math.abs((((a * string.hashCode()) + b) % p) % n);
        }
        // Devolve-se o array de funções lambda
        return res;
    }

    public static String randomString(int length) {
        String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        StringBuilder randstring = new StringBuilder();
        int randint;
        for (int i = 0; i < length; i++) {
            randint = (int) Math.abs(Math.random()*letters.length());
            randstring.append(letters.charAt(randint));
        }
        return randstring.toString();
    }
}
