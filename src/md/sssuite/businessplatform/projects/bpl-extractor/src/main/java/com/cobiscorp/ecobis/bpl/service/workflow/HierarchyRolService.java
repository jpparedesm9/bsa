package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;

public interface HierarchyRolService {

	static HashMap<String, HierarchyRol> hmHierarchyRol = new LinkedHashMap<String, HierarchyRol>();

	HierarchyRol insert(HierarchyRol hierarchyRol) throws Exception;

	Hierarchy setHierachyRolToHierarchy(Hierarchy hierarchy, Hierarchy newHierarchy, DriverManagerDataSource dataSource) throws Exception;

}
