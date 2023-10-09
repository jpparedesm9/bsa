package com.cobiscorp.ecobis.clientviewer.dal.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.CurrencyDAO;
import com.cobiscorp.ecobis.clientviewer.dal.entities.Currency;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;

public class CurrencyDAOImpl implements CurrencyDAO {

	private static ILogger logger = LogFactory.getLogger(CurrencyDAOImpl.class);

	private EntityManager em;

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param em
	 */
	@PersistenceContext(unitName = "JpaClientViewerServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

	public CurrencyDAOImpl() {
	}

	@Override
	public Currency getCurrencyById(Integer id) {

		try {

			return em.find(Currency.class, id);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.099"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug("Termina la ejecución del método getCurrencyById");
		}
	}

}
