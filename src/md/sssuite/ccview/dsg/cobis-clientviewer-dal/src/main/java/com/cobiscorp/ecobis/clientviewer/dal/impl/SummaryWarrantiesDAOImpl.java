package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.utils.Utils;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.OwnWarrantyTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.WarrantyTmpDTO;

public class SummaryWarrantiesDAOImpl implements SummaryWarrantiesDAO {
	private static ILogger logger = LogFactory.getLogger(SummaryWarrantiesDAOImpl.class);

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

	public SummaryWarrantiesDAOImpl() {
	}

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 7. Garantias
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO#
	 * getSummaryWarranties
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryWarranties(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.001", "getSummaryWarranties"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryWarranties.getSummaryWarranties", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYWARRANTIESDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la lista de Garantías.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.002", "getSummaryWarranties"));
		}
	}

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 5. GARANTIAS
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO#getAllWarranties
	 * (java.lang.Integer)
	 */
	public List<WarrantyTmpDTO> getAllWarranties(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.001", "getAllWarranties"));
			List<WarrantyTmpDTO> warranties = em.createNamedQuery("WarrantyTmp.getAllWarranties", WarrantyTmpDTO.class).setParameter("spid", spid).getResultList();
			System.out.println("getAllWarranties size: "+warranties.size());
			return warranties;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYWARRANTIESDAO.004"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la lista de Garantías.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.002", "getAllWarranties"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO#
	 * deleteAllWarranties(java.lang.Integer)
	 */
	@Override
	public void deleteAllWarranties(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.001", "deleteAllWarranties"));
			em.createNamedQuery("WarrantyTmp.delete").setParameter(1, spid).executeUpdate();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYWARRANTIESDAO.005"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo borrar las tablas temporales de Garantías.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.002", "deleteAllWarranties"));
		}
	}

	// 11. PAGARES
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO#
	 * getAllPromissoryNotes(java.lang.Integer)
	 */
	public List<OwnWarrantyTmpDTO> getAllPromissoryNotes(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.001", "getAllPromissoryNotes"));
			return em.createNamedQuery("OwnWarrantyTmp.getAllPromissoryNotes", OwnWarrantyTmpDTO.class).setParameter("spid", spid).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYWARRANTIESDAO.006"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la lista de Pagares.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.002", "getAllPromissoryNotes"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO#
	 * deleteAllPromissoryNotes(java.lang.Integer)
	 */
	@Override
	public void deleteAllPromissoryNotes(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.001", "deleteAllPromissoryNotes"));
			em.createNamedQuery("OwnWarrantyTmp.delete").setParameter(1, spid).executeUpdate();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYWARRANTIESDAO.007"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo borrar las tablas temporales de Pagares.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYWARRANTIESDAO.002", "deleteAllPromissoryNotes"));
		}
	}
}
