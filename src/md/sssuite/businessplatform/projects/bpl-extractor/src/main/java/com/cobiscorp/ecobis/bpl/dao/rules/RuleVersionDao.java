package com.cobiscorp.ecobis.bpl.dao.rules;

import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;

public interface RuleVersionDao {

	/**
	 * @param idRule
	 * @return
	 */
	RuleVersion findLastVesionProcess(Integer idRule);

	void delete(RuleVersion ruleVersion);
	
	RuleVersion update(RuleVersion ruleVersion);

}
