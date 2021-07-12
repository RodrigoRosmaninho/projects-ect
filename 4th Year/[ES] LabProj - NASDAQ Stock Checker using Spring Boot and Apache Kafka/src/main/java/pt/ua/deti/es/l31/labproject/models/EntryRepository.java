package pt.ua.deti.es.l31.labproject.models;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntryRepository extends JpaRepository<PriceEntry, Integer> {

    List<PriceEntry> findByCompanySymbol(String CompanySymbol);

    List<PriceEntry> findTop100ByCompanySymbolOrderByEntryIdDesc(String CompanySymbol);

    List<PriceEntry> findTop13ByTimestamp(double t);

    List<PriceEntry> findByTimestampBetween(Long inf_time, Long sup_time);

}
