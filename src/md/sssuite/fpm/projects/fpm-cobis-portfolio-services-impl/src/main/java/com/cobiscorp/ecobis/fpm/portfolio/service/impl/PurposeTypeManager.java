/*
 * File: TranOperationManager.java
 * Date: April 23, 2012
 *
 * This application is part of banking packages owned by COBISCORP. 
 * Unauthorized use is prohibited as well as any alteration or 
 * addition made by any of its users without due due COBISCORP 
 * written consent.
 * This program is protected by copyright law and by international 
 * intellectual property conventions. Its unauthorized use COBISCORP 
 * right to give orders for retention and to prosecute those 
 * responsible for any breach.
 */

package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.portfolio.model.PurposeType;
import com.cobiscorp.ecobis.fpm.portfolio.service.IPurposeTypeManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class PurposeTypeManager implements IPurposeTypeManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PurposeTypeManager.class);

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	public void insertPurposeType(List<PurposeType> purposeList) {
		try {

			logger.logDebug(MessageManager.getString(
					"PURPOSETYPE.001", "insertPurposeType"));

			if (purposeList != null) {
				List<PurposeType> purposList = findAllPurpose(purposeList
						.get(0).getProductId());
				// Delete all data from cr_tipo_proposito   
				for (PurposeType purpose : purposList)
					entityManager.remove(purpose);
				entityManager.flush();
				// Insert new data from fp_economicdestination
				for (PurposeType purpose : purposeList)
					entityManager.persist(purpose);
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PURPOSETYPE.004"), ex);
			throw new BusinessException(6904023,
					"Ocurrio un problema al insertar informacion de destinos económicos.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PURPOSETYPE.002", "insertPurposeType"));
		}
	}

	private List<PurposeType> findAllPurpose(String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PURPOSETYPE.001", "findAllPurpose"));

			return entityManager
					.createNamedQuery("PurposeType.findAllByPurposeByProduct",
							PurposeType.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PURPOSETYPE.003"), ex);
			throw new BusinessException(6904022,
					"Ocurrio un error al intentar obtener los destinos economicos.");
		}finally {
			logger.logDebug(MessageManager.getString(
					"PURPOSETYPE.002", "findAllPurpose"));
		}
	}


}
