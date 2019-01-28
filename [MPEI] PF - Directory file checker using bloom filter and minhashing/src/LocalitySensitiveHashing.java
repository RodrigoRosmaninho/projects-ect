import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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

public class LocalitySensitiveHashing {
    // Funções de hash a aplicar sobre as bandas
    private Function<Integer, Integer>[] hashFunctions;
    // Número de bandas
    private int numBands;

    public LocalitySensitiveHashing(Function<Integer, Integer>[] hashFunctions, int numBands) {
        this.hashFunctions = hashFunctions;
        this.numBands = numBands;
    }

    public List<Document> getProbableMatches(Document target, List<Document> documents){
        List<Document> candidates = new ArrayList<>();

        // Buscar os buckets das bandas do documento alvo
        int[] target_buckets = getBucketsFromDocument(target, numBands);

        // Iterar sobre a lista de documentos para averiguar quais são candidatos a serem semelhantes ao documento alvo
        for(Document d : documents){
            // Buscar os buckets das bandas de um determinado documento da lista
            int[] buckets = getBucketsFromDocument(d, numBands);

            // Comparar os buckets do documento contemplado com os do documento alvo
            // Basta serem iguais uma vez para o documento contemplado ser considerado candidato
            for(int i = 0; i < numBands; i++){
                if(buckets[i] == target_buckets[i]) {
                    candidates.add(d);
                    break;
                }
            }
        }

        return candidates;
    }

    // Dividir documento em bandas e calcular buckets
    public int[] getBucketsFromDocument(Document d, int bands){
        int[] res = new int[bands];
        int[] smallestHashes = d.getSmallestHashes();
        int band_width = smallestHashes.length / bands; // r = numero de funções de hash usadas para o MinHashing / b
        for(int i = 0; i < bands; i++) {
            // Gerar um sub-array de comprimento band_width, ou seja, uma banda
            int[] band = Arrays.copyOfRange(smallestHashes, (band_width*i), (band_width*i) + band_width);

            // Fazer o hashing da banda usando universal hashing (hashFunctions) para calcular o bucket
            int x = Arrays.hashCode(band);
            res[i] = hashFunctions[i].apply(x); // Guardar bucket no int[] res
        }
        return res; // Devolver lista de buckets
    }
}
