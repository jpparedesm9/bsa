/*
 * File: PortfolioEconomicActivityManager.java
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
import com.cobiscorp.ecobis.fpm.model.EconomicActivity;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductHistoryManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IEconomicActivityManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioEconomicActivityManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.ActivityType;
import com.cobiscorp.ecobis.fpm.portfolio.service.IActivityTypeManager;

/**
 * Implementation for the integration services
 * 
 * @author bron
 * 
 */
public class PortfolioEconomicActivityManager implements IPortfolioEconomicActivityManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioEconomicActivityManager.class);

	private IActivityTypeManager activityPortfolioManagerService;
	private IEconomicActivityManager economicActivityManagerService;
	private IBankingProductHistoryManager bankingProductHistoryService;

	@Override
	public void createEconomicActivityHistory(Long bankingProductHistoryId,
			String module) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOECONOMICACTIVITYMANAGER.001", "createEconomicActivityHistory"));
			/*
			 * Get the Banking product history by serqueential
			 */

			BankingProductHistory bph = new BankingProductHistory();
			bph = bankingProductHistoryService
					.getBankingProductHistoryById(bankingProductHistoryId);

			// Get all data of Destinations
			// Get all data of Purpose type
			List<EconomicActivity> economicActivities = economicActivityManagerService
					.getEconomicActivity(bph.getProductId());
			List<ActivityType> activityList = new ArrayList<ActivityType>();
			CobisContext context = (CobisContext) ContextManager.getContext();
			for (EconomicActivity economicActivity : economicActivities) {
				ActivityType activityType = new ActivityType();
				activityType.setProductId(bph.getProductId());
				activityType.setProductType(module);
				activityType.setActivityCode(economicActivity.getCode());
				activityType.setUser(context.getSession().getUser());
				activityType.setDateActivity(bph.getSystemDateId());
				activityType.setType(economicActivity.getType());
				activityList.add(activityType);
			}
			this.activityPortfolioManagerService
					.insertActivityType(activityList);

		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOECONOMICACTIVITYMANAGER.099"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOECONOMICACTIVITYMANAGER.002", "createEconomicActivityHistory"));
		}
	}

	public IActivityTypeManager getActivityPortfolioManagerService() {
		return activityPortfolioManagerService;
	}

	public void setActivityPortfolioManagerService(
			IActivityTypeManager activityPortfolioManagerService) {
		this.activityPortfolioManagerService = activityPortfolioManagerService;
	}

	public IEconomicActivityManager getEconomicActivityManagerService() {
		return economicActivityManagerService;
	}

	public void setEconomicActivityManagerService(
			IEconomicActivityManager economicActivityManagerService) {
		this.economicActivityManagerService = economicActivityManagerService;
	}

	public IBankingProductHistoryManager getBankingProductHistoryService() {
		return bankingProductHistoryService;
	}

	public void setBankingProductHistoryService(
			IBankingProductHistoryManager bankingProductHistoryService) {
		this.bankingProductHistoryService = bankingProductHistoryService;
	}

}
