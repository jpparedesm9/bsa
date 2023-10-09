package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;

public interface ProcessVariableDao {

	/**
	 * Recupera los LAS variables del procesi por idProcess y version
	 * 
	 * @return
	 */
	List<ProcessVariable> findProcessVariableByProcessVersion(Integer idProcess, Short versionProcess);

}
