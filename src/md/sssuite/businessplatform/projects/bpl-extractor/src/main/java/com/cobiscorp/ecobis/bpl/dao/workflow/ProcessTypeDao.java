package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;

public interface ProcessTypeDao {

	/**
	 * Recupera el ProcessType por idProcess
	 * 
	 * @return
	 */
	List<ProcessType> findByProcess(Integer idProcess);

}
