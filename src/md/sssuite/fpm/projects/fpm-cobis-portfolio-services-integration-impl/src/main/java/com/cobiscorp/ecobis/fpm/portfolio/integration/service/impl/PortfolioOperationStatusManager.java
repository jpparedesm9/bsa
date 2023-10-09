/*
 * File: PortfolioOperationStatusManager.java
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
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.OperationStatus;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductHistoryManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IOperationStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.bo.OpManualStatus;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioOperationStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IOpManualStatusManager;

/**
 * Implementation for the integration services in the change operation status
 * operations
 * 
 * @author bron
 */
public class PortfolioOperationStatusManager implements
		IPortfolioOperationStatusManager {

	private IPortfolioCatalogManager portfolioCatalogService;
	private IOperationStatusManager operationStatusService;
	private IOpManualStatusManager opManualStatusService;
	private IBankingProductHistoryManager bankingProductHistoryService;

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioOperationStatusManager.class);

	/**
	 * Replicate data to ca_trn_oper
	 */
	public void createOperationStatusHistory(
			Long bankingProductHistoryId) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOACCOUNTINGPROFILEMANAGER.001",
					"createAccountingProfileHistory"));
			BankingProductHistory bph=new BankingProductHistory();
			bph=bankingProductHistoryService.getBankingProductHistoryById(bankingProductHistoryId);
 
			

			// Get all data of itemstatus
			List<OperationStatus> operationStatus = operationStatusService
					.findOperationChangeStatus(new OperationStatus(bph
							.getProductId(),null, 0, 0, 0, 0));

			List<OpManualStatus> opManualStatusList = new ArrayList<OpManualStatus>();

			for (OperationStatus opStatus : operationStatus) {

				OpManualStatus opManStatus = new OpManualStatus();
				opManStatus.setProductId(opStatus.getProductId());
				opManStatus.setChangeType(opStatus.getChangeType());
				opManStatus.setInitialStatusId(portfolioCatalogService
						.findStatusByCode(opStatus.getInitialStatusId()));
				opManStatus.setFinalStatusId(portfolioCatalogService
						.findStatusByCode(opStatus.getFinalStatusId()));
				opManStatus.setStartDays(opStatus.getStartDays());
				opManStatus.setFinishDays(opStatus.getFinishDays());

				opManualStatusList.add(opManStatus);
			}

			this.opManualStatusService.insertOpManualStatus(opManualStatusList);

		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("PORTFOLIOACCOUNTINGPROFILEMANAGER.003"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOACCOUNTINGPROFILEMANAGER.002",
					"createAccountingProfileHistory"));
		}

	}

	/**
	 * @param portfolioCatalogService the portfolioCatalogService to set
	 */
	public void setPortfolioCatalogService(
			IPortfolioCatalogManager portfolioCatalogService) {
		this.portfolioCatalogService = portfolioCatalogService;
	}

	/**
	 * @param operationStatusService the operationStatusService to set
	 */
	public void setOperationStatusService(
			IOperationStatusManager operationStatusService) {
		this.operationStatusService = operationStatusService;
	}

	/**
	 * @param opManualStatusService the opManualStatusService to set
	 */
	public void setOpManualStatusService(
			IOpManualStatusManager opManualStatusService) {
		this.opManualStatusService = opManualStatusService;
	}

	/**
	 * @param setBankingProductHistoryService the setBankingProductHistoryService to set
	 */
	public void setBankingProductHistoryService(
			IBankingProductHistoryManager bankingProductHistoryService) {
		this.bankingProductHistoryService = bankingProductHistoryService;
	}
	
	
	
	
}
