package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ActivityRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ActivityResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

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

public class ActivityObjectManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(ActivityObjectManagement.class);

	public ActivityObjectManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public ActivityResponse[] getActivityList(String codeObject, ICommonEventArgs arg1, BehaviorOption options) {
		ActivityRequest activityRequest = new ActivityRequest();
		activityRequest.setObjectId(codeObject);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INACTIVITYREQUEST, activityRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHACTOBJE, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Actividades recuperadas para objeto:" + codeObject);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ActivityResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNACTIVITYRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public ActivityResponse[] getObjetsList(String codeActivity, ICommonEventArgs arg1, BehaviorOption options) {
		ActivityRequest activityRequest = new ActivityRequest();
		activityRequest.setActivityId(codeActivity);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INACTIVITYREQUEST, activityRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHOBJEBYACT, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Objetos recuperadas para actividad:" + codeActivity);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ActivityResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNACTIVITYRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

}