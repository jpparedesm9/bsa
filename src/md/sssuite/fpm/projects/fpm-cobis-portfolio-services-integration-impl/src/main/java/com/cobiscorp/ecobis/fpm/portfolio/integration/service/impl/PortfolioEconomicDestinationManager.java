/*
 * File: PortfolioAccountingProfileManager.java
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

package com.cobiscorp.ecobis.fpm.portfolio.integration.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.EconomicDestination;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IEconomicDestinationManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioEconomicDestinationManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.DestinationType;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDestinationTypeManager;

/**
 * Implementation for the integration services in the economic destination
 * manager
 * 
 * @author bron
 */
public class PortfolioEconomicDestinationManager implements
		IPortfolioEconomicDestinationManager {

	private IDestinationTypeManager destinationTypeService;
	private IEconomicDestinationManager economicDestinationService;

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioEconomicDestinationManager.class);

	/**
	 * Replicate data to ca_trn_oper
	 */
	public void createDestinationHistory(String productId, String module) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOECONOMICDESTINATIOMANAGER.001",
					"createDestinationHistory"));
			// Get all data of Destinations
			List<EconomicDestination> econDestinations = economicDestinationService
					.getEconomicDestinations(productId);
			logger.logDebug("LISTA DE DESTINOS A ISNSERTAR"
					+ econDestinations.size());
			List<DestinationType> destinationList = new ArrayList<DestinationType>();
			for (EconomicDestination destination : econDestinations) {
				DestinationType trnDest = new DestinationType();
				trnDest.setCodeId(destination.getCode());
				trnDest.setProductId(destination.getBankingProduct().getId());
				trnDest.setProductType(module);
				destinationList.add(trnDest);
			}
			destinationTypeService.insertDestinationType(destinationList);
		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("PORTFOLIOECONOMICDESTINATIOMANAGER.099"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOECONOMICDESTINATIOMANAGER.002",
					"createDestinationHistory"));
		}

	}

	public void setDestinationTypeService(
			IDestinationTypeManager destinationTypeService) {
		this.destinationTypeService = destinationTypeService;
	}

	public void setEconomicDestinationService(
			IEconomicDestinationManager economicDestinationService) {
		this.economicDestinationService = economicDestinationService;
	}

}
