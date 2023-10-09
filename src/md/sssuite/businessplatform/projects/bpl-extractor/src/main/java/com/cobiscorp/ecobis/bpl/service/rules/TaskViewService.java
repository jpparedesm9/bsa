package com.cobiscorp.ecobis.bpl.service.rules;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface TaskViewService {

	/**
	 * Recupera los TaskView por idProcess ,version y idActivity
	 * 
	 * @return
	 */
	List<TaskView> findTaskViewByProcessVersion(Integer idProcess, Short versionProcess);

	ProcessVersion setTaskViewToProcessVersion(ProcessVersion processVersion, ProcessVersion newProcessVersion, DriverManagerDataSource dataSource)
			throws Exception;

}
