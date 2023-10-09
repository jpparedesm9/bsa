package com.cobiscorp.ecobis.commons.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.commons.dal.GeneralParameterDAO;
import com.cobiscorp.ecobis.commons.dal.entities.GeneralParameter;
import com.cobiscorp.ecobis.commons.dal.entities.GeneralParameterId;

public class GeneralParameterDAOImpl implements GeneralParameterDAO {

	private static ILogger logger = LogFactory
			.getLogger(GeneralParameterDAOImpl.class);

	private EntityManager em;

	public GeneralParameterDAOImpl() {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.commons.dal.GeneralParameterDAO#getParameter(com
	 * .cobiscorp.ecobis.commons.dal.entities.GeneralParameterId)
	 */
	public GeneralParameter getParameter(GeneralParameterId key) {
		try {
			logger.logDebug("Execute getParameter");
			return em
					.createNamedQuery("GeneralParameter.getParameter",
							GeneralParameter.class)
					.setParameter("product", key.getProduct())
					.setParameter("mnemonic", key.getMnemonic())
					.getSingleResult();
		} catch (Exception ex) {
			logger.logError("An error occurred at getParameter."
					+ ex.getMessage());
		} finally {
			logger.logDebug("Finalize getParameter");
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.commons.dal.GeneralParameterDAO#getParameterByMnemonic
	 * (com.cobiscorp.ecobis.commons.dal.entities.GeneralParameterId)
	 */
	public GeneralParameter getParameterByMnemonic(GeneralParameterId key) {
		try {
			logger.logDebug("Execute getParameterByNemonic");

			List<GeneralParameter> objGeneralParam = em
					.createNamedQuery("GeneralParameter.getParameterByNemonic",
							GeneralParameter.class)
					.setParameter("mnemonic", key.getMnemonic())
					.getResultList();

			if (objGeneralParam.size() > 0) {
				return objGeneralParam.get(0);
			}
			return null;

		} catch (Exception ex) {
			logger.logError("An error occurred at getParameterByNemonic."
					+ ex.getMessage());
		} finally {
			logger.logDebug("Finalize getParameterByNemonic");
		}
		return null;
	}

	@PersistenceContext(unitName = "JpaCommonsServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

}
