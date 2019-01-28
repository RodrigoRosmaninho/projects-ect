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

public class CountingBloomFilter<T> {
    private int[] filter;
    private Function<T, Integer>[] functions;
    private int size;
    private int maxInt;

    // Inicializar a estrutura de dados e definir a lista de funções de hashing a usar (fornecida como argumento)
    public CountingBloomFilter(int n, int w, Function<T, Integer>[] functions){
        filter = new int[n];
        // Calcular máximo valor que cada bucket pode ter apartir dos argumetos fornecidos
        maxInt = getMaxIntFromBits(w);
        this.functions = functions;
    }

    // Inserir um elemento no CountingBloomFilter
    public boolean insert(T object){
        // Iterar sobre todas as funções de hashing, aplicar cada uma aos dados para calcular cada bucket cujo valor deve ser incrementado por um
        for(Function<T, Integer> f : functions){
            int res = f.apply(object);
            if(filter[res] == maxInt) return false;
            filter[res]++;
        }
        size++;
        return true;
    }

    // Verificar se um dado elemento pertence ao CountingBloomFilter
    public boolean contains(T object){
        // Iterar sobre todas as funções de hashing, aplicar cada uma aos dados para calcular cada bucket cujo valor deve ser pelo menos 1 para que o elemento pertença
        for(Function<T, Integer> f : functions){
            if(filter[f.apply(object)] == 0) return false; // Se um dos buckets tiver o valor 0, o elemento não pertençe
        }
        return true;
    }

    // Remover um dado elemento do CountingBloomFilter
    public boolean remove(T object){
        // Verificar se o elemento pertence ao CountingBloomFilter
        if(!contains(object)) return false;
        // Iterar sobre todas as funções de hashing, aplicar cada uma aos dados para calcular cada bucket cujo valor deve ser decrementado por 1 para que o elemento seja removido
        for(Function<T, Integer> f : functions){
            filter[f.apply(object)]--;
        }
        size--;
        return true;
    }

    // Verificar quantas vezes foi inserido um dado elemento no Counting Bloom Filter
    public int count(T object){
        int record = -1;
        // Iterar sobre todas as funções de hashing, aplicar cada uma aos dados
        for(Function<T, Integer> f : functions){
            int value = filter[f.apply(object)];
            if(value > 0 && (value < record || record == -1)) record = value;
        }
        return record;
    }

    // GETTERS

    public int getSize() {
        return size;
    }

    // UTIL

    public static int getOptimumSize(int m, double p){
        return (int) Math.ceil(m * (Math.abs(Math.log(p)) / Math.pow(Math.log(2), 2)));
    }

    // Calcular o k ótimo para garantir a menor probabilidade de falsos positivos com base dos argumentos fornecidos
    public static int getOptimumK(int m, int n){
        return (int) Math.round(((double)n/m) * Math.log(2));
    }

    // Calcular o maior inteiro que pode ser representado por n bits (fornecido como argumento)
    public static int getMaxIntFromBits(int nBits){
        return (int) Math.ceil(Math.pow(2,nBits));
    }
}
