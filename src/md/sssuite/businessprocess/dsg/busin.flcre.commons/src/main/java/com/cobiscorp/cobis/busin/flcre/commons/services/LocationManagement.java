package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LocationManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(LocationManagement.class);

	public LocationManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public OfficeResponse getOffice(int officeCode, ICommonEventArgs arg1, BehaviorOption options) {
		OfficeRequest dto = new OfficeRequest();
		dto.setId(officeCode);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INOFFICEREQUEST, dto);
//trn 1572
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADOFFICE, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Ciudad recuperada para oficina:" + officeCode);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (OfficeResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNOFFICERESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
}
