/*
 * File: ItemsManagerInterceptor.java
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

import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.RateReferenceValue;
import com.cobiscorp.ecobis.fpm.bo.RateValue;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Item;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioItemsManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * The interceptor class for the items
 * 
 * @author oguano
 * 
 */
public class ItemsManagerInterceptor implements BundleContextAware {

	// region Field
	/** Cobis Logger */
	private final ILogger logger = LogFactory
			.getLogger(ItemsManagerInterceptor.class);
	private BundleContext bundleContext;

	private IBankingProductManager bankingProductManager;

	// end-region

	// region Property

	

	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}

	// end-region

	// region Implements BundleContextAware
	
	public void setBundleContext(BundleContext bundleContext) {
		this.bundleContext = bundleContext;
	}

	// end-region

	// region Methods

	public void createItemsHistory(JoinPoint jointPoint) {

		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"createItemsHistory"));

		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((BankingProductHistory) args[0])
								.getProductId());

				BankingProduct bankingProduct = bankingProductManager
						.getBankingProductBasicInformationById(((BankingProductHistory) args[0])
								.getProductId());
				String authorizationStatus = (String)args[1];
				if(authorizationStatus != Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED) {
					return;
				}
				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()
						&& bankingProduct.getNodeTypeCategory()
								.getNodeTypeProduct().getId() == 5l) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", category
							.getModule().getName()));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006",
								"saveItemsInformation", serviceIntegration));

						// Call the method with the correct type
						serviceIntegration
								.createItemsHistory(((BankingProductHistory) args[0]), (String)args[1]);

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
					}
				}
			}

		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "createItemsHistory"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "createItemsHistory"));
		}

	}

	public List<RateValue> getRateValue(ProceedingJoinPoint pJointPoint)
			throws Throwable {
		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"getRateValue"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = pJointPoint.getArgs();

				logger.logDebug("Argumentos" + args[0]);

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((String) args[0]));

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", "Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006", "getRateValue",
								serviceIntegration));

						// Call the method with the correct type
						return serviceIntegration
								.getRateValue((String) args[0]);

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "getRateValue"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "getRateValue"));
		}
	}

	public List<RateReferenceValue> getRateReferenceValue(
			ProceedingJoinPoint pJointPoint) throws Throwable {

		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"getRateReferenceValue"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = pJointPoint.getArgs();

				logger.logDebug("Argumentos" + args[0]);

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((String) args[0]));

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", "Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006",
								"getRateReferenceValue", serviceIntegration));

						// Call the method with the correct type
						return serviceIntegration
								.getRateReferenceValue((String) args[0]);

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "getRateReferenceValue"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "getRateReferenceValue"));
		}

	}

	public String getChangeRate(ProceedingJoinPoint pJointPoint)
			throws Throwable {

		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"getChangeRate"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = pJointPoint.getArgs();

				logger.logDebug("Argumentos" + args[0]);

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((String) args[0]));

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", "Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006", "getChangeRate",
								serviceIntegration));

						// Call the method with the correct type
						return serviceIntegration
								.getChangeRate((String) args[0]);

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "getChangeRate"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "getChangeRate"));
		}

	}

	public String getSpecialChangeRate(ProceedingJoinPoint pJointPoint)
			throws Throwable {

		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"getSpecialChangeRate"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = pJointPoint.getArgs();

				logger.logDebug("Argumentos" + args[0]);

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((String) args[0]));

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", "Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006",
								"getSpecialChangeRate", serviceIntegration));

						// Call the method with the correct type
						return serviceIntegration
								.getSpecialChangeRate((String) args[0]);

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "getSpecialChangeRate"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "getSpecialChangeRate"));
		}

	}
	
	public String getPeriodChangerate(ProceedingJoinPoint pJointPoint)
			throws Throwable {

		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"getPeriodChangerate"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = pJointPoint.getArgs();

				logger.logDebug("Argumentos" + args[0]);

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((String) args[0]));

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", "Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006",
								"getSpecialChangeRate", serviceIntegration));

						// Call the method with the correct type
						return serviceIntegration
								.getPeriodChangerate((String) args[0]);

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "getPeriodChangerate"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "getPeriodChangerate"));
		}

	}

	public Long manageItem(JoinPoint jointPoint) {
		Item it = new Item();
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.001", "manageItem"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				it = (Item) args[0];

				// Get a reference for the Portfolio Service Integration
				ServiceReference reference = bundleContext
						.getServiceReference(IPortfolioItemsManager.class
								.getName());

				if (reference != null) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.004", reference,
							IPortfolioItemsManager.class.getName()));

					// Get the implementation instance
					IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
							.getService(reference);

					// Call the method with the correct type
					serviceIntegration.manageItem(it);

				} else {
					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.005",
							IPortfolioItemsManager.class.getName()));
				}
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGERINTERCEPTOR.007"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "manageItem"));
		}
		return it.getId();
	}

	public void deleteItem(JoinPoint jointPoint) {
		Long it;
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.001", "deleteItem"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				it = (Long) args[0];

				// Get a reference for the Portfolio Service Integration
				ServiceReference reference = bundleContext
						.getServiceReference(IPortfolioItemsManager.class
								.getName());

				if (reference != null) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.004", reference,
							IPortfolioItemsManager.class.getName()));

					// Get the implementation instance
					IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
							.getService(reference);

					// Call the method with the correct type
					serviceIntegration.deleteItem(it);

				} else {
					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.005",
							IPortfolioItemsManager.class.getName()));
				}
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGERINTERCEPTOR.007"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "deleteItem"));
		}
	}

	public List<Catalog> getItemsGroup(ProceedingJoinPoint pJointPoint)
			throws Throwable {

		logger.logDebug(MessageManager.getString("ITEMSMANAGERINTERCEPTOR.001",
				"getItemsGroup"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = pJointPoint.getArgs();

				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents(((String) args[0]));

				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.PORTFOLIO
						.getModuleId()) {

					logger.logDebug(MessageManager.getString(
							"ITEMSMANAGERINTERCEPTOR.003", "Cartera"));

					// Get a reference for the Portfolio Service Integration
					ServiceReference reference = bundleContext
							.getServiceReference(IPortfolioItemsManager.class
									.getName());

					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.004", reference,
								IPortfolioItemsManager.class.getName()));

						// Get the implementation instance
						IPortfolioItemsManager serviceIntegration = (IPortfolioItemsManager) bundleContext
								.getService(reference);

						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.006", "getItemsGroup",
								serviceIntegration));

						// Call the method with the correct type
						return serviceIntegration.getItemsGroup();

					} else {
						logger.logDebug(MessageManager.getString(
								"ITEMSMANAGERINTERCEPTOR.005",
								IPortfolioItemsManager.class.getName()));
						return null;
					}
				} else {
					return null;
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.007", "getItemsGroup"), e);

			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSMANAGERINTERCEPTOR.002", "getItemsGroup"));
		}

	}
	// end-region

}
