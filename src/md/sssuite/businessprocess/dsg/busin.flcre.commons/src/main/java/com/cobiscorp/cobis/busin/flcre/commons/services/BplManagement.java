package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.ApprovedAssociationResponse;
import cobiscorp.ecobis.workflow.dto.ActivityRequirement;
import cobiscorp.ecobis.workflow.dto.InstanceActivity;
import cobiscorp.ecobis.workflow.dto.RuleProcessHistory;

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

public class BplManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(BplManagement.class);

	public BplManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public RuleProcessHistory[] readPolicy(ServiceRequestTO serviceRequestTO, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEPOLICY, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO ABE POLITICAS 0: " + serviceResponse.getData());
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RuleProcessHistory[]) serviceResponseTO.getValue(ReturnName.RETURNRULEPROCESSHISTORY);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public ApprovedAssociationResponse[] readException(ServiceRequestTO serviceRequestTO, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEEXCEPTIONS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO EXCEPCIONES: " + serviceResponse.getData());
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ApprovedAssociationResponse[]) serviceResponseTO.getValue(ReturnName.RETURNAPPROVEDASSOCIATION);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	} 
	
	public ActivityRequirement[] readActivitiesRequirements(int instaceActivityId,ICommonEventArgs arg1, BehaviorOption options) {		
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso readActivitiesRequirements: ");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		InstanceActivity instanceActivity = new InstanceActivity();
		instanceActivity.setInstanceActivityId(instaceActivityId);
		serviceRequestTO.addValue(RequestName.ININSTANCEACTIVITY, instanceActivity);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEACTIVITIESREQUIREMENTS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO ACTIVIDADES REQUERIDAS TRUE: ");
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();			
			return (ActivityRequirement[]) serviceResponseTO.getValue(ReturnName.RETURNACTIVITIESREQUIREMENT);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	} 
}
