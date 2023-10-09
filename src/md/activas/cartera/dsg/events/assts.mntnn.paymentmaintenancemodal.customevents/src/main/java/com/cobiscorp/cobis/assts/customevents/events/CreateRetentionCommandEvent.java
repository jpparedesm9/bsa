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
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CreateRetentionCommandEvent extends BaseEvent implements
		IExecuteCommand {

	public CreateRetentionCommandEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private static final ILogger logger = LogFactory
			.getLogger(CreateRetentionCommandEvent.class);

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try {
			Integer mode = args.getParameters().getMode().getMode();

			if (mode.equals(1)) {

				ServiceRequestTO request = new ServiceRequestTO();
				DataEntity methodsRetention = entities
						.getEntity(MethodsRetention.ENTITY_NAME);

				RetentionRequest retentionRequest = new RetentionRequest();
				retentionRequest.setConcept(methodsRetention
						.get(MethodsRetention.PRODUCT));
				retentionRequest.setDescription(methodsRetention
						.get(MethodsRetention.DESCRIPTION));
				retentionRequest.setCategory(methodsRetention
						.get(MethodsRetention.CATEGORY));
				retentionRequest.setPCobis(methodsRetention
						.get(MethodsRetention.PCOBIS));
				retentionRequest.setDisbursement(methodsRetention
						.get(MethodsRetention.DISBURSEMENT));
				retentionRequest.setPayment(methodsRetention
						.get(MethodsRetention.PAYMENT));
				retentionRequest.setPaymentAut(methodsRetention
						.get(MethodsRetention.PAYMENTAUT));
				retentionRequest.setAffectation(methodsRetention
						.get(MethodsRetention.TRANSACCTION));
				retentionRequest.setRetention(methodsRetention
						.get(MethodsRetention.RETENTIONDAYS));
				retentionRequest.setCurrency(methodsRetention
						.get(MethodsRetention.CURRENCYRETENTION));
				retentionRequest.setAtx(methodsRetention
						.get(MethodsRetention.PAYMENTATX));
				retentionRequest.setState(methodsRetention
						.get(MethodsRetention.STATE));
				retentionRequest.setActPas(methodsRetention
						.get(MethodsRetention.ACTIVEPASSIVE));
				retentionRequest.setProductReverse(methodsRetention.get(MethodsRetention.PAYMENTMETHODS));

				request.addValue("inRetentionRequest", retentionRequest);
				if (logger.isDebugEnabled()) {
					logger.logDebug("retentionRequest: " + request.getData());
				}
				ServiceResponse response = this.execute(logger,
						Parameter.PROCESSCREATERETTENTION, request);

				RetentionCreateResponse(response, args);
			}
			if (mode.equals(2)) {

				ServiceRequestTO request = new ServiceRequestTO();
				DataEntity methodsRetention = entities
						.getEntity(MethodsRetention.ENTITY_NAME);

				RetentionRequest retentionRequest = new RetentionRequest();
				retentionRequest.setConcept(methodsRetention
						.get(MethodsRetention.PRODUCT));
				retentionRequest.setDescription(methodsRetention
						.get(MethodsRetention.DESCRIPTION));
				retentionRequest.setCategory(methodsRetention
						.get(MethodsRetention.CATEGORY));
				retentionRequest.setRetention(methodsRetention
						.get(MethodsRetention.RETENTIONDAYS));
				retentionRequest.setDisbursement(methodsRetention
						.get(MethodsRetention.DISBURSEMENT));
				retentionRequest.setPayment(methodsRetention
						.get(MethodsRetention.PAYMENT));
				retentionRequest.setPaymentAut(methodsRetention
						.get(MethodsRetention.PAYMENTAUT));
				retentionRequest.setAtx(methodsRetention
						.get(MethodsRetention.PAYMENTATX));
				retentionRequest.setValueCode(methodsRetention
						.get(MethodsRetention.VALUECODE));
				retentionRequest.setCurrency(methodsRetention
						.get(MethodsRetention.CURRENCYRETENTION));
				retentionRequest.setPCobis(methodsRetention
						.get(MethodsRetention.PCOBIS));
				 retentionRequest.setProductReverse(methodsRetention.get(MethodsRetention.PAYMENTMETHODS));
				retentionRequest.setState(methodsRetention
						.get(MethodsRetention.STATE));
				retentionRequest.setActPas(methodsRetention
						.get(MethodsRetention.ACTIVEPASSIVE));

				request.addValue("inRetentionRequest", retentionRequest);
				ServiceResponse response = this.execute(logger,
						Parameter.PROCESSUPDATERETTENTION, request);
				RetentionCreateResponse(response, args);

			}

		} catch (Exception ex) {
			manageException(ex, logger);
			args.getMessageManager().showErrorMsg(
					"ASSTS.MSG_ASSTS_NOSEPUDEP_50106");

		}

	}

	private void RetentionCreateResponse(ServiceResponse response, IExecuteCommandEventArgs args) {
		GeneralFunction.handleResponse(args, response, null);
	}

}
