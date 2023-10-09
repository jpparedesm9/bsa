package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

public interface VariableService {

	HashMap<String, Variable> hmVariable = new HashMap<String, Variable>();

	Variable findAndSaveVariable(Variable variable, DriverManagerDataSource dataSource);
	
	Variable findByAbreviaturaVariable(String abreviaturaVariable);
	
	Variable saveAndFlush(Variable variable);
	
	Variable findById(Short idVariable);

}
