package com.cobiscorp.ecobis.web.fpm.operation.service.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.ucsp.request.dto.ProductsRulesFilteredRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.web.fpm.operation.service.IBankingProductManager;

@Path("/cobis/web/clientviewer/BankingProductManager")
@Component
@Service({ IBankingProductManager.class })
public class BankingProductManager extends ServiceBase implements
		IBankingProductManager {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(BankingProductManager.class);

	private static final String BANKING_PRODUCT_STRUCTURE = "FPM.Operation.GetBankinProductsStructure";

	@Override
	@PUT
	@Path("/getBankinProductsStructure")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getBankinProductsStructure() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankinProductsStructure start");
			}

			return this.execute(serviceIntegration, logger,
					BANKING_PRODUCT_STRUCTURE, new Object[] {});
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankinProductsStructure end");
			}
		}
	}

	private static final String BANKING_PRODUCT_APPROVED_STRUCTURE = "FPM.Operation.GetBankinProductsApprovedStructure";

	@Override
	@PUT
	@Path("/getBankinProductsApprovedStructure")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getBankinProductsApprovedStructure() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankinProductsApprovedStructure start");
			}

			return this.execute(serviceIntegration, logger,
					BANKING_PRODUCT_APPROVED_STRUCTURE, new Object[] {});
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankinProductsApprovedStructure end");
			}
		}
	}

	private static final String BANKING_PRODUCT_RULES = "FPM.Operation.GetBankinProductsRulesFiltered";

	@Override
	@PUT
	@Path("/getBankinProductsRulesFiltered")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getBankinProductsRulesFiltered(
			ProductsRulesFilteredRequest request) {

		try {
			String user = (String)SessionManager.getSession().get("user-context-user");
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankinProductsRulesFiltered start");
			}

			return this.execute(serviceIntegration, logger,
					BANKING_PRODUCT_RULES, new Object[] {
							request.getClientId(), user });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankinProductsRulesFiltered end");
			}
		}
	}

	private static final String BANKING_BASIC_INFORMATION = "FPM.Operation.GetBankingProductBasicInformationById";

	@Override
	@PUT
	@Path("/getBankingProductBasicInformationById/{request}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getBankingProductBasicInformationById(
			@PathParam("request") String request) {

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankingProductBasicInformationById start");
			}

			return this.execute(serviceIntegration, logger,
					BANKING_BASIC_INFORMATION, new Object[] { request });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankingProductBasicInformationById end");
			}
		}
	}

	private static final String BANKING_APPROVED_INFORMATION = "FPM.Operation.GetBankingProductApprovedInformationById";

	@Override
	@PUT
	@Path("/getBankingProductApprovedInformationById")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getBankingProductApprovedInformationById(
			String bankingProductId) {

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankingProductApprovedInformationById start");
			}

			return this.execute(serviceIntegration, logger,
					BANKING_APPROVED_INFORMATION,
					new Object[] { bankingProductId });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getBankingProductApprovedInformationById end");
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
