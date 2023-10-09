package com.cobiscorp.ecobis.clientviewer.dal.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.IScoreDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;

public class ScoreDAOImpl implements IScoreDAO {

	private static ILogger logger = LogFactory.getLogger(SummaryCreditsDAOImpl.class);

	private EntityManager em;

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param em
	 */

	public ScoreDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "JpaClientViewerServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

	@Override
	public ScoreDTO getScoreCustomer(Integer idCustomer) {
		try {
			logger.logDebug(MessageManager.getString("SCORECUSTOMER.001", "getScoreCustomer"));

			return em.createNamedQuery("Score.getScoreCustomer", ScoreDTO.class).setParameter("idCustomer", idCustomer).getSingleResult();

		} catch (NoResultException ex) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMER.002"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMER.003", "getScoreCustomer"));
		}
	}

	@Override
	public ClienteCalificacionDTO getPunctuationCustomer(Integer idCustomer) {
		try {
			logger.logDebug(MessageManager.getString("SCORECUSTOMER.001", "getPunctuationCustomer"));

			return em.createNamedQuery("ClienteCalificacion.getPunctuationCustomer", ClienteCalificacionDTO.class).setParameter("idCustomer", idCustomer).getSingleResult();

		} catch (NoResultException ex) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMER.002"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMER.003", "getScoreCustomer"));
		}
	}

}
