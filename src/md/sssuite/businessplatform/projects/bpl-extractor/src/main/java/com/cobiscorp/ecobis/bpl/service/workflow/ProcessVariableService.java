package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface ProcessVariableService {

	HashMap<String, Programa> hmProgram = new HashMap<String, Programa>();
	HashMap<String, Variable> hmVariable = new HashMap<String, Variable>();

	/**
	 * Recupera los LAS variables del procesi por idProcess y version
	 * 
	 * @return
	 */
	List<ProcessVariable> findProcessVariableByProcessVersion(Integer idProcess, Short versionProcess);

	void buildProcessVariable(ProcessVersion processVersionOrigin, ProcessVersion processVersioDestination, DriverManagerDataSource dataSource) throws Exception;

	Programa findAndSaveProgram(Programa program, DriverManagerDataSource dataSource);

	Variable findAndSaveVariable(Variable variable, DriverManagerDataSource dataSource);

}
