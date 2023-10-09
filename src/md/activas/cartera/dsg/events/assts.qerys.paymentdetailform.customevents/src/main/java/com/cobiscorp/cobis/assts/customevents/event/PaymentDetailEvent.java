package com.cobiscorp.cobis.assts.customevents.event;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationPaymentDetail;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.PaymentDetail;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class PaymentDetailEvent extends BaseEvent implements IExecuteQuery {

	Integer sequentialDet = 0;
	private static final ILogger logger = LogFactory
			.getLogger(PaymentDetailEvent.class);

	public PaymentDetailEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			IExecuteQueryEventArgs args) {
		OperationDataRequest operationDataRequest = new OperationDataRequest();
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList paymentDetailList = new DataEntityList();
		Integer sequentialIns;
		String loanBankID;
		Integer rowsNumber = 0;
		sequentialDet = 0;

		if (args.getParameters().getCustomParameters().get("sequentialIns") != null
				&& args.getParameters().getCustomParameters().get("loanBankID") != null) {

			sequentialIns = Integer.parseInt(args.getParameters()
					.getCustomParameters().get("sequentialIns").toString());
			loanBankID = args.getParameters().getCustomParameters()
					.get("loanBankID").toString();

			operationDataRequest.setBank(loanBankID);
			operationDataRequest
					.setOperation(Parameter.PAYMENT_DETAIL_OPERATION);
			operationDataRequest.setInsertSecuential(sequentialIns);
			
			
			do {
				if (!paymentDetailList.isEmpty()){
					sequentialDet = paymentDetailList.get(paymentDetailList.size()-1).get(PaymentDetail.SEQUENTIAL);
				}
				operationDataRequest.setSecDetPago(sequentialDet);
				request.addValue("inOperationDataRequest", operationDataRequest);

				try {
					ServiceResponse response = this.execute(logger,
							Parameter.PROCESS_PAYMENT_DETAIL_QUERY, request);

					if (response != null && response.isResult()) {
						ServiceResponseTO resultado = (ServiceResponseTO) response
								.getData();

						OperationPaymentDetail[] operationPaymentDetList = (OperationPaymentDetail[]) resultado
								.getValue("returnOperationPaymentDetail");

						if (operationPaymentDetList != null
								&& operationPaymentDetList.length > 0) {
							for (OperationPaymentDetail operationPaymentDetail : operationPaymentDetList) {
								paymentDetailList
										.add(loadDataEntity(operationPaymentDetail));
							}
						}
						if (operationPaymentDetList != null) {
							rowsNumber = operationPaymentDetList.length;
						}

					} else {

						GeneralFunction.handleResponse(args, response, null);
						break;
					}

				} catch (Exception e) {
					logger.logDebug("PaymentDetail.executeQueryEvent(..) -> Exception = "
							+ e);
				}
			} while (rowsNumber == Parameter.REGISTERS_FOR_PAGE);

		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("PaymentDetail.executeQueryEvent -> parameters = null");
			}
			GeneralFunction.handleResponse(args, null, null);
		}
		return paymentDetailList.getDataList();

	}

	private DataEntity loadDataEntity(
			OperationPaymentDetail operationPaymentDetail) {
		DataEntity item = new DataEntity();
		item.set(PaymentDetail.FEE, operationPaymentDetail.getDividend());
		item.set(PaymentDetail.DESCRIPTION, operationPaymentDetail.getConcept());
		item.set(PaymentDetail.STATUSDESCRIPTION,
				operationPaymentDetail.getState());
		item.set(PaymentDetail.ACCOUNT, operationPaymentDetail.getAccount());
		item.set(PaymentDetail.MONEYDESCRIPTION,
				operationPaymentDetail.getCurrency());
		item.set(PaymentDetail.AMOUNT, operationPaymentDetail.getAmountMop());
		item.set(PaymentDetail.AMOUNTMN, operationPaymentDetail.getAmountMle());
		item.set(PaymentDetail.SEQUENTIAL, operationPaymentDetail.getSec());
		return item;
	}

}
