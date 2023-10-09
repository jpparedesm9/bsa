package com.cobiscorp.ecobis.bpl.extractor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cobiscorp.ecobis.bpl.rules.engine.model.ConditionRule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;


public interface ConditionRuleRepository extends JpaRepository<ConditionRule, Integer>{


	@Query("select cr from ConditionRule cr where  cr.ruleVersion in (:listRulesVersion)")
	List<ConditionRule> findByListRulesVersion(@Param("listRulesVersion") List<RuleVersion> listRulesVersion);
	
	List<ConditionRule> findByRuleVersion(
			@Param("ruleVersion") RuleVersion ruleVersion);
}
