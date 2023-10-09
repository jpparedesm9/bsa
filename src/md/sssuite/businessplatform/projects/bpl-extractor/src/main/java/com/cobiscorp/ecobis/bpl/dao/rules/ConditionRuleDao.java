package com.cobiscorp.ecobis.bpl.dao.rules;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.ConditionRule;

public interface ConditionRuleDao {

	/**
	 * Recupera los TaskView por idProcess ,version y idActivity
	 * 
	 * @return
	 */
	void delete(ConditionRule conditionRule);

	List<ConditionRule> findByRuleVersion(Integer idRuleVersion);

}
