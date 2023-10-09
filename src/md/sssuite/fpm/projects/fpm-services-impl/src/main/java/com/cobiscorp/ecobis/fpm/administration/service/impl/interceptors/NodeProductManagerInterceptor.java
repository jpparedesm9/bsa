package com.cobiscorp.ecobis.fpm.administration.service.impl.interceptors;

import org.aspectj.lang.JoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.integration.service.INodeProductManagerIntegration;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class NodeProductManagerInterceptor implements BundleContextAware {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(NodeProductManagerInterceptor.class);
	/** OSGI Bundle context */
	private BundleContext bundleContext;

	/**
	 * Method executed after the normal execution of the method manageCategories
	 * 
	 * @param jointPoint
	 *            Spring JoinPoint contains the information of the executing
	 *            method
	 */
	public void manageCategories(JoinPoint jointPoint) {
		try {
			logger.logDebug(MessageManager.getString(
					"NODEPRODUCTMANAGERINTERCEPTOR.001", "manageCategories"));
			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				logger.logDebug(MessageManager
						.getString("NODEPRODUCTMANAGERINTERCEPTOR.003"));
				// Get a reference for the service Integration
				ServiceReference reference = bundleContext
						.getServiceReference(INodeProductManagerIntegration.class
								.getName());
				// If one was found
				if (reference != null) {
					logger.logDebug(MessageManager.getString(
							"NODEPRODUCTMANAGERINTERCEPTOR.004", reference));
					INodeProductManagerIntegration serviceIntegration = (INodeProductManagerIntegration) bundleContext
							.getService(reference);
					logger.logDebug(MessageManager.getString(
							"NODEPRODUCTMANAGERINTERCEPTOR.005",
							"manageCategories",
							"INodeProductManagerIntegration"));
					// Get the arguments
					Object[] args = jointPoint.getArgs();
					// Call the service integration method
					serviceIntegration.manageCategories((String) args[0],
							(Long) args[1], (NodeTypeCategory) args[2]);
				}
			}
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("NODEPRODUCTMANAGERINTERCEPTOR.006"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"NODEPRODUCTMANAGERINTERCEPTOR.002", "manageCategories"));
		}
	}

	
	public void setBundleContext(BundleContext bundleContext) {
		this.bundleContext = bundleContext;
	}
}
