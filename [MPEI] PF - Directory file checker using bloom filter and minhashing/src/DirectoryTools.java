import java.io.*;
import java.util.*;
import java.util.function.BiFunction;
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

public class DirectoryTools {
    private CountingBloomFilter<byte[]> filter;
    private SimilarFinder<byte[]> finder;
    private StochasticCounter counter;

    // Inicializar CountingBloomFilter e estruturas relevantes ao MinHashing e LocalitySensitiveHashing
    public DirectoryTools(int m, double falsePositiveProbability){
        int size = CountingBloomFilter.getOptimumSize(m, falsePositiveProbability);
        filter = new CountingBloomFilter<>(size, 6, getHashFunctions(m, size));
        finder = new SimilarFinder<>(getShinglingFunc(),15, 300);
        counter = new StochasticCounter(16);
    }

    // Inserir ficheiro no CountingBloomFilter e Matriz de Assinaturas
    public void insert(File f) throws IOException {
        byte[] data = readFile(f);
        for (int i = 0; i < data.length; i++) counter.increment();
        filter.insert(data);
        finder.insert(f.getName(), data);
    }

    // Remover ficheiro do CountingBloomFilter e da Matriz de Assinaturas
    public boolean remove(File f) throws IOException {
        byte[] data = readFile(f);
        for (int i = 0; i < data.length; i++) counter.decrement();
        boolean bf = filter.remove(data);
        boolean sf = finder.remove(f.getName());
        return bf && sf;
    }

    public int count(File f) throws IOException {
        byte[] data = readFile(f);
        return filter.count(data);
    }

    // Verificar se ficheiro pertence ao CountingBloomFilter e, se sim, qual o ficheiro do diretório mais semelhante a ele
    public Verify verifyFile(File f) throws IOException {
        byte[] data = readFile(f);
        return new Verify(finder.getMostSimilar(data), filter.contains(data));
    }

    public int getCounterResult(){
        return counter.getResult();
    }

    public List<Duplicates> getDuplicates(){
        return finder.getDuplicates();
    }

    // Buscar lista de ficheiros inseridos
    public List<Document> getDocuments(){
        return finder.getDocuments();
    }

    // UNIVERSAL HASHING
    // Buscar k funções de hashing para serem usadas pelo Bloom Filter
    // Asseguram-se k funções de hashing diferentes da seguinte forma:
    // Sendo f(x) uma dada função de hash, f(x) = (ax + b) % p
    // a -> número gerado de forma pseudo-aleatória
    // b -> número gerado de forma pseudo-aleatória
    // p -> número primo "muito grande"
    public static Function<byte[], Integer>[] getHashFunctions(int m, int n){
        final int p = 1086216277; // big prime number
        int k = CountingBloomFilter.getOptimumK(m,n);
        Function[] res = new Function[k];
        for(int i = 0; i < k; i++){
            final int a = Math.round((float) Math.random() * (p - 1)) + 1;
            final int b = Math.round((float) Math.random() * (p - 1));
            res[i] = (arr) -> {
                int hash = Math.abs(Arrays.hashCode((byte[]) (arr))) % p;
                return Math.abs((((a * hash) + b) % p) % n);
            };
        }
        // Devolve-se o array de funções lambda
        return res;
    }

    // Buscar função de shingling para obtenção de shingles através dos dados do ficheiro
    // Devolve hashed shingles para facilitar o processo e permitir que SimilarFinder se mantenha genérico para qualquer tipo de documento (byte[], String, int, etc...)
    public static BiFunction<byte[], Integer, Iterator<Integer>> getShinglingFunc(){
        // Função lambda que representa a função de shingling
        return (bytes, k) -> {
            // HashSet para acelerar o processo de verificação se um determinado shingle já existe
            // Aumenta a velocidade do processo significativamente em relação a um processo iterativo
            HashSet<Integer> set = new HashSet<>();

            // Construir shingles com comprimento k
            for (int i = 0; i < bytes.length - k; i++) {
                byte[] shingle = Arrays.copyOfRange(bytes, i, i + k);

                // O adicionar à lista de shingles (Set, logo não permitirá valores repetidos)
                set.add(Arrays.hashCode(shingle));
            }
            // Devolver a lista de shingles
            return set.iterator();
        };
    }

    // Ler um determinado ficheiro e devolver o byte[] que representa os seus dados
    public static byte[] readFile(File f) throws IOException {
        FileInputStream fis = new FileInputStream(f);
        DataInputStream dis = new DataInputStream(fis);

        byte[] res = new byte[dis.available()];
        dis.read(res);

        dis.close();
        fis.close();

        return res;
    }
}
