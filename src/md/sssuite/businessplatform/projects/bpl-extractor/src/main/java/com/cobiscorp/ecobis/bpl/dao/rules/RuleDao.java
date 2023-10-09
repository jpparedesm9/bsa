package com.cobiscorp.ecobis.bpl.dao.rules;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

public interface RuleDao {

	/**
	 * Recupera los TaskView por idProcess ,version y idActivity
	 * 
	 * @return
	 */
	Rule findByAcronym(String acronym);

	/**
	 * @param rule
	 */
	void detach(Rule rule);
	
	Rule insert(Rule rule);
	
	Rule update(Rule rule);

}
