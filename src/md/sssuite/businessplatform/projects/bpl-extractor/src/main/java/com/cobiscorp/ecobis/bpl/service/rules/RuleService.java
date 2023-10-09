package com.cobiscorp.ecobis.bpl.service.rules;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

public interface RuleService {

	Rule findAndSave(Rule rule, ApplicationContext context, DriverManagerDataSource dataSource);

}
