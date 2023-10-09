package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyTypeTpl;

public interface HierarchyTypeTplService {

	HashMap<String, HierarchyTypeTpl> hmHierarchyTypeTpl = new HashMap<String, HierarchyTypeTpl>();

	/**
	 * Recupera el HierarchyItem por idStep
	 * 
	 * @return
	 */
	HierarchyTypeTpl findById(Integer idHierarchyTypeTpl);

	HierarchyTypeTpl findAndSave(HierarchyTypeTpl ihierarchyTypeTpl, DriverManagerDataSource dataSource);

}
