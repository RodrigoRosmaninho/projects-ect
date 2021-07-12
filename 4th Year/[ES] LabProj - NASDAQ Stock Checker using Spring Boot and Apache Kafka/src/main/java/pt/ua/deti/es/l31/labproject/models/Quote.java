package pt.ua.deti.es.l31.labproject.models;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Quote {
    private Double current;
    private Double open;
    private Double high;
    private Double low;
    private Double previous;
    private int pTimestamp;

    private long timestamp;
    private String name;
    private Double raw_delta;
    private Double percentage_delta;

    private String graph_values;

    public Quote() {
    }

    public Quote(PriceEntry entry) {
        this.name = entry.getCompanySymbol();
        this.current = entry.getCurrent();
        this.open = entry.getOpen();
        this.high = entry.getHigh();
        this.low = entry.getLow();
        this.previous = entry.getPrevious();
        this.timestamp = entry.getTimestamp();
        this.raw_delta = 0.0;
        this.percentage_delta = 0.0;
    }

    public void changeCurrent(){
        current = current + 10*Math.random();
    }

    public void roundFields(){
        this.current = Math.round(current * 100.0) / 100.0;
        this.open = Math.round(open * 100.0) / 100.0;
        this.high = Math.round(high * 100.0) / 100.0;
        this.low = Math.round(low * 100.0) / 100.0;
        this.previous = Math.round(previous * 100.0) / 100.0;
        this.raw_delta = Math.round(raw_delta * 100.0) / 100.0;
        this.percentage_delta = Math.round(percentage_delta * 100.0) / 100.0;
    }

    @JsonProperty("c")
    public Double getCurrent() {
        return current;
    }

    @JsonProperty("o")
    public Double getOpen() {
        return open;
    }

    @JsonProperty("h")
    public Double getHigh() {
        return high;
    }

    @JsonProperty("l")
    public Double getLow() {
        return low;
    }

    @JsonProperty("pc")
    public Double getPrevious() {
        return previous;
    }

    @JsonProperty("t")
    public int getpTimestamp() {
        return pTimestamp;
    }

    public String getName() {
        return name;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public double getRawDelta(){ return raw_delta; }

    public double getPercentageDelta(){ return percentage_delta; }

    public String getGraphValues(){ return graph_values; }

    @JsonProperty("c")
    public void setCurrent(Double current) {
        this.current = current;
    }

    @JsonProperty("o")
    public void setOpen(Double open) {
        this.open = open;
    }

    @JsonProperty("h")
    public void setHigh(Double high) {
        this.high = high;
    }

    @JsonProperty("l")
    public void setLow(Double low) {
        this.low = low;
    }

    @JsonProperty("pc")
    public void setPrevious(Double previous) {
        this.previous = previous;
    }

    @JsonProperty("t")
    public void setpTimestamp(int pTimestamp) {
        this.pTimestamp = pTimestamp;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public void setRawDelta(double rawDelta){ this.raw_delta = rawDelta; }

    public void setPercentageDelta(double percentageDelta){ this.percentage_delta = percentageDelta; }

    public void setGraphValues(String v){ graph_values = v;}

    @Override
    public String toString() {
        return "Quote{" +
                "name='" + name +
                ", current=" + current +
                ", open=" + open +
                ", high=" + high +
                ", low=" + low +
                ", previous=" + previous +
                ", pTimestamp=" + pTimestamp +
                ", timestamp=" + timestamp + '\'' +
                '}';
    }
}
