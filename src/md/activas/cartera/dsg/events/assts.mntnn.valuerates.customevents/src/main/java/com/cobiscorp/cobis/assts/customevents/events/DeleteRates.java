package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RateRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Rates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class DeleteRates extends BaseEvent implements IGridRowDeleting {

	private static final ILogger logger = LogFactory.getLogger(DeleteRates.class);
	
	public DeleteRates(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity entities, IGridRowActionEventArgs eventArgs) {

		ServiceRequestTO request = new ServiceRequestTO();
		
		RateRequest rateRequest = new RateRequest();
		rateRequest.setOperation("D");
		rateRequest.setOption(1);
		rateRequest.setRateType(entities.get(Rates.RATETYPE));
		rateRequest.setSector(entities.get(Rates.PORTFOLIOCLASS));
		request.addValue("inRateRequest", rateRequest);
		
		ServiceResponse response = this.execute(logger, Parameter.DELETE_VALUES_RATE, request);
		
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
		
	}

}
