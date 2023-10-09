package com.cobiscorp.ecobis.web.fpm.catalogs.service.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.web.fpm.catalogs.service.ICatalogManager;

@Path("/cobis/web/clientviewer/CatalogManager")
@Component
@Service({ ICatalogManager.class })
public class CatalogManager extends ServiceBase implements ICatalogManager {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(CatalogManager.class);

	private static final String ALL_CURRENCIES = "FPM.Catalogs.GetAllCurrencies";

	@Override
	@PUT
	@Path("/getAllCurrencies")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllCurrencies() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllCurrencies start");
			}

			return this.execute(serviceIntegration, logger, ALL_CURRENCIES,
					new Object[] {});
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllCurrencies end");
			}
		}

	}

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
