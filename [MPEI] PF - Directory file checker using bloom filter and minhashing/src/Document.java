import java.util.Arrays;
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

public class Document {
    private String name;
    private Function<Integer, Integer>[] functions;
    private int[] smallestHashes;

    public Document(String name, Function<Integer, Integer>[] functions) {
        this.name = name;
        this.functions = functions;
        smallestHashes = new int[functions.length];
        Arrays.fill(smallestHashes, -1);
    }

    public void insert(int hashedShingle){
        for(int i = 0; i < functions.length; i++) {
            int hash = functions[i].apply(hashedShingle);
            if(smallestHashes[i] == -1 || hash < smallestHashes[i]) smallestHashes[i] = hash;
        }
    }

    public int[] getSmallestHashes() {
        return smallestHashes;
    }

    public String getName() {
        return name;
    }

    public String toString(){
        return name;
    }
}

// h = (ax + b) % p;