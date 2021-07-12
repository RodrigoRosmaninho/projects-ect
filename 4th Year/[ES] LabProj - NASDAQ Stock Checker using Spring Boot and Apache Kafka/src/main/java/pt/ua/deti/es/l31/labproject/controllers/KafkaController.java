package pt.ua.deti.es.l31.labproject.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pt.ua.deti.es.l31.labproject.pubsub.KafkaProducer;

import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
@RequestMapping(value = "/kafka")
public class KafkaController {

    private static final Logger logger = LoggerFactory.getLogger(KafkaController.class);
    private final KafkaProducer producer;

    @Autowired
    public KafkaController(KafkaProducer producer) {
        this.producer = producer;
    }

    @PostMapping(value = "/publish")
    public String sendMessageToKafkaTopic(@RequestParam("message") String message){
        this.producer.send("data", message);

        this.producer.send("logs", "Published data " + message);

        return "Published: " + message;
    }


}