package com.cobiscorp.ecobis.bpl.util;

import java.util.HashMap;
import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SubTypeRule;

public interface ISubTypeRuleAdmManager {

	HashMap<String, SubTypeRule> hmSubTypeRule = new HashMap<String, SubTypeRule>();

	/**
	 * consulta un subtype
	 * 
	 * @param id
	 */
	public SubTypeRule find(Integer id);

	/**
	 * inserta un subtype
	 * 
	 * @param systemRule
	 */
	public boolean insert(SubTypeRule subTypeRule);

	/**
	 * consulta todos los suptipos atadas a una condicion
	 * 
	 * @param id
	 */
	public List<SubTypeRule> findAll(Integer id);

	/**
	 * @param subTypeRule
	 * @param dataSource
	 * @return
	 */
	SubTypeRule findAndSaveSubTypeRule(SubTypeRule subTypeRule, DriverManagerDataSource dataSource);
}
