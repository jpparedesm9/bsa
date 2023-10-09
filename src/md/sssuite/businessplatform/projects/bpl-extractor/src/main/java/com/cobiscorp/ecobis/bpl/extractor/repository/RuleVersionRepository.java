package com.cobiscorp.ecobis.bpl.extractor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;


public interface RuleVersionRepository extends JpaRepository<RuleVersion, Integer>{

	@Query("select rv from RuleVersion rv where rv.status ='PRO' and rv.rule in (:listRules)")
	List<RuleVersion> findByListRules(@Param("listRules") List<Rule> listRules);
	
	@Query("select MAX(rv.version) from RuleVersion rv where rv.rule = :rule")
	Integer findMaxVersion(@Param("rule") Rule rule);
	
	List<RuleVersion> findByRule(Rule rule);
}
