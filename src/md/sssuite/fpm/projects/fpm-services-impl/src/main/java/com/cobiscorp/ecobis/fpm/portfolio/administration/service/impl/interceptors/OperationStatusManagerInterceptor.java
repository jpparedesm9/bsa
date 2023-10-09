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
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioOperationStatusManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class OperationStatusManagerInterceptor implements BundleContextAware {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(OperationStatusManagerInterceptor.class);
	/** OSGI Bundles context */
	private BundleContext bundleContext;
	/** BankingProduct manager service */
	private IBankingProductManager bankingProductManager;

	/**
	 * The interceptor method executed after the createAccountingProfileHistory
	 * method
	 * 
	 * @param joinPoint
	 *            Execution method context
	 */
	public void createOperationStatusHistory(JoinPoint jointPoint) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGERINTERCEPTOR.001",
					"createOperationStatusHistory"));

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();

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

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()
						&& bankingProduct.getNodeTypeCategory()
								.getNodeTypeProduct().getId() == 5l) {

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioOperationStatusManager.class
									.getName());

					if (reference != null) {

						// Get the implementation instance
						IPortfolioOperationStatusManager serviceIntegration = (IPortfolioOperationStatusManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"OPERATIONSTATUSMANAGERINTERCEPTOR.006",
								"createOperationStatusHistory",
								serviceIntegration));

						// Call the method with the correct type
						serviceIntegration.createOperationStatusHistory(bph
								.getId());
					}
				}
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGERINTERCEPTOR.007",
					"createOperationStatusHistory"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGERINTERCEPTOR.002",
					"createOperationStatusHistory"));
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
