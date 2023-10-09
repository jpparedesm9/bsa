package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.cobis.cstmr.model.PostalCodeTmp;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;

public class CargarEstadosMunicipios extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(CreateAddress.class);

	public CargarEstadosMunicipios(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	
	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs changedEventArgs) {		
		//LoadEconomicActivities loadEconomicActivitiesList = new LoadEconomicActivities(getServiceIntegration());
		//loadEconomicActivitiesList.loadEconomicActivities(entities);
		AddressResponse response = new AddressResponse();
		try {
			DataEntity requestEntity = entities.getEntity(PhysicalAddress.ENTITY_NAME);
			//DataEntity responseEntity = entities.getEntity(PostalCodeTmp.ENTITY_NAME);
			AddressRequest addressRequest = new AddressRequest();
			LOGGER.logDebug("codigo postal Santander>>" + requestEntity.get(PhysicalAddress.POSTALCODE));
			addressRequest.setPostalCode(requestEntity.get(PhysicalAddress.POSTALCODE));
			
			AddressManager addressManager = new AddressManager(getServiceIntegration());
			response =addressManager.searchZipCode(addressRequest, changedEventArgs);
			
			/*responseEntity.set(PostalCodeTmp.PROVINCECODE, response.getProvinceCode());
			responseEntity.set(PostalCodeTmp.CITYCODE, response.getCityCode());
			responseEntity.set(PostalCodeTmp.PARISHCODE, response.getParishCode());	
			
			entities.setEntity(PostalCodeTmp.ENTITY_NAME, responseEntity);*/
			
			requestEntity.set(PhysicalAddress.PROVINCECODE, response.getProvinceCode());
			requestEntity.set(PhysicalAddress.CITYCODE, response.getCityCode());
			requestEntity.set(PhysicalAddress.PARISHCODE, response.getParishCode());	
			
			entities.setEntity(PhysicalAddress.ENTITY_NAME, requestEntity);			
			changedEventArgs.setSuccess(true);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOAD_STATE, e, changedEventArgs, LOGGER);
		}
		
		
	}
	
	
}
