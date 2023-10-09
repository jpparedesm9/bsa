package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.References;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.ReferencesManager;

public class CreateReferences extends BaseEvent implements IExecuteCommand{
	
	private static final ILogger LOGGER = LogFactory
			.getLogger(CreateReferences.class);

	public CreateReferences(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try {
			
			LOGGER.logDebug("Starte Create References");
			
			DataEntity requestEntity = entities.getEntity(References.ENTITY_NAME);
			int customerId = requestEntity.get(References.CUSTOMERCODE);
			
			CustomerReferenceRequest referencesRequest = new CustomerReferenceRequest();
			
			referencesRequest.setCustomerCode(customerId);
			referencesRequest.setName(requestEntity.get(References.NAMES));
			
			referencesRequest.setFirstLastName(requestEntity.get(References.FIRSTLASTNAME));
			referencesRequest.setSecondLastName(requestEntity.get(References.SECONDLASTNAME));
			referencesRequest.setAddress(requestEntity.get(References.ADDRESS));
			referencesRequest.setHomePhone(requestEntity.get(References.HOMEPHONE));
			referencesRequest.setCellPhone(requestEntity.get(References.CELLPHONE));
			referencesRequest.setOfficePhone(requestEntity.get(References.OFFICEPHONE));
			referencesRequest.setRelationship(requestEntity.get(References.RELATIONSHIP));
			referencesRequest.setDescription(requestEntity.get(References.DESCRIPTION));
			referencesRequest.setNeighborhood(requestEntity.get(References.NEIGHBORHOOD));
			referencesRequest.setStreet(requestEntity.get(References.STREET));
			referencesRequest.setNumberOfReferences(requestEntity.get(References.NUMBEROFREFERENCES));
			referencesRequest.setColony(requestEntity.get(References.COLONY));
			referencesRequest.setLocation(requestEntity.get(References.LOCATIONS));
			referencesRequest.setMunicipality(requestEntity.get(References.MUNICIPALITY));
			referencesRequest.setState(requestEntity.get(References.STATE));
			referencesRequest.setPostalCode(requestEntity.get(References.POSTALCODE));
			referencesRequest.setCountry(requestEntity.get(References.COUNTRY));
			referencesRequest.setKnownTime(requestEntity.get(References.KNOWNTIME));
			referencesRequest.setEmail(requestEntity.get(References.EMAIL));
			
			ReferencesManager referencessManager = new ReferencesManager(getServiceIntegration());

			Integer actualReferencesCode = requestEntity.get(References.REFERENCES);
			
			if (actualReferencesCode == 0) {
				int referencesCode = referencessManager.createReferences(referencesRequest, args);
				requestEntity.set(References.REFERENCES, referencesCode);
				LOGGER.logDebug("CODIGO DE REFERENCIA SETEADO " + requestEntity.get(References.REFERENCES));
			} else{
				referencesRequest.setReferences(actualReferencesCode);
				referencessManager.updateReferences(referencesRequest, args);
			}
			
			args.setSuccess(true);
		}  catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_REFERENCES, e, args, LOGGER);
		}
		
	}

}
