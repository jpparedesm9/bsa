package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public interface StepService {

	static HashMap<String, Step> hmStep = new LinkedHashMap<String, Step>();
	static HashMap<Integer, Step> hmStepNew = new LinkedHashMap<Integer, Step>();

	/**
	 * Recupera los steps por idProcess y version
	 * 
	 * @return
	 */
	List<Step> findStepByProcessVersion(Integer idProcess, Short version);

	Step saveStep(Step step, Step newStep, ProcessVersion processVersion, ApplicationContext context, DriverManagerDataSource dataSource)
			throws Exception;

}
