package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.utils.Utils;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public class SummaryCreditsDAOImpl implements SummaryCreditsDAO {

	private static ILogger logger = LogFactory.getLogger(SummaryCreditsDAOImpl.class);

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

	public SummaryCreditsDAOImpl() {
	}

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 9. Contingentes
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO#
	 * getSummaryContingencies
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryContingencies(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYCREDITSDAO.001", "getSummaryContingencies"));

			List<ConsolidatePositionDTO> allSummaryContingencies = Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryCredits.getSummaryContingencies", Object[].class)
					.setParameter("customer", key.getCustomer()).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

			List<ConsolidatePositionDTO> tempSummaryContingencies = Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryOther.getOtherContingencies", Object[].class)
					.setParameter("customer", key.getCustomer()).setParameter("user", key.getUser()).getResultList());

			if (tempSummaryContingencies.size() > 0) {

				for (ConsolidatePositionDTO consolidatePositionDTO : tempSummaryContingencies) {
					allSummaryContingencies.add(consolidatePositionDTO);
				}
			}
			return allSummaryContingencies;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYCREDITSDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Contingentes.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYCREDITSDAO.002", "getSummaryContingencies"));
		}
	}

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 6. Lineas de Credito
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO#getAllCreditLines
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<SummaryCreditsDTO> getAllCreditLines(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYCREDITSDAO.001", "getAllCreditLines"));
			return em.createNamedQuery("SummaryCredits.getAllCreditLines", SummaryCreditsDTO.class).setParameter("customer", key.getCustomer()).setParameter("user", key.getUser())
					.setParameter("sequence", key.getSequence()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYCREDITSDAO.004"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Líneas de Crédito.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYCREDITSDAO.002", "getAllCreditLines"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO#getMaxDebtAmounts
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId,
	 * java.lang.Integer)
	 */
	public List<SummaryCreditsDTO> getMaxDebtAmounts(SummaryIdDTO key, Integer processId) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYCREDITSDAO.001", "getAllCreditLines"));
			return em.createNamedQuery("SummaryCredits.getMaxDebtAmounts", SummaryCreditsDTO.class).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence())
					.setParameter("processId", processId).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYCREDITSDAO.004"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrio un problema al consultar el riesgo del cliente.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYCREDITSDAO.002", "getAllCreditLines"));
		}
	}

	@Override
	public List<SummaryCreditsDTO> getCustomerRiskCredits(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.001", "getPledgeAmountOperation"));
			return em.createNamedQuery("SummaryCredits.getCustomerRisk", SummaryCreditsDTO.class).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence())
					.setParameter("customer", key.getCustomer()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("INDIRECTRISK.002"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la sumatoria del riesgo del cliente.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.003", "getPledgeAmountOperation"));
		}

	}

}
