package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryOthersDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;

public class SummaryOthersDAOImpl implements SummaryOthersDAO {

	private static ILogger logger = LogFactory.getLogger(SummaryOthersDAOImpl.class);

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

	public SummaryOthersDAOImpl() {
	}

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 10. Otros Contingentes
	public List<SummaryOtherDTO> getAllOtherContingencies(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYOTHERSDAO.001", "getAllOtherContingencies"));
			return em.createNamedQuery("SummaryOther.getAllOtherContingencies", SummaryOtherDTO.class).setParameter("user", key.getUser())
					.setParameter("sequence", key.getSequence()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYOTHERSDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la lista de Otros Contingentes.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYOTHERSDAO.002", "getAllOtherContingencies"));
		}
	}
}
