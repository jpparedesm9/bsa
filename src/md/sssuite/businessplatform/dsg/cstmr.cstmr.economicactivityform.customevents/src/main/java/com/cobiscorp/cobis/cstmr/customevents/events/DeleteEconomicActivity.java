package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.EconomicActivity;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class DeleteEconomicActivity extends BaseEvent implements IGridRowDeleting {

	private static final ILogger LOGGER = LogFactory.getLogger(DeleteEconomicActivity.class);
	
	public DeleteEconomicActivity(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity economicActivityEntity, IGridRowActionEventArgs eventArgs) {
		try{
		ServiceRequestTO request = new ServiceRequestTO();
		
		DataEntity naturalPerson = eventArgs.getDynamicRequest().getEntity(NaturalPerson.ENTITY_NAME);
		
		EconomicActivityDataRequest economicActivityRequest = new EconomicActivityDataRequest();
		economicActivityRequest.setSequential(economicActivityEntity.get(EconomicActivity.SECUENTIAL));
		economicActivityRequest.setCustomer(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
		
		request.addValue("inEconomicActivityDataRequest", economicActivityRequest);
		
		ServiceResponse response = this.execute(LOGGER, "CustomerDataManagementService.CustomerManagement.DeleteEconomicActivity", request);
		
		if (response.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
			if (serviceResponseTO.isSuccess()) {
				String mensaje = "Registro eliminado correctamente";
				eventArgs.getMessageManager().showInfoMsg(mensaje);
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(response.getMessages(), null);
			eventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.DELETE_ECONOMIC_ACTIVITY, e, eventArgs, LOGGER);
		}
		
	}

}
