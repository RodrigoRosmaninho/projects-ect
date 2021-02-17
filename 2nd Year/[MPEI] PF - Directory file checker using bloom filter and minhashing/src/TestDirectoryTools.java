import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.List;

 /*

    Métodos Probabilísticos para Engenharia Informática - 2018/2019
    Universidade de Aveiro

    Trabalho Prático
    Entregue a 11/12/2018

    Efetuado por:
    Rodrigo Rosmaninho - Nº MEC: 88802
    André Alves - Nº MEC: 88811

 */

public class TestDirectoryTools {
    static DirectoryTools directoryTools;

    public static void main(String[] args) throws IOException {
        System.out.println("\n*** Testes do Programa DirectoryTools (junção dos módulos) ***");
        System.out.println("\n** Leitura do diretório \"TestDirectory\" **");
        File dir = new File("TestDirectory");

        if(!dir.exists()){
            System.out.println("\n\n*** Erro! Não foi possível encontrar o diretório TestDirectory. Verifique! ***\n\n");
            System.exit(1);
        }

        File[] directory = dir.listFiles();
        int fileNumber = 0;
        // Verificar quantos ficheiros (passiveis de serem lidos) existem no diretório
        for (File f : directory) if (f.isFile() && f.canRead()) fileNumber++;
        if (fileNumber == 0) handleFatalError("O diretório escolhido não possui nenhum ficheiro que possa ser lido!");

        directoryTools = new DirectoryTools(fileNumber, 0.001); // 0.1%

        int size = 0;
        for(File f : directory){
            if(f.isFile() && f.canRead()){
                size += f.length();
                directoryTools.insert(f);
                System.out.println("Ficheiro \"" + f.getName() + "\" adicionado");
            }
        }
        System.out.println("Leitura terminada. " + fileNumber + " ficheiros.");

        System.out.println("\nTamanho do diretório (aproximado por contagem estocástica): " + String.format("%s B (%.2f MB)", directoryTools.getCounterResult(), (double) directoryTools.getCounterResult() / 1000000.0));
        System.out.println("Tamanho Real: " + String.format("%s B (%.2f MB)", size, (double) size / 1000000.0));

        System.out.println("\n** Verificação de pertença ao diretório **");
        File testDir = new File("TestFiles");
        File[] tests = new File[]{
                new File(dir, "about.html"),
                new File(dir, "Campus.jpg"),
                new File(dir, "ex4a.m"),
                new File(testDir, "about_ligeiramente_alterado.html"),
                new File(testDir, "REUA_sem_1_pagina.pdf")
        };
        if (Arrays.stream(tests).filter(f -> f.exists()).count() < tests.length) {
            System.out.println("\n\n*** Erro! Não foi possível encontrar o diretório TestFiles. Verifique! ***\n\n");
            System.exit(2);
        }

        boolean[] results = new boolean[tests.length];
        for (int i = 0; i < tests.length; i++) {
            Verify v = directoryTools.verifyFile(tests[i]);
            results[i] = v.isInBloomFilter();

            int length = new File(".").getAbsolutePath().length();
            String name = tests[i].getAbsolutePath().substring(length - 1);

            verifyFile(v, name);
        }

        testResult(Arrays.equals(results, new boolean[]{true, true, true, false, false}));

        System.out.println("\n** Remoção de um elemento **");
        File about = new File(dir, "about.html");
        File altered_about = new File(testDir, "about_mais_alterado.html");

        System.out.println("\nPre-remoção:");
        if(directoryTools.verifyFile(about).isInBloomFilter()) System.out.println("O ficheiro \"about.html\" pertence ao conjunto de ficheiros.");
        verifyFile(directoryTools.verifyFile(altered_about), "TestFiles/about_mais_alterado.html");

        directoryTools.remove(about);

        System.out.println("\nPos-remoção:");
        if(!directoryTools.verifyFile(about).isInBloomFilter()) System.out.println("O ficheiro \"about.html\" não pertence ao conjunto de ficheiros.");
        verifyFile(directoryTools.verifyFile(altered_about), "TestFiles/about_mais_alterado.html");

        testResult(!directoryTools.verifyFile(about).isInBloomFilter());

        System.out.println("\n** Contagem de adições ao BloomFilter **\n");
        tests = new File[]{
                new File(dir,"MPEI-2018-2019-TP17-minhash.pdf"),
                new File(dir,"ua_favicon.png"),
                new File(dir,"ex5 (copy).m")
        };

        int[] results2  = new int[tests.length];
        for(int i = 0; i < tests.length; i++) {
            results2[i] = directoryTools.count(tests[i]);
            if(results2[i] > 1) System.out.println("O ficheiro \"" + tests[i].getName() + "\" foi inserido " + results2[i] + " vezes.");
            else System.out.println("O ficheiro \"" + tests[i].getName() + "\" foi inserido 1 vez.");
        }

        testResult(Arrays.equals(results2, new int[]{1,1,2}));

        System.out.println("\n** Deteção de ficheiros duplicados **");

        List<Duplicates> list1 = directoryTools.getDuplicates();
        int length_list1 = list1.size();

        if(length_list1 > 0) System.out.println("\nO conjunto tem " + length_list1 + " par(es) de ficheiros duplicados:");
        for (Duplicates d : list1){
            System.out.println(d.getDoc1() + " == " + d.getDoc2());
            System.out.println("Distância de Jaccard: " + d.getJaccardDistance());
        }

        System.out.println("\nFicheiro \"ex5.m\" eliminado do conjunto.\nA correr o teste novamente...\n");
        directoryTools.remove(new File(dir, "ex5.m"));

        List<Duplicates> list2 = directoryTools.getDuplicates();
        int length_list2 = list2.size();

        if(length_list2 == 0) System.out.println("Não há ficheiros duplicados no conjunto.");

        testResult(length_list1 == 1 && length_list2 == 0);
    }

    // Mostrar mensagem de erro
    public static void handleError(String message){
        System.out.println("Erro: " + message);
    }

    // Mostrar mensagem de erro e terminar o programa
    public static void handleFatalError(String message){
        handleError(message);
        System.exit(1);
    }

    public static void testResult(boolean condition){
        if(condition) System.out.println("\n-> Os resultados deste teste estão conforme o esperado.");
        else System.out.println("\n-> Erro! Os resultados deste teste não estão conforme o esperado!");
    }

    public static void verifyFile(Verify v, String name){
        String message;
        // Se não pertence
        if(!v.isInBloomFilter()) {
            if(v.getMostSimilar().getJaccardDistance() <= 0.30) message = String.format("\nO ficheiro \"" + name + "\" não pertence ao diretório. No entanto, é semelhante ao ficheiro: %s\nDistância de Jaccard: %.4f", v.getMostSimilar().getDoc(), v.getMostSimilar().getJaccardDistance());
            else message = "\nO ficheiro \"" + name + "\" não pertence ao diretório, nem é suficientemente semelhante a algum dos ficheiros que pertence.";
        }
        // Se pertence
        else message = String.format("\nO ficheiro \"" + name + "\" pertence ao diretório. Provavelmente corresponde ao ficheiro: %s\nDistância de Jaccard: %.4f", v.getMostSimilar().getDoc(), v.getMostSimilar().getJaccardDistance());

        System.out.println(message);
    }
}
