package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessTypeDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessTypeService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;

public class ProcessTypeServiceImpl implements ProcessTypeService {

	private ProcessTypeDao processTypeDao;

	/**
	 * @return the processTypeDao
	 */
	public ProcessTypeDao getProcessTypeDao() {
		return processTypeDao;
	}

	/**
	 * @param processTypeDao
	 *            the processTypeDao to set
	 */
	public void setProcessTypeDao(ProcessTypeDao processTypeDao) {
		this.processTypeDao = processTypeDao;
	}

	public List<ProcessType> findByProcess(Integer idProcess) {
		return processTypeDao.findByProcess(idProcess);
	}

}
