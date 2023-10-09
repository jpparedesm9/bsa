package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleException;

public interface ExceptionRuleDAO {

	public abstract RuleException find(int id);

	public abstract List<RuleException> findAll(Integer id);

	public abstract RuleException insert(RuleException ruleException);

}
