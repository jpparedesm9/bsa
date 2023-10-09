package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

public interface VariableDao {

	Variable findByAbreviaturaVariable(String abreviaturaVariable);

	Variable saveAndFlush(Variable variable);
	
	Variable findById(Short idVariable);

}
