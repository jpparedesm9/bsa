package com.cobiscorp.ecobis.commons.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.commons.dal.CurrencyDAO;
import com.cobiscorp.ecobis.commons.dal.entities.Currency;

public class CurrencyDAOImpl implements CurrencyDAO {

	private static ILogger logger = LogFactory.getLogger(CurrencyDAOImpl.class);
	
	private EntityManager em;

	public CurrencyDAOImpl() {

	}
	
	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param em
	 */
	@PersistenceContext(unitName = "JpaCommonsServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

	/*
	 * (non-Javadoc)
	 * @see com.cobiscorp.ecobis.commons.dal.CurrencyDAO#getAllCurrencies()
	 */
	public List<Currency> getAllCurrencies() {
		try {
			logger.logDebug("Execute getAllCurrencies");
			// Find the available currencies in the core tables
			return em.createNamedQuery("Currency.getAllValidCurrencies",
					Currency.class).getResultList();

		} catch (Exception ex) {
			logger.logError("An error occurred at obtain the available currencies.");
		} finally {
			logger.logDebug("Finalize getAllCurrencies");
		}
		return null;
	}

}
