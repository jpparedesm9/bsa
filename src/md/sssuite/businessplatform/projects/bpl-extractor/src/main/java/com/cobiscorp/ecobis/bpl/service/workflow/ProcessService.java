package com.cobiscorp.ecobis.bpl.service.workflow;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface ProcessService {

	Process findAndSave(ProcessVersion processVersion, ApplicationContext context, DriverManagerDataSource dataSource) throws Exception;
	
	Process findByName(String name);

}
