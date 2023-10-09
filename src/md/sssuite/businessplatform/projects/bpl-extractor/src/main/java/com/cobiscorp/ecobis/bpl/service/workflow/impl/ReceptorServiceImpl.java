package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.ReceptorDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ReceptorService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Receptor;

public class ReceptorServiceImpl implements ReceptorService {

	private ReceptorDao receptorDao;

	/**
	 * @return the receptorDao
	 */
	public ReceptorDao getReceptorDao() {
		return receptorDao;
	}

	/**
	 * @param receptorDao
	 *            the receptorDao to set
	 */
	public void setReceptorDao(ReceptorDao receptorDao) {
		this.receptorDao = receptorDao;
	}

	public List<Receptor> findReceptorByStep(Integer idStep) {
		return receptorDao.findReceptorByStep(idStep);
	}

}
