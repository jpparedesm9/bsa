/*
 * File: PortfolioBankingProductManager.java
 * Date: April 20, 2012
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

import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.INodeProductManager;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * Implementation for the integration services in the banking product operations
 * 
 * @author cloachamin
 */
public class PortfolioBankingProductManager implements
		IPortfolioBankingProductManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioBankingProductManager.class);
	/** NodeTypeCategory manager service */
	private INodeProductManager nodeProductManager;
	/** Portfolio operation manager service */
	private IDefaultOperationManager portfolioOperationManager;
	/** Catalog manager service */
	private ICatalogManager catalogManager;
	/** The banking product manager service */
	private IBankingProductManager bankingProductManager;
	/** The mapping field manager service */
	private IMappingFieldManager mappingFieldManager;

	/**
	 * This method provides the integration logic to the core when a banking
	 * product is created in the FPM
	 * 
	 * @param bankingProduct
	 *            the data for the banking product
	 */
	public void applyChange(BankingProduct bankingProduct) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOBANKINGPRODUCTMANAGER.001", "applyChange"));
			NodeTypeCategory category = nodeProductManager
					.getNodeCateogyById(bankingProduct.getNodeTypeCategory()
							.getId());
			// Get the type node for the banking product to check if is a final
			// banking product
			if (category.getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				logger.logDebug(MessageManager
						.getString("PORTFOLIOBANKINGPRODUCTMANAGER.003"));
				// Get the sector for the banking product
				String mnemonic = nodeProductManager.getNodeCateogyById(
						bankingProduct.getSectorId()).getMnemonic();

				// Get family for the banking product
				String family = mappingFieldManager.getValueByPhisicalField(
						bankingProduct.getId(), Constants.FAMILY);

				// Create the default operation for currency
				List<CurrencyProduct> currencies = bankingProductManager
						.findAllCurrenciesAndPoliciesByProduct(bankingProduct
								.getId());
				for (CurrencyProduct cp : currencies) {
					// Create the operation with the sector value
					DefaultOperation operation = new DefaultOperation();
					// Replicate the operation with the banking product code
					operation.setOperation(bankingProduct.getId());
					// For dt_familia and dt_grupo_informe the sector is
					// replicated
					operation.setGroupReport(mnemonic);
					operation.setFamily(family);
					operation.setChange("");
					operation.setCurrency(Long.parseLong(cp.getId()
							.getCurrencyId()));
					operation.setRenew("");
					operation.setType("");
					operation.setPrePayment("");
					operation.setCompleteQuota("");
					operation.setChargeType("");
					operation.setReductionType("");
					operation.setAceptAdvances("");
					operation.settTerm("");
					operation.setApplicationType("");
					operation.setTerm(0);
					operation.settDividend("");
					operation.setCapPeriod(0);
					operation.setIntPeriod(0);
					operation.setCapGrace(0);
					operation.setIntGrace(0);
					operation.setDistGrace("");
					operation.setDaysYear(0);
					operation.setAmortizationType("");
					operation.setFixedDate("");
					operation.setDayPayment(0);
					operation.setFixedQuota("");
					operation.setDaysGrace(0);
					operation.setAvoidHolidays("");
					operation.setMonth(0l);
					operation.setFundsOwns("");

					// Call the service that delete the operation
					portfolioOperationManager
							.manageDefaultOperation(
									com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.DELETE_OPERATION,
									operation);
					
					// Call the service that create the operation
					portfolioOperationManager
							.manageDefaultOperation(
									com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.INSERT_OPERATION,
									operation);
				}
				logger.logDebug("Find catalog name : "
						+ com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS
						+ " code:  " + bankingProduct.getId());
				changeBankingProductAvailableToSale(bankingProduct.getId(),
						bankingProduct.getAvailable());
			}
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("PORTFOLIOBANKINGPRODUCTMANAGER.005"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOBANKINGPRODUCTMANAGER.002", "applyChange"));
		}
	}

	public void changeBankingProductAvailableToSale(String bankingProductId,
			String isAvailable) {
		try {
			Catalog portfolio = catalogManager
					.getCatalogRegardlessState(
							com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS,
							bankingProductId);

			BankingProduct bankingProduct = bankingProductManager
					.getBankingProductBasicInformationById(bankingProductId);

			if (isAvailable.equals(Constants.YES)) {

				if (portfolio == null) {
					// create or update the catalogs in the portfolio
					// catalogs
					catalogManager
							.createCatalog(
									com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS,
									new Catalog(bankingProductId,
											bankingProduct.getName()));
				} else {
					catalogManager
							.enableCatalog(
									com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS,
									new Catalog(bankingProductId,
											bankingProduct.getName()));

				}

				// create or update the catalog table in the credit
				// module
				portfolioOperationManager.createCreditOperation(
						bankingProductId,
						bankingProductManager
								.getCategoryKeepDictionaryFromParents(
										bankingProductId).getModule()
								.getMnemonic(), bankingProduct.getName(), "V");

			} else {

				if (portfolio != null) {
					catalogManager
							.disableCatalog(
									com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CATALOGS.PORTFOLIO_OPERATIONS,
									new Catalog(bankingProductId,
											bankingProduct.getName()));
				}

				// create or update the catalog table in the credit module
				portfolioOperationManager.createCreditOperation(
						bankingProduct.getId(),
						bankingProductManager
								.getCategoryKeepDictionaryFromParents(
										bankingProduct.getId()).getModule()
								.getMnemonic(), bankingProduct.getName(), "E");

			}

		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("PORTFOLIOBANKINGPRODUCTMANAGER.005"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOBANKINGPRODUCTMANAGER.002", "applyChange"));
		}

	}

	/**
	 * Setter for the <tt>IBankingProductManager</tt> injected instance
	 * 
	 * @param bankingProductManager
	 */
	public void setNodeProductManager(INodeProductManager nodeProductManager) {
		this.nodeProductManager = nodeProductManager;
	}

	/**
	 * Setter for the <tt>IDefaultOperationManager</tt> injected instance
	 * 
	 * @param portfolioOperationManager
	 */
	public void setPortfolioOperationManager(
			IDefaultOperationManager portfolioOperationManager) {
		this.portfolioOperationManager = portfolioOperationManager;
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

	/**
	 * @param mappingFieldManager
	 */
	public void setMappingFieldManager(IMappingFieldManager mappingFieldManager) {
		this.mappingFieldManager = mappingFieldManager;
	}
	
	
}
