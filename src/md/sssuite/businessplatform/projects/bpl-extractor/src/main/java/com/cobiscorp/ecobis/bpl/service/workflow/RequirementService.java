package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Requirement;

public interface RequirementService {
	static HashMap<String, Requirement> hmRequirement = new LinkedHashMap<String, Requirement>();

	List<Requirement> findAllRequirements() throws Exception;

	Requirement findRequirementByName(String name) throws Exception;

	Requirement saveRequirement(Requirement requirement) throws Exception;

	Requirement findAndSave(Requirement requirement, DriverManagerDataSource dataSource) throws Exception;

}
