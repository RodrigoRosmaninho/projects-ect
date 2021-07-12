package pt.ua.deti.es.l31.labproject.controllers;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pt.ua.deti.es.l31.labproject.models.*;
import java.util.*;

@Controller
public class GreetingController {

    String[] companies = new String[]{"AAPL", "MSFT", "GME", "TSLA", "GOOGL", "AMZN", "FB", "EBAY", "EA", "NVDA", "ZM", "XLNX", "MRNA"};

    private static final Logger log = LoggerFactory.getLogger(GreetingController.class);
    @Autowired private EntryRepository repository;

    @RequestMapping("/")
    public String template(Model model) {
        List<Quote> quotes = ScheduledTasks.getMost_recent();
        for (int i = 0; i<quotes.size(); i++){
            String symb = quotes.get(i).getName();
            List<PriceEntry> l = repository.findTop100ByCompanySymbolOrderByEntryIdDesc(symb);
            Double[] values = new Double[100];
            for (int w = 0; w<100; w++){
                values[99-w] = l.get(w).getCurrent();
            }
            quotes.get(i).setGraphValues(convertToArrayJavascript(values));
            quotes.get(i).roundFields();
        }
        model.addAttribute("companies", quotes);

        return "template";
    }

    private String convertToArrayJavascript(Double[] a){
        String start = "[";
        for (int i = 0; i<a.length-1; i++){
            start = start+""+a[i]+" ,";
        }
        start = start+""+a[a.length-1]+" ]";
        return start;
    }
}
