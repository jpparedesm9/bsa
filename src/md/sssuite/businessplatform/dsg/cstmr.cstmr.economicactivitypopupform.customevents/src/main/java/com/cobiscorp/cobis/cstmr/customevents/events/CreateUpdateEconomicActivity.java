package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.EconomicActivity;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;


public class CreateUpdateEconomicActivity extends BaseEvent implements IExecuteCommand{

	private static final ILogger LOGGER = LogFactory.getLogger(CreateUpdateEconomicActivity.class);
	
	public CreateUpdateEconomicActivity(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs eventArgs) {
		try{
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia CreateUpdateEconomicActivity");}

		ServiceRequestTO request = new ServiceRequestTO();
		
		DataEntity economicActivity = entities.getEntity(EconomicActivity.ENTITY_NAME);

		EconomicActivityDataRequest economicActivityDataRequest = new EconomicActivityDataRequest();
		
		Integer sequential;
		String verified = "N";
		String serviceName = "CustomerDataManagementService.CustomerManagement.CreateEconomicActivity";
		sequential = economicActivity.get(EconomicActivity.SECUENTIAL);
		
		if (sequential != 0) {
			economicActivityDataRequest.setSequential(sequential);
			serviceName = "CustomerDataManagementService.CustomerManagement.UpdateEconomicActivity";
		} else {
			economicActivity.set(EconomicActivity.SUBACTIVITY, " ");
			economicActivity.set(EconomicActivity.INCOMESOURCE, " ");
			economicActivity.set(EconomicActivity.ATENTIONDAYS, " ");
			economicActivity.set(EconomicActivity.ATTENTIONSCHEDULE, " ");
			economicActivity.set(EconomicActivity.ACTIVITYSCHEDULE, " ");
			economicActivity.set(EconomicActivity.ACTIVITYSTATUS, "V");
		}
		
		economicActivityDataRequest.setCustomer(economicActivity.get(EconomicActivity.PERSONSECUENTIAL));
		economicActivityDataRequest.setEconomicActivity(economicActivity.get(EconomicActivity.ECONOMICACTIVITY));
		economicActivityDataRequest.setDescription(economicActivity.get(EconomicActivity.DESCRIPTION));
		economicActivityDataRequest.setSector(economicActivity.get(EconomicActivity.ECONOMICSECTOR));
		economicActivityDataRequest.setSubSector(economicActivity.get(EconomicActivity.SUBSECTOR));
		economicActivityDataRequest.setPrincipal(economicActivity.get(EconomicActivity.PRINCIPAL));
		economicActivityDataRequest.setStartDate(GeneralFunction.convertDateToCalendar(economicActivity.get(EconomicActivity.STARTDATEACTIVITY)));
		economicActivityDataRequest.setAntiquity(economicActivity.get(EconomicActivity.ANTIQUITY));
		economicActivityDataRequest.setEnvironment(economicActivity.get(EconomicActivity.ENVIRONMENT));
		economicActivityDataRequest.setAuthorized(economicActivity.get(EconomicActivity.AUTHORIZED));
		economicActivityDataRequest.setAffiliate(economicActivity.get(EconomicActivity.AFFILIATE));
		economicActivityDataRequest.setAffiliationPlace(economicActivity.get(EconomicActivity.PLACEAFFILIATION));
		economicActivityDataRequest.setNumberEmployees(economicActivity.get(EconomicActivity.NUMBEREMPLOYEES));
		economicActivityDataRequest.setPropertyType(economicActivity.get(EconomicActivity.PROPERTYTYPE));
		economicActivityDataRequest.setSubActivity(economicActivity.get(EconomicActivity.SUBACTIVITY));
		economicActivityDataRequest.setIncomeSource(economicActivity.get(EconomicActivity.INCOMESOURCE));
		economicActivityDataRequest.setAttentionDays(economicActivity.get(EconomicActivity.ATENTIONDAYS));
		economicActivityDataRequest.setAttentionSchedule(economicActivity.get(EconomicActivity.ATTENTIONSCHEDULE));
		economicActivityDataRequest.setActivitySchedule(economicActivity.get(EconomicActivity.ACTIVITYSCHEDULE));
		economicActivityDataRequest.setActivityStatus(economicActivity.get(EconomicActivity.ACTIVITYSTATUS));
		economicActivityDataRequest.setCaedec(economicActivity.get(EconomicActivity.CAEDEC));
		
		if (economicActivity.get(EconomicActivity.VERIFIED) != null)
			verified = economicActivity.get(EconomicActivity.VERIFIED);
		
		economicActivityDataRequest.setVerified(verified);
		economicActivityDataRequest.setVerificationSource(economicActivity.get(EconomicActivity.VERFICATIONSOURCE));
		
		if (economicActivity.get(EconomicActivity.VERIFICATIONDATE) != null)
			economicActivityDataRequest.setVerificationDate(GeneralFunction.convertDateToCalendar(economicActivity.get(EconomicActivity.VERIFICATIONDATE)));
				
		request.addValue("inEconomicActivityDataRequest", economicActivityDataRequest);

		ServiceResponse response = this.execute(LOGGER, serviceName, request);

		if (response.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
			if (serviceResponseTO.isSuccess()) {
				String mensaje = "Registro guardado correctamente";
				eventArgs.getMessageManager().showInfoMsg(mensaje);
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(response.getMessages(), null);
			eventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		}
		catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_UPDATE_ECONOMIC_ACTIVITY, e, eventArgs, LOGGER);
		}
	}
}
