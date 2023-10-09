package com.cobiscorp.cobis.assts.customevents.baseevents;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.PaymentSummary;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.OperationDataRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationPaymentSummary;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class PaymentQueryBaseEvent extends BaseEvent {
	private static final ILogger logger = LogFactory
			.getLogger(PaymentQueryBaseEvent.class);

	Integer sequential = 0;

	public PaymentQueryBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntityList loadPaymentList(DynamicRequest entities) {

		Integer rowsNumber = 0;
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList paymentList = entities
				.getEntityList(PaymentSummary.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		try {

			OperationDataRequest operationDataRequest = new OperationDataRequest();
			operationDataRequest.setDateFormat(Parameter.CODEDATEFORMAT);
			operationDataRequest.setOperation(Parameter.OPERATIONA);
			logger.logDebug("SMO OPERACION PAGOS "+operationDataRequest.getOperation());
			
			operationDataRequest.setBank(loan.get(Loan.LOANBANKID));
			
			do {
								
				if (!paymentList.isEmpty()) {
					sequential = paymentList.get(paymentList.size() - 1).get(
							PaymentSummary.SEQUENTIALIDENTITY);
				}
				operationDataRequest.setInsertSecuential(sequential);
				request.addValue("inOperationDataRequest", operationDataRequest);
				ServiceResponse response = this.execute(
						getServiceIntegration(), logger,
						Parameter.PROCESS_PAYMENT_QUERY, request);

				if (!(response.isResult())){
					return null;
				}

				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				OperationPaymentSummary[] operationPaymentList = (OperationPaymentSummary[]) resultado
						.getValue("returnOperationPaymentSummary");
				if (operationPaymentList != null
						&& operationPaymentList.length > 0) {

					for (OperationPaymentSummary operationPayment : operationPaymentList) {
						paymentList.add(loadPayment(operationPayment));
					}
				}

				if (operationPaymentList != null) {
					rowsNumber = operationPaymentList.length;
				}
				
				
			} while (rowsNumber == Parameter.REGISTERS_PAYMENT);//17

			//Trae en bloques a Java y devuelve completo al FRONT END

			entities.setEntityList(PaymentSummary.ENTITY_NAME, paymentList);

		} catch (Exception e) {
			logger.logError(e);
			this.manageException(e, logger);
		}
		return paymentList;
	}

	public DataEntity loadPayment(OperationPaymentSummary operationPayment) {

		DataEntity item = new DataEntity();
	/*	item.set(Payment.SEQUENTIAL, operationPayment.getSecIng());
		item.set(Payment.SEQUENTIALPAY, operationPayment.getSecPag());
		item.set(Payment.DATE, GeneralFunction.convertStringToDate(
				operationPayment.getFechaIng(), TYPEDATEFORMAT.DDMMYYYY));
		item.set(Payment.DATEPAY, GeneralFunction.convertStringToDate(
				operationPayment.getFechaPag(), TYPEDATEFORMAT.DDMMYYYY));
		item.set(Payment.USER, operationPayment.getUser());
		item.set(Payment.REGIONAL, operationPayment.getRegional());
		item.set(Payment.RETENTION, operationPayment.getRetention());
		item.set(Payment.ENTIREFEE, operationPayment.getReferenceAccount());
		item.set(Payment.ADVANCE, operationPayment.getAdvance());
		item.set(Payment.REDUCTIONTYPE, operationPayment.getReductionType());
		item.set(Payment.COLLECTIONTYPE, operationPayment.getShapeToPay());
		item.set(Payment.CATEGORY, operationPayment.getClassPayment());
		item.set(Payment.PAYMENTTYPE,
				String.valueOf(operationPayment.getPaymentType()));
		item.set(Payment.CURRENCYTYPE, operationPayment.getCurrency());
		item.set(Payment.REFERENCEDACCOUNT,
				operationPayment.getReferenceAccount());
		item.set(Payment.NOTE, operationPayment.getComment());
		item.set(Payment.AMOUNT,operationPayment.getAmount());
		item.set(Payment.STATUS, operationPayment.getState());
		item.set(Payment.QUERYSEQUENTIAL, operationPayment.getSecQuery());*/
		item.set(PaymentSummary.SEQUENTIALIDENTITY,operationPayment.getSeqIdentity());
		item.set(PaymentSummary.SEQUENTIALQUERY, operationPayment.getSeqQuery());
		item.set(PaymentSummary.PAYMENTID,operationPayment.getPaymentId());
		item.set(PaymentSummary.PAYMENTWAY,operationPayment.getPaymentWay());
		item.set(PaymentSummary.REGISTERDATE,operationPayment.getRegisterDate());
		item.set(PaymentSummary.VALUEDATE,operationPayment.getValueDate());
		item.set(PaymentSummary.OFFICE,operationPayment.getOffice());
		item.set(PaymentSummary.AMOUNT,operationPayment.getAmount());
		item.set(PaymentSummary.CURRENCY,operationPayment.getCurrency());
		item.set(PaymentSummary.CORRESPONSALID,operationPayment.getCorresponsalId());
		item.set(PaymentSummary.PAYMENTSTATUS,operationPayment.getPaymentStatus());
		item.set(PaymentSummary.USER,operationPayment.getUser());
		item.set(PaymentSummary.MESSAGE,operationPayment.getMessage());
		

		return item;
	}
}
