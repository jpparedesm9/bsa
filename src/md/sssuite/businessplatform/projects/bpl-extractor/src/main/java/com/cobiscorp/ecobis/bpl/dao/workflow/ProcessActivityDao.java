package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;

public interface ProcessActivityDao {

	/**
	 * Recupera el ProcessActivity por idProcess, version y idActivity
	 * 
	 * @return
	 */
	List<ProcessActivity> findProcessActivityByProcessVersion(Integer idProcess, Short versionProcess);

}
