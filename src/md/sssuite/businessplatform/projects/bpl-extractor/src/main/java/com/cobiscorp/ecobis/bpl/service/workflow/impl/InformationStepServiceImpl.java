package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.InformationStepDao;
import com.cobiscorp.ecobis.bpl.service.workflow.InformationStepService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.InformationStep;

public class InformationStepServiceImpl implements InformationStepService {

	private InformationStepDao informationStepDao;

	/**
	 * @return the informationStepDao
	 */
	public InformationStepDao getInformationStepDao() {
		return informationStepDao;
	}

	/**
	 * @param informationStepDao
	 *            the informationStepDao to set
	 */
	public void setInformationStepDao(InformationStepDao informationStepDao) {
		this.informationStepDao = informationStepDao;
	}

	public List<InformationStep> findByLink(Integer idStep) {
		return informationStepDao.findByLink(idStep);
	}

}
