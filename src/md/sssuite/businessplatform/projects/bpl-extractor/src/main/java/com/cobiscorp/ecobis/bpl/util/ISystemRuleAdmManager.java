package com.cobiscorp.ecobis.bpl.util;

import java.util.HashMap;
import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule;

public interface ISystemRuleAdmManager {

	HashMap<String, SystemRule> hmSystemRule = new HashMap<String, SystemRule>();

	/**
	 * consulta un sistema
	 * 
	 * @param id
	 */
	public SystemRule find(Integer id);

	/**
	 * F inserta un sistema
	 * 
	 * @param systemRule
	 */
	public boolean insert(SystemRule systemRule);

	/**
	 * Busca todos los sistemas guardados
	 * 
	 * @param systemRule
	 */
	public List<SystemRule> queryAllSystems();

	/**
	 * @param variable
	 * @param dataSource
	 * @return
	 */
	SystemRule findAndSaveSystemRule(SystemRule systemRule, DriverManagerDataSource dataSource);
}
