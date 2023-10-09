/*
 * File: BankingProductManagerInterceptor.java
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
package com.cobiscorp.ecobis.fpm.operation.service.impl.interceptors;


import org.aspectj.lang.JoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.INodeProductManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioBankingProductManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * The interceptor class for the Banking product management operations
 * 
 * @author cloachamin
 */
public class BankingProductManagerInterceptor implements BundleContextAware {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(BankingProductManagerInterceptor.class);
	/** OSGI Bundles context */
	private BundleContext bundleContext;
	/** BankingProduct manager service */
	private IBankingProductManager bankingProductManager;
	/** NodeTypeCategory manager service */
	private INodeProductManager nodeProductManager;

	/**
	 * The interceptor method executed after the createBankingProductHistory
	 * method
	 * 
	 * @param joinPoint
	 *            Execution method context
	 */
	public void applyChange(JoinPoint joinPoint) {
		try {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.001",
					"createBankingProductHistory"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Get the arguments of the method
				Object[] args = joinPoint.getArgs();
				// Get the only argument				
				String bankingProductHistoryId = (String) args[0];

				// Get specific BankingProduct object
				BankingProduct bp = bankingProductManager
						.getBankingProductById(bankingProductHistoryId);

				applyChangeInterceptor(bp);				
			}
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTMANAGERINTERCEPTOR.007"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.002",
					"createBankingProductHistory"));
		}
	}

	public void applyChangeTask(JoinPoint joinPoint) {
		try {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.001", "applyChangeTask"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Get the arguments of the method
				Object[] args = joinPoint.getArgs();
				// Get the only argument
				String processId = (String) args[0];

				// Get specific BankingProduct object
				BankingProduct bp = bankingProductManager
						.getBankingProductById(bankingProductManager
								.getBankingProductByProcessId(processId));

				applyChangeInterceptor(bp);				
			}
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTMANAGERINTERCEPTOR.007"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.002", "applyChangeTask"));
		}

	}

	private void applyChangeInterceptor(BankingProduct bankingProduct) {
		NodeTypeCategory category = nodeProductManager
				.getNodeCateogyById(bankingProduct.getNodeTypeCategory()
						.getId());
		// Get the type node for the banking product to check if is a
		// final banking product
		if (category.getNodeTypeProduct().getId() != Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
			return;
		}
		// Find the category that define a module
		category = bankingProductManager
				.getCategoryKeepDictionaryFromParents(bankingProduct
						.getParentnode());
		logger.logDebug(MessageManager.getString(
				"BANKINGPRODUCTMANAGERINTERCEPTOR.003", category.getModule()
						.getName()));
		// The identifier of the portfolio module is 1
		if (category.getModule().getModuleId() == Modules.PORTFOLIO
				.getModuleId()) {
			logger.logDebug(MessageManager
					.getString("BANKINGPRODUCTMANAGERINTERCEPTOR.004"));
			// Get a reference for the Portfolio Service Integration

			ServiceReference reference = bundleContext
					.getServiceReference(IPortfolioBankingProductManager.class
							.getName());
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.005", reference));
			if (reference != null) {
				// Get the implementation instance
				IPortfolioBankingProductManager serviceIntegration = (IPortfolioBankingProductManager) bundleContext
						.getService(reference);
				logger.logDebug(MessageManager.getString(
						"BANKINGPRODUCTMANAGERINTERCEPTOR.006",
						"createBankingProductHistory", serviceIntegration));
				// Call the method with the correct type
				serviceIntegration.applyChange(bankingProduct);
			}
		}
		bankingProductManager.changeProcessId(bankingProduct.getId(), "");
	}

	public void changeBankingProductAvailableToSale(JoinPoint joinPoint) {
		try {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.001",
					"changeBankingProductAvailableToSale"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Get the arguments of the method
				Object[] args = joinPoint.getArgs();
				// Get the only argument
				String bankingProductId = (String) args[0];
				String isAvailable = (String) args[1];

				// Get specific BankingProduct object
				BankingProduct bp = bankingProductManager
						.getBankingProductById(bankingProductId);

				NodeTypeCategory category = nodeProductManager
						.getNodeCateogyById(bp.getNodeTypeCategory().getId());
				// Get the type node for the banking product to check if is a
				// final banking product
				if (category.getNodeTypeProduct().getId() != Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
					return;
				}
				// Find the category that define a module
				category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(bp
								.getParentnode());
				logger.logDebug(MessageManager.getString(
						"BANKINGPRODUCTMANAGERINTERCEPTOR.003", category
								.getModule().getName()));
				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {
					logger.logDebug(MessageManager
							.getString("BANKINGPRODUCTMANAGERINTERCEPTOR.004"));
					// Get a reference for the Portfolio Service Integration

					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioBankingProductManager.class
									.getName());
					logger.logDebug(MessageManager.getString(
							"BANKINGPRODUCTMANAGERINTERCEPTOR.005", reference));
					if (reference != null) {
						// Get the implementation instance
						IPortfolioBankingProductManager serviceIntegration = (IPortfolioBankingProductManager) bundleContext
								.getService(reference);
						logger.logDebug(MessageManager.getString(
								"BANKINGPRODUCTMANAGERINTERCEPTOR.006",
								"createBankingProductHistory",
								serviceIntegration));
						// Call the method with the correct type
						serviceIntegration.changeBankingProductAvailableToSale(
								bankingProductId, isAvailable);
					}
				}
			}
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTMANAGERINTERCEPTOR.007"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTMANAGERINTERCEPTOR.002",
					"changeBankingProductAvailableToSale"));
		}
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
	 * Setter to the <tt>BundleContext</tt> injected by the container
	 * 
	 * @param bundleContext
	 */
	public void setBundleContext(BundleContext bundleContext) {
		this.bundleContext = bundleContext;
	}

	/**
	 * Setter for the <tt>IBankingProductManager</tt> injected instance
	 * 
	 * @param bankingProductManager
	 */
	public void setNodeProductManager(INodeProductManager nodeProductManager) {
		this.nodeProductManager = nodeProductManager;
	}
}
