package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.GeoreferencingRequest;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class GeoLocationManager extends BaseEvent {
	
	public GeoLocationManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void createUpdateGeoLocation(GeoreferencingRequest geoRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		geoRequest.setChannel("CWC");
		callService.callService(RequestName.GEO_REQUEST, geoRequest, ServiceId.CREATE_GEOLOCATION, arg1);

	}

	
	public void deleteGeoLocation(GeoreferencingRequest geoRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		geoRequest.setChannel("CWC");
		callService.callService(RequestName.GEO_REQUEST, geoRequest, ServiceId.DELETE_GEOLOCATION, arg1);
	}

}
