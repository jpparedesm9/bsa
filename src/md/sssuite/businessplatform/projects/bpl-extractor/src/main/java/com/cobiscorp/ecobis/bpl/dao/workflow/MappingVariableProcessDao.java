package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.MappingVariableProcess;

public interface MappingVariableProcessDao {

	/**
	 * Recupera el MappingVariableProcess por idProcess y version
	 * 
	 * @return
	 */
	List<MappingVariableProcess> findMappingVariableProcessByProcessVersion(Integer idProcess, Short versionProcess);

}
