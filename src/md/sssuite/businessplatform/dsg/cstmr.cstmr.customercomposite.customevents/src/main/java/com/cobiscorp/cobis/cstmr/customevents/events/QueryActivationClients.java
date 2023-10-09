package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectManager;

public class QueryActivationClients extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryActivationClients.class);

	public QueryActivationClients(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void activationClients(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		LOGGER.logDebug("Inicia activationClients");
		try {
			
			DataEntity requestEntity = entities.getEntity(NaturalPerson.ENTITY_NAME);
			int customerId = requestEntity.get(NaturalPerson.PERSONSECUENTIAL);
			
			LOGGER.logDebug("activationClients: El cliente a evaluar es: " + customerId);
			
			NaturalProspectRequest naturalProspectRequest = new NaturalProspectRequest();
			naturalProspectRequest.setProspectId(customerId);
			
			NaturalProspectManager naturalProspectManager = new NaturalProspectManager(getServiceIntegration());
			HashMap<String, String> mensaes = null;
			
			if (customerId != 0) {
				mensaes = naturalProspectManager.queryActivations(naturalProspectRequest, args);
				
				for (Map.Entry<String, String> entry : mensaes.entrySet()) {
					LOGGER.logDebug("MAPA clave=" + entry.getKey() + ", valor=" + entry.getValue());
					if(!entry.getValue().equals("0")){
						args.getMessageManager().showInfoMsg(entry.getValue(),null,12000);
					}
				}
			}
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_BUSSINESS, e, args, LOGGER);
		}
	}

}
