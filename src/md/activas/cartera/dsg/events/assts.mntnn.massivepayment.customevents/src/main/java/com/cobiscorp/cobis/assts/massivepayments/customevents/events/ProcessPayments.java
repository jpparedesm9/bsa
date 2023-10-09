package com.cobiscorp.cobis.assts.massivepayments.customevents.events;

import com.cobiscorp.cobis.assts.model.MassivePaymentFile;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.payments.dto.PaymentProcessResponse;
import cobiscorp.ecobis.payments.dto.PaymentRecord;

public class ProcessPayments extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ReadFile.class);

	public ProcessPayments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		DataEntity entityFile = entities.getEntity(MassivePaymentFile.ENTITY_NAME);
		String fileName = null;
		try {			
			fileName = entityFile.get(MassivePaymentFile.FILENAME);
			ServiceRequestTO request = new ServiceRequestTO();
			PaymentRecord paymentRecordRequest = new PaymentRecord();
			paymentRecordRequest.setFileName(fileName);
			request.addValue("inPaymentRecord", paymentRecordRequest);
			ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
					"Payments.MassivePayment.ExecutePayments", request);

			ServiceResponse responseGetResults = this.execute(getServiceIntegration(), LOGGER,
					"Payments.MassivePayment.GetPaymentsResult", request);
			PaymentProcessResponse paymentProcessResponse = null;
			if (responseGetResults.isResult()) {
				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) responseGetResults.getData();
				paymentProcessResponse = (PaymentProcessResponse) serviceResponseTO
						.getValue("returnPaymentProcessResponse");
			}
			if (paymentProcessResponse != null) {
				entityFile.set(MassivePaymentFile.PROCESSEDRECORDS, paymentProcessResponse.getSuccessRegisters());
				entityFile.set(MassivePaymentFile.PROCESSEDAMOUNT, paymentProcessResponse.getAmountProcessed());
			}
		} catch (Exception e) {
			LOGGER.logError("Error procesando los pagos del archivo " + fileName, e);
			args.getMessageManager().showErrorMsg("Error procesando el archivo " + fileName);
			args.setSuccess(false);
		}
	}

}
