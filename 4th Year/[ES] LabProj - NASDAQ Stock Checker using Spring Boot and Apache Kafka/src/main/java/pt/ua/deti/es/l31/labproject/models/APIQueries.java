package pt.ua.deti.es.l31.labproject.models;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

public class APIQueries {

    private static final Logger log = LoggerFactory.getLogger(APIQueries.class);

    public static List<Quote> getLastQuotesFromCompanyNames(String[] companies){
        List<Quote> quotes = new ArrayList<Quote>();
        RestTemplate restTemplate = new RestTemplate();
        for (String company : companies) {
            Quote quote = restTemplate.getForObject(
                    "https://finnhub.io/api/v1/quote?symbol=" + company + "&token=c1d79r748v6p64720ml0", Quote.class);
            quote.setName(company);
            quote.setTimestamp(System.currentTimeMillis() / 1000L);
            log.info(quote.toString());
            quotes.add(quote);
        }
        return quotes;
    }

}
