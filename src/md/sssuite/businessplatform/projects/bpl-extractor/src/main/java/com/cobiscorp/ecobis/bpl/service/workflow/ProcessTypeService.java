package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;

public interface ProcessTypeService {

	/**
	 * Recupera el ProcessType por idProcess
	 * 
	 * @return
	 */
	List<ProcessType> findByProcess(Integer idProcess);

}
