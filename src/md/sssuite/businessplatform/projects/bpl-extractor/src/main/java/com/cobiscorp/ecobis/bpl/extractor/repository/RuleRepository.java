package com.cobiscorp.ecobis.bpl.extractor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

public interface RuleRepository extends JpaRepository<Rule, Integer>{
	
	@Query("select r from Rule r JOIN r.ruleVersions rv where rv.status ='PRO'")
	List<Rule> findProductionRules();
	
	
	@Query("select r from Rule r JOIN r.ruleVersions rv where rv.status ='DIS' and r.acronym = :acronym")
	Rule findDesingRulesByAcronym(@Param("acronym") String acronym);

	
	Rule findByAcronym(String acronym);
	
	Rule findByName(String name);
	
}
