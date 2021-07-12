package pt.ua.deti.es.l31.labproject.models;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sun.istack.NotNull;

import javax.persistence.*;

@JsonIgnoreProperties(ignoreUnknown = true)
@Entity
@Table(name = "PriceEntry")
public class PriceEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", columnDefinition = "int")
    private int entryId;

    @NotNull
    @Column(name = "company_symbol", columnDefinition = "VARCHAR(7)")
    private String companySymbol;

    @Column(name = "current_v", columnDefinition = "FLOAT(10)")
    private double current;

    @Column(name = "open_v", columnDefinition = "FLOAT(10)")
    private double open;

    @Column(name = "high_v", columnDefinition = "FLOAT(10)")
    private double high;

    @Column(name = "low_v", columnDefinition = "FLOAT(10)")
    private double low;

    @Column(name = "previous_v", columnDefinition = "FLOAT(10)")
    private double previous;

    @Column(name = "timestamp_v", columnDefinition = "int")
    private long timestamp;



    public PriceEntry() {
    }

    public PriceEntry(Quote q) {
        setCompanySymbol(q.getName());
        setCurrent(q.getCurrent());
        setOpen(q.getOpen());
        setHigh(q.getHigh());
        setLow(q.getLow());
        setPrevious(q.getPrevious());
        setTimestamp(q.getTimestamp());
    }

    public int getEntryID(){ return entryId;}
    public String getCompanySymbol(){ return companySymbol;}
    public double getCurrent(){ return current; }
    public double getOpen(){ return open; }
    public double getHigh(){ return high; }
    public double getLow(){ return low; }
    public double getPrevious(){ return previous; }
    public long getTimestamp(){ return timestamp; }

    public void setCompanySymbol(String CompanySymbol){
        this.companySymbol = CompanySymbol;
    }
    public void setCurrent(double Current){
        this.current = Current;
    }
    public void setOpen(double Open){
        this.open = Open;
    }
    public void setHigh(double High){
        this.high = High;
    }
    public void setLow(double Low){
        this.low = Low;
    }
    public void setPrevious(double Previous){
        this.previous = Previous;
    }
    public void setTimestamp(long Timestamp){
        this.timestamp = Timestamp;
    }

    @Override
    public String toString() {
        return "PriceEntry{" +
                "EntryID=" + entryId +
                ", companySymbol='" + companySymbol + '\'' +
                ", current=" + current +
                ", open=" + open +
                ", high=" + high +
                ", low=" + low +
                ", previous=" + previous +
                ", timestamp=" + timestamp +
                '}';
    }
}


