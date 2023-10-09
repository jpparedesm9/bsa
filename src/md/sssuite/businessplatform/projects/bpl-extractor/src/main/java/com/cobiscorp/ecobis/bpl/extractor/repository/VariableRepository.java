package com.cobiscorp.ecobis.bpl.extractor.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

public interface VariableRepository  extends JpaRepository<Variable, Short>{

	Variable findByAbreviaturaVariable(String abreviaturaVariable);
	
}

