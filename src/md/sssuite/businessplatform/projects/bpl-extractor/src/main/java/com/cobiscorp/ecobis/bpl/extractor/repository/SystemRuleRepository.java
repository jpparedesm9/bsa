package com.cobiscorp.ecobis.bpl.extractor.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule;

public interface SystemRuleRepository extends JpaRepository<SystemRule, Integer> {

}
