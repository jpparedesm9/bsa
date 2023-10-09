package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryPersonalWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.utils.Utils;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public class SummaryPersonalWarrantiesDAOImpl implements SummaryPersonalWarrantiesDAO {
	private static ILogger logger = LogFactory.getLogger(SummaryPersonalWarrantiesDAOImpl.class);

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

	public SummaryPersonalWarrantiesDAOImpl() {
	}

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 8. Garantias Personales
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryPersonalWarrantiesDAO#
	 * getSummaryPersonalWarranties
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryPersonalWarranties(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYPERSONALWARRANTIESDAO.001", "getSummaryPersonalWarranties"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryPersonalWarranties.getSummaryPersonalWarranties", Object[].class)
					.setParameter("customer", key.getCustomer()).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYPERSONALWARRANTIESDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la lista de Garantías Personales.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYPERSONALWARRANTIESDAO.002", "getSummaryPersonalWarranties"));
		}
	}
}
