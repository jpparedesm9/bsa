package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;
import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface ProcessVersionService {
	
	HashMap<Integer, ProcessVersion> hmProcessVersion = new HashMap<Integer, ProcessVersion>();

	List<ProcessVersion> findProductionProcessVersion();

	ProcessVersion findProcessVersionById(Integer idProcess, Short versionProcess) throws Exception;

	ProcessVersion findLastVesionProcess(Integer idProcess);
}
