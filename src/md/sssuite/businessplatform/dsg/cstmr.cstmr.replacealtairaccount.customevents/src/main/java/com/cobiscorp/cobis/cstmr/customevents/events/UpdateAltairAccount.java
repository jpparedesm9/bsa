package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.AltairAccount;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerProduct;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectManager;

public class UpdateAltairAccount extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateAltairAccount.class);

	public UpdateAltairAccount(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			DataEntity altairAccount = entities.getEntity(AltairAccount.ENTITY_NAME);
			int customerId = (Integer) SessionManager.getSession().get("PERSON_SECUENTIAL");
			List<CustomerProduct> productList = (List<CustomerProduct>) SessionManager.getSession().get("PRODUC_LIST");

			LOGGER.logDebug("El cliente es: " + customerId);
			LOGGER.logDebug("La cuenta nueva es: " + productList.toString());
			LOGGER.logDebug("La cuenta nueva es.toString: " + SessionManager.getSession().get("PRODUC_LIST").toString());

			NaturalProspectRequest naturalProspectRequest = new NaturalProspectRequest();
			for (CustomerProduct product : productList) {
				if (product.getContractNumber().equals(altairAccount.get(AltairAccount.NEWACCOUNTINDIVIDUAL))) {
					naturalProspectRequest.setProspectId(customerId);
					naturalProspectRequest.setAccountIndividual(product.getContractNumber());
				}
			}
			if (naturalProspectRequest.getAccountIndividual() == null) {
				throw new BusinessException(1, "La cuenta no se encuentra en la sesión");
			} else {
				NaturalProspectManager naturalProspectManager = new NaturalProspectManager(getServiceIntegration());
				naturalProspectManager.updateAltairAccount(naturalProspectRequest, args);
			}
		} catch (BusinessException be) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.ALTAIR_SESSION, be, args, LOGGER);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_ALTAIR, e, args, LOGGER);
		}

	}

}
