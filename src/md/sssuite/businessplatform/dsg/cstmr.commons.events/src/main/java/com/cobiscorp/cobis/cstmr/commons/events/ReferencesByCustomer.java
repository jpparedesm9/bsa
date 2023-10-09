package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.ParseException;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.CustomerTmpReferences;
import com.cobiscorp.cobis.cstmr.model.References;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.ReferencesManager;

public class ReferencesByCustomer extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ReferencesByCustomer.class);

	public ReferencesByCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void searchReferencesByCustomer(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start searchReferencesByCustomer in ReferencesByCustomer");
		DataEntity customerTmp = entities.getEntity(CustomerTmpReferences.ENTITY_NAME);
		LOGGER.logDebug("customerTmp References---" + customerTmp);
		int customerCode = customerTmp.get(CustomerTmpReferences.CODE);
		LOGGER.logDebug("customerCode References---" + customerCode);
		
		CustomerReferenceRequest request = new CustomerReferenceRequest();
		request.setCustomerCode(customerCode);
		ReferencesManager referencesManager = new ReferencesManager(getServiceIntegration());
		CustomerReferenceResponse[] references = referencesManager.searchReferences(request, args);
		DataEntityList referencesList = new DataEntityList();//entities.getEntityList(References.ENTITY_NAME);
		
		LOGGER.logDebug("REFERENCIA ---" + references);
		for (CustomerReferenceResponse resp : references) {
			DataEntity referencesEntity = new DataEntity();
			referencesEntity.set(References.REFERENCES, resp.getReferences());
			LOGGER.logDebug("referencesList PoupForm Code>>" + resp.getReferences());
			
			referencesEntity.set(References.CUSTOMERCODE, customerCode);
			referencesEntity.set(References.NAMES, resp.getName());
			referencesEntity.set(References.FIRSTLASTNAME, resp.getFirstLastName());
			LOGGER.logDebug("FIRSTLASTNAME >>" + resp.getFirstLastName());
			referencesEntity.set(References.SECONDLASTNAME, resp.getSecondLastName());
			LOGGER.logDebug("SECONDLASTNAME >>" + resp.getSecondLastName());
			referencesEntity.set(References.ADDRESS, resp.getAddress());
			referencesEntity.set(References.HOMEPHONE, resp.getHomePhone());
			referencesEntity.set(References.CELLPHONE, resp.getCellPhone());
			referencesEntity.set(References.OFFICEPHONE, resp.getOfficePhone());
			referencesEntity.set(References.RELATIONSHIP, resp.getRelationship());
			referencesEntity.set(References.DESCRIPTION, resp.getDescription());
			referencesEntity.set(References.NEIGHBORHOOD, resp.getNeighborhood());
			referencesEntity.set(References.STREET, resp.getStreet());
			referencesEntity.set(References.NUMBEROFREFERENCES, resp.getNumberOfReferences());
			referencesEntity.set(References.COLONY, resp.getColony());
			referencesEntity.set(References.LOCATIONS, resp.getLocation());
			referencesEntity.set(References.MUNICIPALITY, resp.getMunicipality());
			referencesEntity.set(References.STATE, resp.getState());
			referencesEntity.set(References.POSTALCODE, resp.getPostalCode());
			referencesEntity.set(References.COUNTRY, resp.getCountry());
			referencesEntity.set(References.KNOWNTIME, resp.getKnownTime());
			referencesEntity.set(References.EMAIL, resp.getEmail());
			LOGGER.logDebug("EMAIL References >>" + resp.getEmail());
			
			referencesList.add(referencesEntity);
		}
		LOGGER.logDebug("referecesList PoupForm Size>>" + referencesList.size());

		entities.setEntityList(References.ENTITY_NAME, referencesList);
		if(referencesList.size()<2)
		{
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_ELCLIENMP_39375");
		}
		
	}

}
