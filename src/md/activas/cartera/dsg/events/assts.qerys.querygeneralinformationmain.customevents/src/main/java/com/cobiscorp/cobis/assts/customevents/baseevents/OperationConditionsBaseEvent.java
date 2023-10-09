package com.cobiscorp.cobis.assts.customevents.baseevents;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationPaymentConditions;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.OperationPaymentColumn;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class OperationConditionsBaseEvent extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(OperationConditionsBaseEvent.class);

	public OperationConditionsBaseEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntity generalInformationConditions(DynamicRequest entities) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia generalInformationConditions");
		}

		DataEntity item = new DataEntity();
		try {

			ServiceRequestTO request = new ServiceRequestTO();
			ServiceResponse response;
			OperationDataRequest operationRequest = new OperationDataRequest();

			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			operationRequest.setBank(loan.get(Loan.LOANBANKID));
			operationRequest.setDateFormat(Parameter.CODEDATEFORMAT);
			operationRequest.setOperation("P");
			request.addValue("inOperationDataRequest", operationRequest);

			response = execute(getServiceIntegration(), logger,
					Parameter.PROCESS_OPERATION_DATA_QUERY, request);

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				OperationPaymentConditions[] itemsResponseOpe = (OperationPaymentConditions[]) resultado
						.getValue("returnOperationPaymentConditions");

				for (OperationPaymentConditions itemsResponse : itemsResponseOpe) {
					item.set(OperationPaymentColumn.ATTRIBUTE3, "S"
							.equals(itemsResponse.getCalculateReturn()) ? true
							: false);
					item.set(OperationPaymentColumn.ATTRIBUTE4, "S"
							.equals(itemsResponse.getAcceptAdvances()) ? true
							: false);
					item.set(OperationPaymentColumn.ATTRIBUTE5, "S"
							.equals(itemsResponse.getFullFee()) ? true : false);
					item.set(OperationPaymentColumn.ATTRIBUTE6, "S"
							.equals(itemsResponse.getCashPayment()) ? true
							: false);
					item.set(OperationPaymentColumn.ATTRIBUTE1,
							itemsResponse.getPaymentType());
					item.set(OperationPaymentColumn.ATTRIBUTE2, ("D"
							.equals(itemsResponse.getApplicationType()) ? "S"
							: "N").toString());
					item.set(OperationPaymentColumn.ATTRIBUTE7,
							itemsResponse.getReductionType());
					break;
				}
				entities.setEntity(OperationPaymentColumn.ENTITY_NAME, item);
			}
		} catch (Exception e) {
			logger.logError(e);
			this.manageException(e, logger);
		}
		return item;
	}
}
