import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
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

public class SimilarFinder<T> {


    /*

      -- IMPORTANTE --

      -> Para assegurar que esta classe genérica funciona como esperado para qualquer tipo de dados (T), assume-se que a função de shingling retorna hashed shingles (int),
        já que tal não afeta o funcionamento do algoritmo de MinHashing nem o de LocalitySensitiveHashing.

      -> De forma a poupar memória e a acelerar o processo, não é gerada uma matriz de assinaturas.
        Ao invés, a cada shingle calculado para um dado documento são imediatamente aplicadas todas as funções de hashing.
        Os valores resultantes são comparados aos valores mínimos calculados para esse documento até então e registados como novos valores mínimos do documento caso sejam menores.

      -> Para gerar a assinatura de um dado documento usa-se os menores valores obtidos pelo hashing com diversas funções distintas (universal hashing).

    */

    // Lista de Documentos
    private List<Document> documents;
    // Função de shingling
    private BiFunction<T, Integer, Iterator<Integer>> getHashedShingles;
    // Comprimento (em tokens) de cada shingle
    private int k;
    // Número de hashFunctions a aplicar sobre os shingles para gerar a assinatura de cada documento
    private int hashFuncNumber;
    // Funções de hash a aplicar sobre os shingles para gerar a assinatura de cada documento
    private Function<Integer, Integer>[] hashFunctions;

    private LocalitySensitiveHashing lsh;

    private Class<T> type;

    // Inicialização
    public SimilarFinder(BiFunction<T, Integer, Iterator<Integer>> shinglingFunction, int k, int hashFuncNumber) {
        documents = new ArrayList<>();
        getHashedShingles = shinglingFunction;
        this.k = k;
        this.hashFuncNumber = hashFuncNumber;
        hashFunctions = getMinHashFunctions(hashFuncNumber);
        this.type = type;
        lsh = new LocalitySensitiveHashing(getMinHashFunctions(20), 20);
    }

    // -- Introdução de um novo documento --
    // Cálculo de todos os shingles distintos do elemento fornecido como argumento
    // É também fornecido o nome do documento a inserir, que é guardado para que se possa verificar se já existe ou eliminar se necessário
    public void insert(String docName, T t){
        // Verificar se já tinha sido inserido um documento com o mesmo nome
        // if(containsDocument(docName)) throw new IllegalArgumentException("Documento já foi adicionado!");
        Document d = new Document(docName, hashFunctions);

        // Calcular todos os shingles do documento
        Iterator<Integer> hashedShingles = getHashedShingles.apply(t, k);
        while(hashedShingles.hasNext()) d.insert(hashedShingles.next());

        // Adicionar documento à lista de documentos
        documents.add(d);
    }

    // Calcular qual o documento mais semelhante a um documento fornecido como argumento, através dos algoritmos de MinHashing e LocalitySensitiveHashing
    public MostSimilar getMostSimilar(Document d, List<Document> docList){
        double biggestSimilarity = 0;
        String recordHolder = "";

        // Iterar sobre todos os documentos candidatos a serem semelhantes ao documento alvo
        for(Document doc : lsh.getProbableMatches(d, docList)){
            int matching = 0;

            // Calcular quantos dos minHashValues de um documento são iguais aos do outro
            for(int i = 0; i < hashFuncNumber; i++){
                if(doc.getSmallestHashes()[i] == d.getSmallestHashes()[i]) matching++;
            }

            // Calcular o coeficiente de Jaccard (número de minHashValues iguais entre documentos / número de minHashValues num documento)
            double similarity = (double) matching / hashFuncNumber;

            // Verificar se o coeficiente de Jaccard calculada é a maior até então e, nesse caso, registá-la
            if(similarity > biggestSimilarity){
                biggestSimilarity = similarity;
                recordHolder = doc.getName();
            }
        }
        return new MostSimilar(1 - biggestSimilarity, recordHolder);
    }

    // Processar documento 'alvo' da mesma forma que os documentos adicionados até então
    public MostSimilar getMostSimilar(T t){
        Document d = new Document("target", hashFunctions);
        Iterator<Integer> hashedShingles = getHashedShingles.apply(t, k);
        while(hashedShingles.hasNext()) d.insert(hashedShingles.next());
        return getMostSimilar(d, documents);
    }

    // Devolver lista com todos os pares de ficheiros duplicados
    public List<Duplicates> getDuplicates(){
        List<Duplicates> res = new ArrayList<>(); // Lista de pares de ficheiros duplicados
        List<Document> docList = new ArrayList<>(documents); // Lista de documentos

        // Iterar sobre todos os ficheiros e devolver lista dos que têm Distância de Jaccard = 0.0
        for(int i = 0; i < docList.size(); i++){
            List<Document> tmp = new ArrayList<>(docList);
            tmp.remove(i);
            MostSimilar result = getMostSimilar(docList.get(i), tmp);
            if(result.getJaccardDistance() == 0.0) {
                Document[] arr = docList.toArray(new Document[docList.size()]);
                for(int j = 0; j < arr.length; j++) if(j != i && result.getDoc().equals(arr[j].getName())) {
                    docList.remove(j);
                    break;
                }
                res.add(new Duplicates(result.getJaccardDistance(), arr[i].getName(), result.getDoc()));
            }
        }

        return res;
    }

    // Devolver lista de documentos
    public List<Document> getDocuments() {
        return documents;
    }

    public List<Document> getLSHCandidates(T t){
        Document d = new Document("target", hashFunctions);
        Iterator<Integer> hashedShingles = getHashedShingles.apply(t, k);
        while(hashedShingles.hasNext()) d.insert(hashedShingles.next());
        return lsh.getProbableMatches(d, documents);
    }

    // Remover documento com um determinado nome (fornecido como argumento) da lista de documentos
    public boolean remove(String docName){
        Document[] arr = documents.toArray(new Document[documents.size()]);
        for(int i = 0; i < arr.length; i++){
            if(docName.equals(arr[i].getName())) {
                documents.remove(i);
                return true;
            }
        }
        return false;
    }

    // Verificar de forma iterativa se já existe um documento com um determinado nome, fornecido como argumento
    public boolean containsDocument(String docName){
        Document[] arr = documents.toArray(new Document[documents.size()]);
        for(int i = 0; i < arr.length; i++) if(docName.equals(arr[i].getName())) return true;
        return false;
    }

    // UNIVERSAL HASHING
    // Buscar k funções de hashing para serem usadas pelo algoritmo de MinHash
    // Asseguram-se k funções de hashing diferentes da seguinte forma:
    // Sendo f(x) uma dada função de hash, f(x) = (ax + b) % p
    // a -> número gerado de forma pseudo-aleatória
    // b -> número gerado de forma pseudo-aleatória
    // p -> número primo "muito grande"
    public static Function<Integer, Integer>[] getMinHashFunctions(int k){
        final int p = 1086216277; // big prime number
        Function[] res = new Function[k];
        for(int i = 0; i < k; i++){
            final int a = Math.round((float) Math.random() * (p - 1)) + 1;
            final int b = Math.round((float) Math.random() * (p - 1));
            res[i] = (index) -> {
                int hash = (int) index % p;
                return Math.abs((((a * hash) + b) % p));
            };
        }
        return res;
    }
}
