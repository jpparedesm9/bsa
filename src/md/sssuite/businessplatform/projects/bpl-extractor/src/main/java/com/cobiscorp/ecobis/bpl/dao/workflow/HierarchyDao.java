package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;

public interface HierarchyDao {

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
	 * @param hierarchy
	 * @return
	 */
	Hierarchy insert(Hierarchy hierarchy);

	/**
	 * @description Busca una Jerarquia por id de proceso, versión, y nombre de proceso
	 * @param idProcess
	 * @param version
	 * @param hierarchyName
	 * @return
	 * @throws Exception
	 */
	Hierarchy findHierarchyByProcessVersionAndName(Integer idProcess, Short version, String hierarchyName) throws Exception;

}
