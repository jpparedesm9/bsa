package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.dal.RateDAO;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO;
import com.cobiscorp.ecobis.clientviewer.dto.EnteDTO;
import com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RateDTO;

public class RatesDAOImpl implements RateDAO {

	private static ILogger logger = LogFactory.getLogger(RatesDAOImpl.class);

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

	public RatesDAOImpl() {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.RatesDAO#countRates()
	 */
	public Long countRates() {
		try {
			logger.logDebug("Execute countRates");
			return em.createNamedQuery("Rates.countRates", Long.class).getSingleResult();
		} catch (Exception ex) {
			logger.logError("An error occurred at countRates." + ex.getMessage(), ex);
		} finally {
			logger.logDebug("Finalize countRates");
		}
		return null;
	}

	@Override
	public List<RateDTO> getRateByClientId(Integer customer) {
		try {
			logger.logDebug("Execute getRatesByClientId");
			return em.createNamedQuery("RateOperation.getRateByClientId", RateDTO.class).setParameter("clientId", customer).getResultList();
		} catch (Exception ex) {
			logger.logError("An error occurred at getRatesByClientId." + ex.getMessage());
		} finally {
			logger.logDebug("Finalize getRatesByClientId");
		}

		return null;
	}

	@Override
	public List<AsfiViewDTO> getAsfiByClientId(Integer customer) {
		try {
			logger.logDebug("Execute getAsfiByClientId");
			return em.createNamedQuery("Ente.getAsfiByClientId", AsfiViewDTO.class).setParameter("ente", customer).getResultList();
		} catch (Exception ex) {
			logger.logError("An error occurred at getAsfiByClientId." + ex.getMessage());
		} finally {
			logger.logDebug("Finalize getAsfiByClientId");
		}

		return null;
	}

	@Override
	public List<InfoCredDTO> getInfoCredByClientId(Integer customer) {
		try {
			logger.logDebug("Execute getInfoCredByClientId");
			return em.createNamedQuery("Ente.getInfoCredByClientId", InfoCredDTO.class).setParameter("customer", customer).getResultList();
		} catch (Exception ex) {
			logger.logError("An error occurred at getInfoCredByClientId." + ex.getMessage());
		} finally {
			logger.logDebug("Finalize getInfoCredByClientId");
		}

		return null;
	}

	@Override
	public List<EnteDTO> getPortfolioRateByClientId(Integer customer) {
		try {
			logger.logDebug("Execute getPortfolioRateByClientId");
			return em.createNamedQuery("Ente.getPortfolioRate", EnteDTO.class).setParameter("customer", customer).getResultList();
		} catch (Exception ex) {
			logger.logError("An error occurred at getPortfolioRateByClientId." + ex.getMessage());
		} finally {
			logger.logDebug("Finalize getPortfolioRateByClientId");
		}

		return null;
	}
}
