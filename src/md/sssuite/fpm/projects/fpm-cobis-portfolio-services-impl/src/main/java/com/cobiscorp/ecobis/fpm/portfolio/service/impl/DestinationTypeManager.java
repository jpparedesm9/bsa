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
import com.cobiscorp.ecobis.fpm.portfolio.model.DestinationType;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDestinationTypeManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class DestinationTypeManager implements IDestinationTypeManager {

	

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(DestinationTypeManager.class);

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	public void insertDestinationType(List<DestinationType> destinationList) {
		try {

			logger.logDebug(MessageManager.getString(
					"DESTINATIONTYPE.001", "insertDestinationType"));
			
			if (destinationList != null && destinationList.size() > 0) {
				List<DestinationType> destList = findAllDestination(destinationList
						.get(0).getProductId());
				// Delete all data from cr_toperacion_destino  
				for (DestinationType destination : destList)
					entityManager.remove(destination);
				entityManager.flush();
				// Insert new data from fp_economicdestination
				for (DestinationType destination : destinationList)
					entityManager.persist(destination);
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("DESTINATIONTYPE.004"), ex);
			throw new BusinessException(6904023,
					"Ocurrio un problema al insertar informacion de destinos económicos.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"DESTINATIONTYPE.002", "insertDestinationType"));
		}
	}

	private List<DestinationType> findAllDestination(String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"DESTINATIONTYPE.001", "findAllDestination"));

			return entityManager
					.createNamedQuery("DestinationType.findAllByDestinationByProduct",
							DestinationType.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("DESTINATIONTYPE.003"), ex);
			throw new BusinessException(6904022,
					"Ocurrio un error al intentar obtener los destinos economicos.");
		}finally {
			logger.logDebug(MessageManager.getString(
					"DESTINATIONTYPE.002", "findAllDestination"));
		}
	}


}
