package pt.ua.deti.es.l31.labproject.controllers;


import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.web.bind.annotation.*;
import pt.ua.deti.es.l31.labproject.models.EntryRepository;
import pt.ua.deti.es.l31.labproject.models.PriceEntry;


@RestController
public class RestAPIController {

    private final EntryRepository repository;

    RestAPIController(EntryRepository repository) {
        this.repository = repository;
    }


    // Aggregate root
    // tag::get-aggregate-root[]
    @GetMapping("/company/{symb}")
    List<PriceEntry> values(@PathVariable String symb) {
        return repository.findByCompanySymbol(symb);
    }

    @GetMapping("/company/{symb}/last")
    PriceEntry lastValue(@PathVariable String symb) {
        List<PriceEntry> l = repository.findByCompanySymbol(symb);
        return l.get(l.size()-1);
    }

    @RequestMapping(path = "/company/interval", method = RequestMethod.GET)
    List<PriceEntry> intervalValues(@RequestParam String symb, @RequestParam Long inf, @RequestParam Long sup) {
        List<PriceEntry> l = repository.findByTimestampBetween(inf, sup);
        List<PriceEntry> new_list = l.stream().filter(pr -> pr.getCompanySymbol().equals(symb)).collect(Collectors.toList());
        return new_list;
    }


}
