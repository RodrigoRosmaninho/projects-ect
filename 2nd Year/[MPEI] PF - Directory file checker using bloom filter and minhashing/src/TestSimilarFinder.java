import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.stream.Collectors;

 /*

    Métodos Probabilísticos para Engenharia Informática - 2018/2019
    Universidade de Aveiro

    Trabalho Prático
    Entregue a 11/12/2018

    Efetuado por:
    Rodrigo Rosmaninho - Nº MEC: 88802
    André Alves - Nº MEC: 88811

 */

public class TestSimilarFinder {
    static List<String> testFile;
    static int k;
    static Function<Integer, Integer>[] hashFunctions;

    public static void main(String[] args) throws IOException {
        System.out.println("\n*** Testes do Módulo SimilarFinder (minHash + LSH) ***");
        try {
            testFile = Files.readAllLines(Paths.get("TestFiles/SimilarFinder_test.txt"));
        } catch (IOException e) {
            System.out.println("\n\n*** Erro! Não foi possível encontrar o diretório TestFiles. Verifique! ***");
            System.exit(1);
        }
        k = 20;
        System.out.println("\nFoi lido um ficheiro com linhas de texto: \"TestFiles/SimilarFinder_test.txt\"");

        performTest(new SimilarFinder<>(getShinglingFunc(),2, 300));
        lshTest(new SimilarFinder<>(getShinglingFunc(),2, 300));
    }

    public static void performTest(SimilarFinder<String> sf){
        String testString = "As armas e os Barões assinalados";
        System.out.println("\n** Verificação da existência de strings semelhantes a \"" + testString + "\" **\n");

        testFile.stream().filter((s -> s.trim().length() > 0)).collect(Collectors.toList()).forEach(s -> sf.insert(s, s));

        List<Document> candidates = sf.getLSHCandidates(testString);
        MostSimilar mostSimilar = sf.getMostSimilar(testString);
        List<Duplicates> duplicates = sf.getDuplicates();

        System.out.println("Strings candidatas a serem semelhantes (Obtidas por Locality Sensitive Hashing): ");
        candidates.forEach(d -> System.out.println("\"" + d.getName() + "\""));

        System.out.println("\nString mais semelhante:\n\"" + mostSimilar.getDoc() + "\" - Distância de Jaccard: " + mostSimilar.getJaccardDistance());

        System.out.println("\n\n** Verificação da existência de strings duplicadas **");
        duplicates.forEach(d -> System.out.println("\nA string \"" + d.getDoc1() + "\" é duplicada da string \"" + d.getDoc2() + "\"\nDistância de Jaccard: " + d.getJaccardDistance()));
    }

    public static void lshTest(SimilarFinder<String> sf){
        System.out.println("\n\n** Teste do módulo de Locality Sensitiive Hashing **\n" +
                "\nForam adicionadas 10 mil strings com 40 carateres geradas aleatóriamente.\n" +
                "De seguida, foram adicionadas mil novas strings geradas de forma igual e, para cada uma, foi contado o número de strings (das 10 mil originais) candidatas a serem semelhantes (por LSH).\n" +
                "Idealmente, não haveria candidatos.");

        System.out.print("\nA calcular, aguarde... ");

        for(int i = 0; i < 10000; i++) {
            String random = TestBloomFilter.randomString(40);
            sf.insert(random, random);
        }

        int falseCandidates = 0;

        for(int i = 0; i < 1000; i++) {
            falseCandidates += sf.getLSHCandidates(TestBloomFilter.randomString(40)).size();
        }

        System.out.println("Feito");

        System.out.println("\nSomatório do número de falsos candidatos (em 1000 testes com um dataset de 10000 elementos): " + falseCandidates);
    }

    public static BiFunction<String, Integer, Iterator<Integer>> getShinglingFunc(){
        // Função lambda que representa a função de shingling
        return (str, k) -> {
            // HashSet para acelerar o processo de verificação se um determinado shingle já existe
            // Aumenta a velocidade do processo significativamente em relação a um processo iterativo
            HashSet<Integer> set = new HashSet<>();
            char[] strArr = str.toCharArray();

            // Construir shingles com comprimento k
            for (int i = 0; i < str.length() - k; i++) {
                char[] shingle = Arrays.copyOfRange(strArr, i, i + k);

                // O adicionar à lista de shingles (Set, logo não permitirá valores repetidos)
                set.add(Arrays.hashCode(shingle));
            }
            // Devolver a lista de shingles
            return set.iterator();
        };
    }


}
