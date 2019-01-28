/*

   Métodos Probabilísticos para Engenharia Informática - 2018/2019
   Universidade de Aveiro

   Trabalho Prático
   Entregue a 11/12/2018

   Efetuado por:
   Rodrigo Rosmaninho - Nº MEC: 88802
   André Alves - Nº MEC: 88811

*/

public abstract class Results {
    private double jaccardDistance;

    public Results(double jaccardDistance){
        this.jaccardDistance = jaccardDistance;
    }

    public double getJaccardDistance() {
        return jaccardDistance;
    }
}

class MostSimilar extends Results{
    private String doc;

    public MostSimilar(double jaccardDistance, String doc) {
        super(jaccardDistance);
        this.doc = doc;
    }

    public String getDoc() {
        return doc;
    }
}

class Verify {
    private MostSimilar mostSimilar;
    private boolean inBloomFilter;

    public Verify(MostSimilar mostSimilar, boolean inBloomFilter) {
        this.mostSimilar = mostSimilar;
        this.inBloomFilter = inBloomFilter;
    }

    public MostSimilar getMostSimilar() {
        return mostSimilar;
    }

    public boolean isInBloomFilter() {
        return inBloomFilter;
    }
}

class Duplicates extends Results{
    private String doc1;
    private String doc2;

    public Duplicates(double jaccardDistance, String doc1, String doc2) {
        super(jaccardDistance);
        this.doc1 = doc1;
        this.doc2 = doc2;
    }

    public String getDoc1() {
        return doc1;
    }

    public String getDoc2() {
        return doc2;
    }
}