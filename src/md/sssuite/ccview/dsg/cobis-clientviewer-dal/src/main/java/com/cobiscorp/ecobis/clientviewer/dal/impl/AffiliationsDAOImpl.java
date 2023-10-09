package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.AffiliationsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dto.AffiliateDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public class AffiliationsDAOImpl implements AffiliationsDAO {

	private static ILogger logger = LogFactory.getLogger(AffiliationsDAOImpl.class);

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

	public AffiliationsDAOImpl() {
	}

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 12. GlobalNet
	public List<AffiliateDTO> getAllAffiliations(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("AFFILIATIONSDAO.001", "getAllAffiliations"));
			return em.createNamedQuery("Affiliate.getAllAffiliations", AffiliateDTO.class).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence())
					.getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("AFFILIATIONSDAO.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("AFFILIATIONSDAO.002", "getAllAffiliations"));
		}
	}
}
