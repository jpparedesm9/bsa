package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;

public interface HierarchyRolDao {

	/**
	 * Recupera Hierarchy por Id
	 * 
	 * @param idHierarchy
	 * @return
	 */
	HierarchyRol findById(Integer idHierarchyRol);

	/**
	 * @param hierarchy
	 * @return
	 */
	HierarchyRol insert(HierarchyRol hierarchyRol);

	/**
	 * @description Busca un rol jerarqu�a por id de proceso, versi�n, e id de la jerarqu�a
	 * @param idProcess
	 * @param version
	 * @param idHierarchy
	 * @return
	 * @throws Exception
	 */

	// HierarchyRol findByProcessVersionRoleAndHierarchy(Integer idProcess, Short version, Integer role, Integer idHierarchy) throws Exception;

	HierarchyRol findByProcessVersionHierarchyAndRole(Integer idProcess, Short version, Integer idHierarchy, Integer idRole) throws Exception;

}
