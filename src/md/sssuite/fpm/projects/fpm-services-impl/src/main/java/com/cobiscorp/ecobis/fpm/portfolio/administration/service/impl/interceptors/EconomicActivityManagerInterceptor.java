package com.cobiscorp.ecobis.fpm.portfolio.administration.service.impl.interceptors;

import org.aspectj.lang.JoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioEconomicActivityManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class EconomicActivityManagerInterceptor implements BundleContextAware {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(EconomicActivityManagerInterceptor.class);
	/** OSGI Bundles context */
	private BundleContext bundleContext;
	/** BankingProduct manager service */
	private IBankingProductManager bankingProductManager;

	public void createEconomicActivityHistory(JoinPoint jointPoint) {
		try {
			logger.logDebug(MessageManager
					.getString("ECONOMICACTIVITYMANAGERINTERCEPTOR.001",
							"createDestinationHistory"));

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				logger.logDebug("JoinPoint:" + args.toString());
				// BankingProductHistory history = (BankingProductHistory)
				// args[0];
				BankingProductHistory bph = (BankingProductHistory) args[0];
				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(bph
								.getProductId());
				BankingProduct bankingProduct = bankingProductManager
						.getBankingProductBasicInformationById(bph
								.getProductId());

				String authorizationStatus = (String) args[1];
				logger.logDebug("Autorization:" + authorizationStatus);
				if (authorizationStatus != Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED)
					return;

				// The identifier of the PORTFOLIO module is 1

				logger.logDebug("Module Id:"
						+ category.getModule().getModuleId());
				logger.logDebug("Node Product Id:"
						+ bankingProduct.getNodeTypeCategory()
								.getNodeTypeProduct().getId());
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()
						&& bankingProduct.getNodeTypeCategory()
								.getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
					// Get a reference for the PORTFOLIO Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioEconomicActivityManager.class
									.getName());
					logger.logDebug("Reference:" + reference);
					if (reference != null) {
						// Get the implementation instance
						IPortfolioEconomicActivityManager serviceIntegration = (IPortfolioEconomicActivityManager) bundleContext
								.getService(reference);
						logger.logDebug("Service integration:"
								+ serviceIntegration);
						logger.logDebug(MessageManager.getString(
								"ECONOMICACTIVITYMANAGERINTERCEPTOR.006",
								"createPurposeHistory", serviceIntegration));
						serviceIntegration
								.createEconomicActivityHistory(bph.getId(),
										category.getModule().getMnemonic());
					}
				}
			}
		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("ECONOMICACTIVITYMANAGERINTERCEPTOR.002",
							"createDestinationHistory"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager
					.getString("ECONOMICACTIVITYMANAGERINTERCEPTOR.002",
							"createDestinationHistory"));
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
}
