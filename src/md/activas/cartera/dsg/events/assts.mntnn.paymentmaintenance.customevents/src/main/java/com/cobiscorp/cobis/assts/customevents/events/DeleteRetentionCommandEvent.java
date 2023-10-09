package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.RetentionRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.MethodsRetention;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class DeleteRetentionCommandEvent extends BaseEvent implements
		IGridRowDeleting {

	public DeleteRetentionCommandEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private static final ILogger logger = LogFactory
			.getLogger(DeleteRetentionCommandEvent.class);



	@Override
	public void rowAction(DataEntity methodRetention,
			IGridRowActionEventArgs args) {
		try{
		ServiceRequestTO request = new ServiceRequestTO();

		RetentionRequest retentionRequest = new RetentionRequest();
		retentionRequest.setConcept(methodRetention
				.get(MethodsRetention.PRODUCT));
		request.addValue("inRetentionRequest", retentionRequest);
		ServiceResponse response = this.execute(logger,
				Parameter.PROCESSDELETERETTENTION, request);
		RetentionCreateResponse(response, args);
		
	} catch (Exception ex) {
		manageException(ex, logger);
		args.getMessageManager().showErrorMsg(
				"ASSTS.MSG_ASSTS_NOSEPUDEP_50106");

	}
	}

	private void RetentionCreateResponse(ServiceResponse response, IGridRowActionEventArgs args) {
		GeneralFunction.handleResponse(args, response, null);
		
	}

}
