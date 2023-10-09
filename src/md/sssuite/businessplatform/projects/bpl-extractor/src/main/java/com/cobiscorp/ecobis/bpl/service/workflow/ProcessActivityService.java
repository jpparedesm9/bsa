package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface ProcessActivityService {

	/**
	 * Recupera el ProcessActivity por idProcess, version y idActivity
	 * 
	 * @return
	 */
	List<ProcessActivity> findProcessActivityByProcessVersion(Integer idProcess, Short versionProcess);

	ProcessVersion setProcessActivity(ProcessVersion processVersion, ProcessVersion newProcessversion, DriverManagerDataSource dataSource)
			throws Exception;

}
