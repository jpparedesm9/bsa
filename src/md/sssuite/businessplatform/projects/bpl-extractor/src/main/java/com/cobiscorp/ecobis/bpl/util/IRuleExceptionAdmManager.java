package com.cobiscorp.ecobis.bpl.util;

import java.util.List;

import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleException;

public interface IRuleExceptionAdmManager {
	/**
	 * consulta una exception
	 * 
	 * @param id
	 */
	public RuleException find(int id);
	
	/**
	 * consulta todas las excepciones atadas a una condicion
	 * 
	 * @param id
	 */
	public List<RuleException> findAll(Integer id);
	
	/**
	 * inserta una exception
	 * 
	 * @param RuleException
	 */
	public RuleException insert(RuleException ruleException);
	
}
