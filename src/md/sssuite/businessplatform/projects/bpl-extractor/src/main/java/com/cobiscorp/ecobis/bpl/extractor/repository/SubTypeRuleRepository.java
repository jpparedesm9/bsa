package com.cobiscorp.ecobis.bpl.extractor.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;

public interface SubTypeRuleRepository extends JpaRepository<SubTypeRule, Integer> {

}
