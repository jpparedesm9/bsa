package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface HierarchyService {

	/**
	 * Recupera las Hierarchys del procesi por idProcess y version
	 * 
	 * @return
	 */
	List<Hierarchy> findHierarchyByProcessVersion(Integer idProcess, Short version);

	/**
	 * Recupera Hierarchy por Id
	 * 
	 * @param idHierarchy
	 * @return
	 */
	Hierarchy findById(Integer idHierarchy);

	/**
	 * @param processVersion
	 * @param newProcessVersion
	 * @param dataSource
	 * @return
	 * @throws Exception
	 */
	ProcessVersion setHierarchyToProcessVersion(ProcessVersion processVersion, ProcessVersion newProcessVersion, DriverManagerDataSource dataSource)
			throws Exception;
	
	Hierarchy findHierarchyByProcessVersionAndName(Integer idProcess, Short version, String hierarchyName) throws Exception;

}
