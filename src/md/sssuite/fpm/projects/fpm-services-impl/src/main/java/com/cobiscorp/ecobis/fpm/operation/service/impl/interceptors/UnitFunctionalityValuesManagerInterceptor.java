/*
 * File: UnitFunctionalityValuesManagerInterceptor.java
 * Date: July 11, 2016
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

import org.aspectj.lang.JoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.model.UnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioUnitFunctionalityValuesManager;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * The interceptor class for UnitFunctionalityValuesManager Class
 * 
 * @author fborja
 */
public class UnitFunctionalityValuesManagerInterceptor implements BundleContextAware {

	// region Fileds
	/** COBIS Logger */
	private final ILogger logger = LogFactory.getLogger(UnitFunctionalityValuesManagerInterceptor.class);

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

	public void setBankingProductManager(IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}

	// end-region
	public void insertUnitFunctionalityValues(JoinPoint jointPoint) throws BusinessException {

		logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.001", "insertUnitFunctionalityValues"));
		try {
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				logger.logDebug("--> Ingresando a iterceptar con bundleContext");
				Object[] args = jointPoint.getArgs();
				logger.logDebug("---> args[0]: " + args[0]); //bankingProductId
				logger.logDebug("---> args[1]: " + args[1]); //list
				logger.logDebug("---> args[2]: " + args[2]); //dictionaryName

				// Get a reference for the Portfolio Service Integration
				ServiceReference reference = bundleContext.getServiceReference(IPortfolioUnitFunctionalityValuesManager.class.getName());
				logger.logDebug("reference-->" + reference);
				if (reference != null) {
					logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.004", reference,
							IPortfolioUnitFunctionalityValuesManager.class.getName()));

					// Get the implementation instance
					IPortfolioUnitFunctionalityValuesManager serviceIntegration = (IPortfolioUnitFunctionalityValuesManager) bundleContext.getService(reference);

					logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.006", "insertUnitFunctionalityValues",
							serviceIntegration));

					// Call the method with the correct type
					serviceIntegration.insertUnitFunctionalityValues( (String) args[0], (ArrayList<UnitFunctionalityValues>) args[1], (String) args[2]);
				}
			}
		} catch(BusinessException ex){
			throw new BusinessException(6900194, "Existió un error a nivel de validación de los datos");
		} catch (Exception e) {
			logger.logError(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.007"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.002", "insertUnitFunctionalityValues"));
		}
	}
	
	public void updateUnitFuntionalityValues(JoinPoint jointPoint) throws BusinessException {

		logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.001", "updateUnitFuntionalityValues"));
		try {
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				logger.logDebug("--> Ingresando a iterceptar con bundleContext");
				Object[] args = jointPoint.getArgs();
				logger.logDebug("---> args[0]: " + args[0]); //bankingProductId
				logger.logDebug("---> args[1]: " + args[1]); //list
				logger.logDebug("---> args[2]: " + args[2]); //dictionaryName

				// Get a reference for the Portfolio Service Integration
				ServiceReference reference = bundleContext.getServiceReference(IPortfolioUnitFunctionalityValuesManager.class.getName());
				logger.logDebug("reference-->" + reference);
				if (reference != null) {
					logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.004", reference,
							IPortfolioUnitFunctionalityValuesManager.class.getName()));

					// Get the implementation instance
					IPortfolioUnitFunctionalityValuesManager serviceIntegration = (IPortfolioUnitFunctionalityValuesManager) bundleContext.getService(reference);

					logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.006", "updateUnitFuntionalityValues",
							serviceIntegration));

					// Call the method with the correct type
					serviceIntegration.updateUnitFuntionalityValues( (String) args[0], (ArrayList<UnitFunctionalityValues>) args[1], (String) args[2]);
				}
			}
		} catch(BusinessException ex){
			throw new BusinessException(6900194, "Existió un error a nivel de validación de los datos");
		} catch (Exception e) {
			logger.logError(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.007"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.002", "updateUnitFuntionalityValues"));
		}
	}

	public void createUnitFunctionalityValuesHistory(JoinPoint jointPoint) {

		logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.001", "createUnitFunctionalityValuesHistory"));
		try {
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				logger.logDebug("INTERCEPTANDO createUnitFunctionalityValuesHistory");
				// Always the first parameter is the productId
				logger.logDebug("Ingresando a iterceptar con bundleContext");
				Object[] args = jointPoint.getArgs();
				logger.logDebug("args[0]-->" + args[0]);
				NodeTypeCategory category = bankingProductManager.getCategoryKeepDictionaryFromParents((String) args[0]);
				// The identifier of the portfolio module is 1
				logger.logDebug("Ingresa Categoría Portfolio" + category.getModule().getModuleId());
				// Get a reference for the Portfolio Service Integration
				ServiceReference reference = bundleContext.getServiceReference(IPortfolioUnitFunctionalityValuesManager.class.getName());
				logger.logDebug("reference-->" + reference);
				if (reference != null) {
					logger.logDebug(MessageManager.getString("GENERALPARAMETERSMANAGERINTERCEPTOR.004", reference,
							IPortfolioGeneralParametersManager.class.getName()));

					// Get the implementation instance
					IPortfolioUnitFunctionalityValuesManager serviceIntegration = (IPortfolioUnitFunctionalityValuesManager) bundleContext
							.getService(reference);

					logger.logDebug(MessageManager.getString("GENERALPARAMETERSMANAGERINTERCEPTOR.006", "saveGeneralParametersValues",
							serviceIntegration));

					// Call the method with the correct type
					serviceIntegration.createUnitFunctionalityValuesHistory((String) args[0], (String) args[1]);

				}
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.007"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("UNITFUNCTIONALITYMANAGERINTERCEPTOR.002", "createUnitFunctionalityValuesHistory"));
		}
	}

	static void validator() throws BusinessException {
		throw new BusinessException(6900001, "Existen valores duplicados");
	}

}
