package pt.ua.deti.es.l31.labproject.controllers;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import pt.ua.deti.es.l31.labproject.models.*;
import pt.ua.deti.es.l31.labproject.pubsub.KafkaProducer;

import java.util.*;

@Configuration
@EnableScheduling
@Component
public class ScheduledTasks {

    private final KafkaProducer producer;

    @Autowired
    public ScheduledTasks(KafkaProducer producer) {
        this.producer = producer;
    }

    private static String[] companies = new String[]{"AAPL", "MSFT", "GME", "TSLA", "GOOGL", "AMZN", "FB", "EBAY", "EA", "NVDA", "ZM", "XLNX", "MRNA"};
    private static final Logger log = LoggerFactory.getLogger(ScheduledTasks.class);
    private static Map<String, Quote> most_recent = new HashMap<>();

    public static List<Quote> getMost_recent() {
        List<Quote> res = new ArrayList<Quote>(most_recent.values());
        res.sort(Comparator.comparing(Quote::getCurrent).reversed());
        return res;
    }

    @Autowired private EntryRepository repository;

    @Autowired private SimpMessagingTemplate template;

    @Scheduled(fixedRate = 30000)
    public void getPricesPeriodically() {
        List<Quote> quotes = APIQueries.getLastQuotesFromCompanyNames(companies);
        for (Quote q : quotes){
            //q.changeCurrent();

            if (q.getCurrent() == q.getHigh()) {
                this.producer.send("events", q.getName() + " stock price has hit a new maximum value for the day");
            }
            if (q.getCurrent() == q.getHigh()) {
                this.producer.send("events", q.getName() + " stock price has hit a new minimum value for the day");
            }
            repository.saveAndFlush(new PriceEntry(q));
            if (most_recent.get(q.getName()) == null) {
                most_recent.put(q.getName(), q);
                q.setRawDelta(0);
                q.setPercentageDelta(0);
            }
            else{
                if (!(most_recent.get(q.getName()).getTimestamp() == q.getTimestamp())) {
                    double delta = q.getCurrent() - most_recent.get(q.getName()).getCurrent();
                    q.setRawDelta(delta);
                    double percentage = (delta/most_recent.get(q.getName()).getCurrent())*100;
                    if (percentage >= 0.05) {
                        this.producer.send("events", q.getName() + " stock price has increased by more than 0.05%");
                    }
                    if (percentage <= -0.05) {
                        this.producer.send("events", q.getName() + " stock price has decreased by more than 0.05%");
                    }
                    q.setPercentageDelta(percentage);
                    most_recent.put(q.getName(), q);
                }
                else{
                    q.setRawDelta(0);
                    q.setPercentageDelta(0);
                }
            }
        }
        for (Quote q : quotes){
            q.roundFields();
        }
        quotes.sort(Comparator.comparing(Quote::getCurrent).reversed());
        template.convertAndSend("/topic/quotes", new QuoteUpdate(System.currentTimeMillis() / 1000L, quotes));

        /*
        System.out.println("Every entry from Microsoft at the database");
        List<PriceEntry> result = repository.findByCompanySymbol("MSFT");
        for (PriceEntry p : result) {
            System.out.println(p);
        }
        */

        this.producer.send("events", "Stock ticker prices have been updated");
    }

    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        return builder.build();
    }
}
