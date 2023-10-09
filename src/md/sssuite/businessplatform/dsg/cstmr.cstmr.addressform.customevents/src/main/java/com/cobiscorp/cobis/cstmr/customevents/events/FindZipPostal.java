package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;

public class FindZipPostal extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory
			.getLogger(FindZipPostal.class);

	public FindZipPostal(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
			try {
			DataEntity requestEntity = entities.getEntity(PhysicalAddress.ENTITY_NAME);
			AddressRequest addressRequest = new AddressRequest();
			AddressManager addressManager = new AddressManager(	getServiceIntegration());			
			addressRequest.setParishCode(requestEntity.get(PhysicalAddress.PARISHCODE));
			
			AddressResponse addressResponse = addressManager.findZipCode(addressRequest, args);
			LOGGER.logDebug("request parishCode>> "	+ addressRequest.getParishCode() + "response postalCode>> "	+ addressResponse.getPostalCode());
			requestEntity.set(PhysicalAddress.POSTALCODE, addressResponse.getPostalCode() + "");
			
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_ZIP_CODE, e, args, LOGGER);
		}

	}

}
