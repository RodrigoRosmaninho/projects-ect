package pt.ua.deti.es.l31.labproject.models;

import java.util.List;

public class QuoteUpdate {
    private long timestamp;
    private List<Quote> quotes;

    public QuoteUpdate(long timestamp, List<Quote> quotes) {
        this.timestamp = timestamp;
        this.quotes = quotes;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public List<Quote> getQuotes() {
        return quotes;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public void setQuotes(List<Quote> quotes) {
        this.quotes = quotes;
    }
}
