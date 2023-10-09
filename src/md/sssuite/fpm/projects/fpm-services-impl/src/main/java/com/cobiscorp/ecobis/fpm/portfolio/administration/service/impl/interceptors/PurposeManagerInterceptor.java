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
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioPurposeManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class PurposeManagerInterceptor implements BundleContextAware {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(PurposeManagerInterceptor.class);
	/** OSGI Bundles context */
	private BundleContext bundleContext;
	/** BankingProduct manager service */
	private IBankingProductManager bankingProductManager;

	public void createPurposeHistory(JoinPoint jointPoint) {
		try {
			logger.logDebug(MessageManager
					.getString("PURPOSEMANAGERINTERCEPTOR.001",
							"createDestinationHistory"));

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
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
				if (authorizationStatus != Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED)
					return;

				// The identifier of the PORTFOLIO module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()
						&& bankingProduct.getNodeTypeCategory()
								.getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
					// Get a reference for the PORTFOLIO Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioPurposeManager.class
									.getName());
					if (reference != null) {
						// Get the implementation instance
						IPortfolioPurposeManager serviceIntegration = (IPortfolioPurposeManager) bundleContext
								.getService(reference);
						logger.logDebug(MessageManager.getString(
								"PURPOSEMANAGERINTERCEPTOR.006",
								"createPurposeHistory", serviceIntegration));
						serviceIntegration.createPurposeHistory(bph.getId(),
								category.getModule().getMnemonic());
					}
				}
			}
		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("PURPOSEMANAGERINTERCEPTOR.002",
							"createDestinationHistory"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager
					.getString("PURPOSEMANAGERINTERCEPTOR.002",
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
