/*
 * File: PortfolioItemStatusManager.java
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
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.ItemStatus;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IItemStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.bo.ItemStatusPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioItemStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemStatusPortfolioManager;

/**
 * Implementation for the integration services in the item status operations
 * 
 * @author bron
 */
public class PortfolioItemStatusManager implements IPortfolioItemStatusManager {

	private IItemStatusManager itemStatusService;
	private IItemStatusPortfolioManager itemStatusPortfolioService;
	private IItemsManager itemsManagerService;
	private IPortfolioCatalogManager portfolioCatalogService;

	/** Catalog manager service */
	private ICatalogManager catalogManager;
	/** The banking product manager service */
	private IBankingProductManager bankingProductManager;

	
	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioItemStatusManager.class);

	/**
	 * Replicate data to ca_estados_rubro
	 */
	public void createItemStatusHistory(
			BankingProductHistory bankingProductHistoryId) {

		try {
			logger.logDebug(MessageManager
					.getString("PORTFOLIOITEMSTATUSMANAGER.001",
							"createItemStatusHistory"));

			verifiedCatalog(bankingProductHistoryId);
			
			// Get all data of itemstatus
			List<ItemStatus> itemStatusList = itemStatusService
					.findItemStatus(new ItemStatus(bankingProductHistoryId
							.getProductId(), 0l, 0, 0, 0));

			List<ItemStatusPortfolio> itemStatusPortfolioList = new ArrayList<ItemStatusPortfolio>();

			for (ItemStatus itemStatus : itemStatusList) {

				ItemStatusPortfolio iStatusPortfolio = new ItemStatusPortfolio();
				iStatusPortfolio.setOperation(itemStatus.getProductId());
				iStatusPortfolio.setItemId(itemsManagerService.getItem(
						itemStatus.getItemId()).getName());
				iStatusPortfolio.setStatusId(portfolioCatalogService
						.findStatusByCode(itemStatus.getStatusId()));
				iStatusPortfolio.setStartdays(itemStatus.getStartdays());
				iStatusPortfolio.setFinishdays(itemStatus.getFinishdays());

				itemStatusPortfolioList.add(iStatusPortfolio);
			}

			this.itemStatusPortfolioService.insertItemStatusPortfolio(
					itemStatusPortfolioList,
					bankingProductHistoryId.getProductId());

		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMSTATUSMANAGER.003"),
					e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager
					.getString("PORTFOLIOITEMSTATUSMANAGER.002",
							"createItemStatusHistory"));
		}

	}

	private void verifiedCatalog(BankingProductHistory bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMSTATUSMANAGER.001", "verifiedCatalog"));
			Catalog portfolio = catalogManager
					.getCatalogRegardlessState(
							com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS,
							bankingProductHistoryId.getProductId());

			if (portfolio == null) {
				BankingProduct bankingProduct = bankingProductManager
						.getBankingProductBasicInformationById(bankingProductHistoryId
								.getProductId());

				catalogManager
						.createCatalog(
								com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS,
								new Catalog(bankingProductHistoryId
										.getProductId(), bankingProduct
										.getName()));
			}
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMSTATUSMANAGER.003"),
					e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMSTATUSMANAGER.002", "verifiedCatalog"));
		}
	}

	
	/**
	 * @param itemStatusService
	 *            the itemStatusService to set
	 */
	public void setItemStatusService(IItemStatusManager itemStatusService) {
		this.itemStatusService = itemStatusService;
	}

	/**
	 * @param itemStatusPortfolioService
	 *            the itemStatusPortfolioService to set
	 */
	public void setItemStatusPortfolioService(
			IItemStatusPortfolioManager itemStatusPortfolioService) {
		this.itemStatusPortfolioService = itemStatusPortfolioService;
	}

	/**
	 * @param itemsManagerService
	 *            the itemsManagerService to set
	 */
	public void setItemsManagerService(IItemsManager itemsManagerService) {
		this.itemsManagerService = itemsManagerService;
	}

	/**
	 * @param portfolioCatalogService
	 *            the portfolioCatalogService to set
	 */
	public void setPortfolioCatalogService(
			IPortfolioCatalogManager portfolioCatalogService) {
		this.portfolioCatalogService = portfolioCatalogService;
	}

	/**
	 * Setter for the <tt>ICatalogManager</tt> injected instance
	 * 
	 * @param catalogManager
	 */
	public void setCatalogManager(ICatalogManager catalogManager) {
		this.catalogManager = catalogManager;
	}

	/**
	 * Setter for the <tt>IBankingProductManager</tt> injected instance
	 * 
	 * @param bankingProductManager
	 */
	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}
}
