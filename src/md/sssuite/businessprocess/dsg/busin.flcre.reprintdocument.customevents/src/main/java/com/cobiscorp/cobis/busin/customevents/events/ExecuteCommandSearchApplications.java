package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.AplicationResponseList;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.model.Applications;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.SearchCriteriaPrintingDocuments;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;


public class ExecuteCommandSearchApplications extends BaseEvent implements
		IExecuteCommand {

	private static final ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandSearchApplications.class);
	public final static String INAPLICATIONREQUEST = "inApplicationRequest";
	public final static String SERVICEAQUERYCUSTOMERAPPLICATION = "Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication";
	public final static String RETURNQUERYOFFICER = "returnApplicationResponse";
	public final static String RETURNQUERYOFFICERNAME = "returnWorkloadOfficerResponse";
	public final static String OUTAPLICATIONRESPOSE = "OutAplicationResponseList";

	public ExecuteCommandSearchApplications(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try{
			DataEntityList gridApplicationsResult = new DataEntityList();
			entities.setEntityList(Applications.ENTITY_NAME, gridApplicationsResult);
			

			DataEntity gridCriteriaApplicationPrinting = entities
					.getEntity(SearchCriteriaPrintingDocuments.ENTITY_NAME);

			ApplicationRequest applicationRequest = new ApplicationRequest();
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
			ServiceResponse serviceResponse = null;
			AplicationResponseList aplicationResponseList = new AplicationResponseList();
			DataEntity entityContext = entities.getEntity(Context.ENTITY_NAME);

			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.GROUP) != null) {
				applicationRequest.setIsGroup(gridCriteriaApplicationPrinting
						.get(SearchCriteriaPrintingDocuments.GROUP)?'S':'N');
			}
					
			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.CUSTOMERID) != null
					&& gridCriteriaApplicationPrinting
							.get(SearchCriteriaPrintingDocuments.CUSTOMERID) != "") {
				String[] varClient = gridCriteriaApplicationPrinting.get(
						SearchCriteriaPrintingDocuments.CUSTOMERID).split("-");
				applicationRequest.setClient(Integer.valueOf(varClient[0]));
			}
			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.IDAPPLICATION) != null) {
				applicationRequest.setIdrequested(gridCriteriaApplicationPrinting
						.get(SearchCriteriaPrintingDocuments.IDAPPLICATION));
			}
			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.FLOWTYPE) != null) {
				applicationRequest.setLineType(gridCriteriaApplicationPrinting
						.get(SearchCriteriaPrintingDocuments.FLOWTYPE));
			}
			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.ALTERNATECODE) != null) {
				applicationRequest.setAlternateCode(gridCriteriaApplicationPrinting
						.get(SearchCriteriaPrintingDocuments.ALTERNATECODE));
			}
			
			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.CLAIMANTID) != null) {
				applicationRequest.setClaimant(gridCriteriaApplicationPrinting
						.get(SearchCriteriaPrintingDocuments.CLAIMANTID));
			}
			
			if (gridCriteriaApplicationPrinting
					.get(SearchCriteriaPrintingDocuments.FLOWTYPE) != null) {
				LOGGER.logDebug("Tipo de flujo "+gridCriteriaApplicationPrinting.get(SearchCriteriaPrintingDocuments.FLOWTYPE));
				LOGGER.logDebug("Context nemonico reclamos"+entityContext.get(Context.TYPE));
				if(gridCriteriaApplicationPrinting.get(SearchCriteriaPrintingDocuments.FLOWTYPE)
						.equals(entityContext.get(Context.TYPE))){			
					applicationRequest.setNemonic(gridCriteriaApplicationPrinting
						.get(SearchCriteriaPrintingDocuments.FLOWTYPE));
				}
			}
			
			

			serviceRequestTO.getData().put(INAPLICATIONREQUEST, applicationRequest);
			serviceRequestTO.getData().put(OUTAPLICATIONRESPOSE,
					aplicationResponseList);

			serviceResponse = execute(getServiceIntegration(), LOGGER,
					SERVICEAQUERYCUSTOMERAPPLICATION, serviceRequestTO);
			List<Message> errorMessage = new ArrayList<Message>();
			if (serviceResponse.isResult()) {

				serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

				ApplicationResponse[] applicationResponseList = (ApplicationResponse[]) serviceResponseTO
						.getValue(RETURNQUERYOFFICER);

				if (applicationResponseList != null) {
					for (ApplicationResponse applicationResponsel : applicationResponseList) {

						DataEntity gridApplication = new DataEntity();

						gridApplication.set(Applications.APPLICATIONCODE,
								applicationResponsel.getProcessInstance()
										.toString());
						gridApplication.set(Applications.ALTERNATECODE,
								applicationResponsel.getAlternateCode());

						gridApplication.set(Applications.CREDITCODE,
								applicationResponsel.getIdrequested().toString());
						gridApplication.set(Applications.OFFICIAL, "0");
						gridApplication.set(Applications.OFFICIALNAME, "0");
						gridApplication.set(Applications.FLOWTYPE,
								applicationResponsel.getFlowtype());
						gridApplication.set(Applications.DEBTORNAME,
								applicationResponsel.getPrincipalDebtor()
										.toString());
						gridApplication.set(Applications.PRINCIPALDEBTOR,
								applicationResponsel.getDebtorName());
						
						gridApplication.set(Applications.PROPOSEDAMOUNT, applicationResponsel.getAmountRequested());
						
						gridApplication.set(Applications.CURRENCYPROPOSAL,
								applicationResponsel.getCurrencyRequested()
										.toString());
						gridApplication.set(Applications.SELECTION, false);
						if (applicationResponsel.getCity() != null) {
							gridApplication.set(Applications.CITY,
									applicationResponsel.getCity().toString());
						}
						gridApplicationsResult.add(gridApplication);
						
						
					}
				}else{
					args.getMessageManager().showErrorMsg("No existe dato solicitado");
				}
				entities.setEntityList(Applications.ENTITY_NAME,
						gridApplicationsResult);

			} else {

				errorMessage = serviceResponse.getMessages();
				for (Message message : errorMessage) {
					args.getMessageManager().showErrorMsg(
							message.getMessage() + "/n");
				}
				return;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REPRINT_EXECUTE_SEARCH, e, args, LOGGER);
		}

	}

}
