package com.cobiscorp.cobis.assets.commons.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.WorkloadOfficerRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.WorkloadOfficerResponse;
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


public class OfficerManagement extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(OfficerManagement.class);

	public OfficerManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	

	public WorkloadOfficerResponse[] getOfficialAssignList(int Office, ICommonEventArgs arg1, BehaviorOption options) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("En getOfficialAssignList - Office " + Office);
		WorkloadOfficerRequest workloadOfficerRequest = new WorkloadOfficerRequest();
		workloadOfficerRequest.setConnectionOffice(Office);
		return this.getOfficialList(workloadOfficerRequest, arg1, options);
	}
	
	public WorkloadOfficerResponse[] getOfficialList(WorkloadOfficerRequest workloadOfficerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestOfficeTO = new ServiceRequestTO();
		ServiceResponse serviceResponseOfficial = new ServiceResponse();

		serviceRequestOfficeTO.getData().put(RequestName.INWORKLOADOFFICERREQUEST, workloadOfficerRequest);
		serviceResponseOfficial = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICEWORKLOADOFFICE, serviceRequestOfficeTO);

		if (serviceResponseOfficial.isResult()) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Lista de Oficiales Recuperados");
			ServiceResponseTO serviceResponseOfficeTO = (ServiceResponseTO) serviceResponseOfficial.getData();
			return (WorkloadOfficerResponse[]) serviceResponseOfficeTO.getValue(ReturnName.RETURNWORKLOADOFFICERRESPONSE);
		} else {
			MessageManagement.show(serviceResponseOfficial, arg1, options);
		}
		return null;
	}

	/*public OfficerResponse[] searchOfficer(OfficerRequest officerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(Parameter.INOFFICERREQUEST, officerRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, Parameter.SEARCHOFFICER, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Oficial recuperados para Id: " + officerRequest.getId());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (OfficerResponse[]) serviceItemsResponseTO.getValue(Parameter.RETURNOFFICERRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}*/
}