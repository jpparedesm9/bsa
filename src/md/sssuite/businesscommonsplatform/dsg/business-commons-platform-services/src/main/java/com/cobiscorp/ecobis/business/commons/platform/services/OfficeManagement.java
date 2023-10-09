package com.cobiscorp.ecobis.business.commons.platform.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ReturnName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

public class OfficeManagement extends BaseEvent {

	// private static final ILogger LOGGER = LogFactory.getLogger(OfficeManagement.class);

	public OfficeManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public OfficeGeoResponse searchOfficeGeo(OfficeGeoRequest officerRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callServices = new CallServices(getServiceIntegration());
		return (OfficeGeoResponse) callServices.callServiceWithReturn(RequestName.INOFFICEGEOREQUEST, officerRequest, ServiceId.SEARCHOFFICEGEO, ReturnName.RETURNOFFICEGEO, arg1);
	}
}
