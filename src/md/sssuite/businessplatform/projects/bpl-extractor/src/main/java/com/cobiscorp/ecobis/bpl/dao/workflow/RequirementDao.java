package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Requirement;

/**
 * @author srojas
 * 
 */
public interface RequirementDao {

	static HashMap<String, Requirement> hmRequirement = new LinkedHashMap<String, Requirement>();

	/**
	 * @description Find all requirements
	 * @return
	 */
	List<Requirement> findAllRequirements() throws Exception;

	/**
	 * @description Find a requirement by name
	 * @param name
	 * @return
	 */
	Requirement findRequirementByName(String name) throws Exception;

	/**
	 * @description Save requirement
	 * @param requirement
	 * @return
	 * @throws Exception
	 */
	Requirement saveRequirement(Requirement requirement) throws Exception;

	/**
	 * @param requirement
	 * @param dataSource
	 * @return
	 * @throws Exception
	 */
	Requirement findAndSave(Requirement requirement, DriverManagerDataSource dataSource) throws Exception;
}
