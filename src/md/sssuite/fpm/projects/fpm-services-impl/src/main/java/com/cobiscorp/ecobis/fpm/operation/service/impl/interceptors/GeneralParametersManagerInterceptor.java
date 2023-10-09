/*
 * File: GeneralParametersManagerInterceptor.java
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

package com.cobiscorp.ecobis.fpm.operation.service.impl.interceptors;

import java.util.ArrayList;
import java.util.HashMap;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobisv.commons.exceptions.ValidationException;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValues;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * 
 * The interceptor class for the general parameter
 * 
 * @author oguano
 * 
 */
public class GeneralParametersManagerInterceptor implements BundleContextAware {

	// region Fileds
	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(GeneralParametersManagerInterceptor.class);

	private BundleContext bundleContext;
	private IBankingProductManager bankingProductManager;

	// end-region

	// region Properties

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.osgi.context.BundleContextAware#setBundleContext(
	 * org.osgi.framework.BundleContext)
	 */
	public void setBundleContext(BundleContext bundleContext) {
		this.bundleContext = bundleContext;
	}

	/**
	 * @param bankingProductManager
	 */
	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}

	// end-region

	// region Methods
	@SuppressWarnings("unchecked")
	public void saveGeneralParametersValues(JoinPoint jointPoint) {

		logger.logDebug(MessageManager.getString(
				"GENERALPARAMETERSMANAGERINTERCEPTOR.001",
				"saveGeneralParametersValues"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents((String) args[0]);
				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"GENERALPARAMETERSMANAGERINTERCEPTOR.003",
							"Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioGeneralParametersManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.004",
								reference,
								IPortfolioGeneralParametersManager.class
										.getName()));

						// Get the implementation instance
						IPortfolioGeneralParametersManager serviceIntegration = (IPortfolioGeneralParametersManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.006",
								"saveGeneralParametersValues",
								serviceIntegration));

						// Call the method with the correct type
						serviceIntegration.saveGeneralParametersValues(
								(String) args[0],
								(ArrayList<GeneralParametersValues>) args[1],
								(Boolean) args[2]);
					} else {
						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.005",
								IPortfolioGeneralParametersManager.class
										.getName()));
					}
				}
			}
		} catch (ValidationException ve) {
			throw ve;
		} catch (BusinessException be) {
			throw be;

		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("GENERALPARAMETERSMANAGERINTERCEPTOR.007"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGERINTERCEPTOR.002",
					"saveGeneralParametersValues"));
		}
	}

	@SuppressWarnings("unchecked")
	public void validateGeneralParameters(ProceedingJoinPoint jointPoint) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGERINTERCEPTOR.001",
					"validateGeneralParameters"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				// Get the only argument
				String bpId = (String) args[0];
				// Find the banking product
				BankingProduct bp = bankingProductManager
						.getBankingProductBasicInformationById(bpId);
				logger.logDebug(MessageManager.getString(
						"GENERALPARAMETERSMANAGERINTERCEPTOR.008", +bp
								.getNodeTypeCategory().getNodeTypeProduct()
								.getId()));
				if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() != Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
					throw new ValidationException(6900145,
							"El producto bancario indicado debe ser un producto final.");
				}
				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(bpId);
				logger.logDebug(MessageManager.getString(
						"GENERALPARAMETERSMANAGERINTERCEPTOR.003", category
								.getModule().getName()));
				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {
					logger.logDebug(MessageManager
							.getString("GENERALPARAMETERSMANAGERINTERCEPTOR.004"));
					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioGeneralParametersManager.class
									.getName());
					if (reference != null) {
						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.005",
								reference,
								IPortfolioGeneralParametersManager.class
										.getName()));
						// Get the implementation instance
						IPortfolioGeneralParametersManager serviceIntegration = (IPortfolioGeneralParametersManager) bundleContext
								.getService(reference);
						logger.logDebug(MessageManager
								.getString(
										"GENERALPARAMETERSMANAGERINTERCEPTOR.006",
										"validateGeneralParameters",
										serviceIntegration));
						// Call the method with the correct type
						serviceIntegration.validateGeneralParameters(
								(String) args[0],
								(HashMap<String, String>) args[1]);
					} else {
						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.007",
								IPortfolioGeneralParametersManager.class
										.getName()));
					}
				}
			}

		} catch (BusinessException be) {
			throw be;
		} catch (ValidationException ve) {
			throw ve;
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("GENERALPARAMETERSMANAGERINTERCEPTOR.007"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGERINTERCEPTOR.002",
					"validateGeneralParameters"));
		}
	}

	public void createGenearalParametersHistory(JoinPoint jointPoint) {
		logger.logDebug(MessageManager.getString(
				"GENERALPARAMETERSMANAGERINTERCEPTOR.001",
				"createGenearalParametersHistory"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((BankingProductHistory) args[0]).getProductId());
				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"GENERALPARAMETERSMANAGERINTERCEPTOR.003",
							"Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioGeneralParametersManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.004",
								reference,
								IPortfolioGeneralParametersManager.class
										.getName()));

						// Get the implementation instance
						IPortfolioGeneralParametersManager serviceIntegration = (IPortfolioGeneralParametersManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.006",
								"saveGeneralParametersValues",
								serviceIntegration));

						// Call the method with the correct type
						serviceIntegration.createGenearalParametersHistory(
								(BankingProductHistory) args[0],
								(String) args[1]);
					} else {
						logger.logDebug(MessageManager.getString(
								"GENERALPARAMETERSMANAGERINTERCEPTOR.005",
								IPortfolioGeneralParametersManager.class
										.getName()));
					}
				}
			}
		} catch (ValidationException ve) {
			throw ve;
		} catch (BusinessException be) {
			throw be;

		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("GENERALPARAMETERSMANAGERINTERCEPTOR.007"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGERINTERCEPTOR.002",
					"createGenearalParametersHistory"));
		}

	}
	// end-region
}
