/*
 * File: PortfolioPurposeManager.java
 * Date: April 25, 2012
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
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Purpose;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductHistoryManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IPurposeManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioPurposeManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.PurposeType;
import com.cobiscorp.ecobis.fpm.portfolio.service.IPurposeTypeManager;

/**
 * Implementation for the integration services
 * 
 * @author bron
 * 
 */
public class PortfolioPurposeManager implements IPortfolioPurposeManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioPurposeManager.class);

	private IPurposeTypeManager purposePortfolioManagerService;
	private IPurposeManager purposeManagerService;
	private IBankingProductHistoryManager bankingProductHistoryService;

	@Override
	public void createPurposeHistory(
			Long bankingProductHistoryId, String module) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOPURPOSEMANAGER.001",
					"createPurposeHistory"));
			/*
			 *Get the Banking product history by serqueential 
			 */
			
			BankingProductHistory bph=new BankingProductHistory();
			bph=bankingProductHistoryService.getBankingProductHistoryById(bankingProductHistoryId);
			
			// Get all data of Destinations
			// Get all data of Purpose type
			List<Purpose> purposes = purposeManagerService.getPurpose(bph.getProductId());
			List<PurposeType> purposeList = new ArrayList<PurposeType>();
			CobisContext context = (CobisContext) ContextManager.getContext();
			for (Purpose purpose : purposes) {
				PurposeType purptype = new PurposeType();
				purptype.setProductId(bph.getProductId());
				purptype.setProductType(module);
				purptype.setPurposeCode(purpose.getCode());
				purptype.setUser(context.getSession().getUser());
				purptype.setDatePurpose(bph.getSystemDateId());
				purptype.setType(purpose.getType());
				purposeList.add(purptype);
			}
			this.purposePortfolioManagerService.insertPurposeType(purposeList);

		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("PORTFOLIOPURPOSEMANAGER.099"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOPURPOSEMANAGER.002",
					"createPurposeHistory"));
		}
	}
	
	/**
	 * @param purposePortfolioManagerService the purposePortfolioManagerService to set
	 */
	public void setPurposePortfolioManagerService(
			IPurposeTypeManager purposePortfolioManagerService) {
		this.purposePortfolioManagerService = purposePortfolioManagerService;
	}



	/**
	 * @param purposeManagerService the purposeManagerService to set
	 */
	public void setPurposeManagerService(IPurposeManager purposeManagerService) {
		this.purposeManagerService = purposeManagerService;
	}

	/**
	 * @param setBankingProductHistoryService the setBankingProductHistoryService to set
	 */
	
	public void setBankingProductHistoryService(
			IBankingProductHistoryManager bankingProductHistoryService) {
		this.bankingProductHistoryService = bankingProductHistoryService;
	}

	
	
	
}
