package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.WorkloadOfficerRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.WorkloadOfficerResponse;
import cobiscorp.ecobis.comext.dto.OfficialComextRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.OfficialLoad;
import com.cobiscorp.cobis.busin.model.OfficialLoadAll;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class OfficerManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(OfficerManagement.class);

	public OfficerManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public OfficerResponse[] searchOfficer(OfficerRequest officerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INOFFICERREQUEST, officerRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHOFFICER, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Oficial recuperados para Id: " + officerRequest.getId());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (OfficerResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNOFFICERRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public String getOfficerName(int officerId, ICommonEventArgs arg1, BehaviorOption options) {
		String officerName = null;

		OfficerRequest officerRequest = new OfficerRequest();
		officerRequest.setId(officerId);
		officerRequest.setType(Mnemonic.STRING_O);

		OfficerResponse[] officerResponses = searchOfficer(officerRequest, arg1, options);
		if (officerResponses != null) {
			for (OfficerResponse officerResponse : officerResponses) {
				if (officerResponse.getOfficerName() != null)
					officerName = officerResponse.getOfficerName();
			}
		}
		return officerName;
	}

	public OfficerResponse getOfficerByLogin(String login, ICommonEventArgs arg1, BehaviorOption options) {
		OfficerRequest officerRequest = new OfficerRequest();
		officerRequest.setLogin(login);
		officerRequest.setType(Mnemonic.STRING_L);

		OfficerResponse[] officerResponses = searchOfficer(officerRequest, arg1, options);
		if (officerResponses != null && officerResponses.length > 0) {
			return officerResponses[0];
		}
		return null;
	}

	public WorkloadOfficerResponse[] getOfficialAssignList(int Office, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("En getOfficialAssignList - Office " + Office);
		WorkloadOfficerRequest workloadOfficerRequest = new WorkloadOfficerRequest();
		workloadOfficerRequest.setConnectionOffice(Office);
		return this.getOfficialList(workloadOfficerRequest, arg1, options);
	}

	public WorkloadOfficerResponse[] getOfficialAssignList(int Office, int Process, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("En getOfficialAssignList - Process " + Process);
		WorkloadOfficerRequest workloadOfficerRequest = new WorkloadOfficerRequest();
		workloadOfficerRequest.setConnectionOffice(Office);
		workloadOfficerRequest.setProcessInstance(Process);
		return this.getOfficialList(workloadOfficerRequest, arg1, options);
	}

	public WorkloadOfficerResponse[] getOfficialList(WorkloadOfficerRequest workloadOfficerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestOfficeTO = new ServiceRequestTO();
		ServiceResponse serviceResponseOfficial = new ServiceResponse();

		serviceRequestOfficeTO.getData().put(RequestName.INWORKLOADOFFICERREQUEST, workloadOfficerRequest);
		serviceResponseOfficial = execute(getServiceIntegration(), logger, ServiceId.SERVICEWORKLOADOFFICE, serviceRequestOfficeTO);

		if (serviceResponseOfficial.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Lista de Oficiales Recuperados");
			ServiceResponseTO serviceResponseOfficeTO = (ServiceResponseTO) serviceResponseOfficial.getData();
			return (WorkloadOfficerResponse[]) serviceResponseOfficeTO.getValue(ReturnName.RETURNWORKLOADOFFICERRESPONSE);
		} else {
			MessageManagement.show(serviceResponseOfficial, arg1, options);
		}
		return null;
	}

	public ServiceResponseTO updateOfficial(ApplicationRequest creditApplicationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestCreditTO = new ServiceRequestTO();
		serviceRequestCreditTO.getData().put(RequestName.INAPPLICATIONREQUEST, creditApplicationRequest);
		ServiceResponse serviceCreditResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEOFFICE, serviceRequestCreditTO);

		if (serviceCreditResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("OFICIAL ACTUALIZADO");
			return (ServiceResponseTO) serviceCreditResponse.getData();
		} else {
			MessageManagement.show(serviceCreditResponse, arg1, options);
		}
		return null;
	}

	public ServiceResponseTO updateOfficialComext(OfficialComextRequest officialComextRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestCreditTO = new ServiceRequestTO();
		serviceRequestCreditTO.getData().put(RequestName.INOFFICIALCOMEXTREQUEST, officialComextRequest);
		ServiceResponse serviceCreditResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEOFFICILCOMEXT, serviceRequestCreditTO);

		if (serviceCreditResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("OFICIAL ACTUALIZADO COMEXT");
			return (ServiceResponseTO) serviceCreditResponse.getData();
		} else {
			MessageManagement.show(serviceCreditResponse, arg1, options);
		}
		return null;
	}

	// Llena la grilla de oficiales x carga
	public void gridOfficer(DynamicRequest entities, IDataEventArgs arg1) {
		logger.logInfo("*************** Empezo Grid oficiales **************************");
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		WorkloadOfficerRequest workloadOfficerRequest = new WorkloadOfficerRequest();

		workloadOfficerRequest.setConnectionOffice(originalHeader.get(OriginalHeader.OFFICE));
		workloadOfficerRequest.setProcessInstance(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
		workloadOfficerRequest.setOption(Mnemonic.CHAR_S);
		
		WorkloadOfficerResponse[] workloadOfficerResponse = this.getOfficialList(workloadOfficerRequest, arg1, new BehaviorOption(true));

		DataEntityList officialLoadEntity = new DataEntityList();
		if (workloadOfficerResponse != null) {
			logger.logInfo("***************servicio de oficiales !=null metodo nuevo**************************");
			if (workloadOfficerResponse.length > 0) {
				for (WorkloadOfficerResponse officerResponse : workloadOfficerResponse) {
					DataEntity oficer = new DataEntity();
					logger.logError("seteando los datos del sercvicio  SERVICEWORKLOADOFFICE" + officerResponse.getOfficerId());
					oficer.set(OfficialLoad.CODEOFFICIAL, officerResponse.getOfficerId());
					oficer.set(OfficialLoad.NAME, officerResponse.getNameOfficer());
					oficer.set(OfficialLoad.INPROCESS, officerResponse.getApplicationsProcess());
					oficer.set(OfficialLoad.DISBURSED, officerResponse.getPaidApplications());
					officialLoadEntity.add(oficer);
				}
				entities.setEntityList(OfficialLoad.ENTITY_NAME, officialLoadEntity);
			}
		}
	}

	// Llena la grilla con todos los oficiales
	public void gridOfficerAll(DynamicRequest entities, IDataEventArgs arg1) {
		logger.logInfo("***************servicio de oficiales ALL **************************");
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		WorkloadOfficerRequest workloadOfficerRequest1 = new WorkloadOfficerRequest();
		workloadOfficerRequest1.setConnectionOffice(originalHeader.get(OriginalHeader.OFFICE));
		workloadOfficerRequest1.setProcessInstance(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
		workloadOfficerRequest1.setOption(Mnemonic.CHAR_N);

		WorkloadOfficerResponse[] workloadOfficerResponse1 = this.getOfficialList(workloadOfficerRequest1, arg1, new BehaviorOption(true));

		DataEntityList officialLoadEntityAll = new DataEntityList();
		if (workloadOfficerResponse1 != null) {
			logger.logInfo("***************servicio de oficiales ALL !=null +++**************************");
			if (workloadOfficerResponse1.length > 0) {
				for (WorkloadOfficerResponse officerResponse1 : workloadOfficerResponse1) {
					DataEntity oficerAll = new DataEntity();
					logger.logError("seteando los datos del sercvicio  SERVICEWORKLOADOFFICE ALL " + officerResponse1.getOfficerId());
					oficerAll.set(OfficialLoadAll.CODEOFFICIAL, officerResponse1.getOfficerId());
					oficerAll.set(OfficialLoadAll.NAME, officerResponse1.getNameOfficer());
					oficerAll.set(OfficialLoadAll.INPROCESS, officerResponse1.getApplicationsProcess());
					oficerAll.set(OfficialLoadAll.DISBURSED, officerResponse1.getPaidApplications());
					officialLoadEntityAll.add(oficerAll);
				}
				entities.setEntityList(OfficialLoadAll.ENTITY_NAME, officialLoadEntityAll);
			}
		}
	}
}
