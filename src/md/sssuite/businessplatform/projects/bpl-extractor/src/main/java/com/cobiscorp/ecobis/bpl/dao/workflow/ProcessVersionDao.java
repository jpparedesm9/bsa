package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface ProcessVersionDao {

	/**
	 * Recupera todas la versiones de procesos que estan en produccion
	 * 
	 * @return
	 */
	List<ProcessVersion> findProductionProcessVersion();

	ProcessVersion findProcessVersionById(Integer idProcess, Short versionProcess) throws Exception;

	ProcessVersion findByNameAndStatus(String name, String status);

	ProcessVersion findByName(String name);

	ProcessVersion findLastVesionProcess(Integer idProcess);

}
