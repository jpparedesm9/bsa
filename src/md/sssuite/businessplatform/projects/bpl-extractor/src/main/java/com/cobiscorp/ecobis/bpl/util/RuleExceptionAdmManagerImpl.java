package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleException;

public class RuleExceptionAdmManagerImpl implements IRuleExceptionAdmManager {

	private ExceptionRuleDAO exceptionRuleDAO;
	private SeqnosProcedureManager seqnosQuery;

	public void setSeqnosQuery(SeqnosProcedureManager seqnosQuery) {
		this.seqnosQuery = seqnosQuery;
	}

	public void setExceptionRuleDAO(ExceptionRuleDAO exceptionRuleDAO) {
		this.exceptionRuleDAO = exceptionRuleDAO;
	}

	public RuleException find(int id) {
		return exceptionRuleDAO.find(id);
	}
	
	public RuleException insert(RuleException ruleException) {

		return exceptionRuleDAO.insert(ruleException);
	}

	public List<RuleException> findAll(Integer id) {
		return exceptionRuleDAO.findAll(id);
	}

}
