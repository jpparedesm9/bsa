package com.cobiscorp.cobis.assts.customevents.baseevents;

import java.text.SimpleDateFormat;

import cobiscorp.ecobis.assets.cloud.dto.AmortizationDetail;
import cobiscorp.ecobis.assets.cloud.dto.AmortizationDetailRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentValues;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.Payment;
import com.cobiscorp.cobis.assts.model.PrepaymentRate;
import com.cobiscorp.cobis.assts.model.QuoteDetailPayment;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class QuotaDetailBaseEvent extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(QuotaDetailBaseEvent.class);

	public QuotaDetailBaseEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntityList quotaDetailPayment(DynamicRequest entities) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia quotaDetailPayment");
		}

		try {

			ServiceRequestTO request = new ServiceRequestTO();
			ServiceResponse response;
			AmortizationDetailRequest detailRequest = new AmortizationDetailRequest();

			logger.logDebug("quotaDetailPayment seteo LOAN");
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
			DataEntity prepaymentRate = paymentFuction(entities);

			detailRequest.setBanco(loan.get(Loan.LOANBANKID));
			detailRequest.setDividendo(0);
			detailRequest.setTipoCobro("P".charAt(0));//negotiation.get(Negotiation.PAYMENTTYPE)//.charAt(0));// "A"P"E"			
			detailRequest.setTipoProyeccion(null);
			SimpleDateFormat fecha = new SimpleDateFormat(Parameter.DATEFORMATMMDDYYYY);
			SimpleDateFormat fechaRes = new SimpleDateFormat(Parameter.DATEFORMAT);
			if (payment.get(Payment.DATE) != null) {
				detailRequest.setFecha(fecha.format(payment.get(Payment.DATE)));
			}
			detailRequest.setFormatoFecha(Parameter.CODEDATEFORMAT);
			detailRequest.setTasaPrepago(prepaymentRate.get(PrepaymentRate.PERCENTAGE));			
			detailRequest.setMoneda(payment.get(Payment.CURRENCYTYPE));
			detailRequest.setVlrsec(0);

			request.addValue("inAmortizationDetailRequest", detailRequest);

			response = execute(getServiceIntegration(), logger, Parameter.PROCESS_QUOTA_DETAIL_PAYMENT, request);

			if (!(response.isResult())) {
				return null;
			}
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();

			AmortizationDetail[] itemsResponsePayment = (AmortizationDetail[]) resultado
					.getValue("returnAmortizationDetail");
			DataEntityList dataEntityList = entities
					.getEntityList(QuoteDetailPayment.ENTITY_NAME);
			for (AmortizationDetail itemsResponse : itemsResponsePayment) {
				DataEntity item = new DataEntity();
				item.set(QuoteDetailPayment.NUMQUOTE, itemsResponse.getNumCuota());				
				item.set(QuoteDetailPayment.EXPIRED, fechaRes.parse(itemsResponse.getFecVen()));
				item.set(QuoteDetailPayment.PAYMENT, itemsResponse.getPago());
				item.set(QuoteDetailPayment.STATUS, itemsResponse.getEstado());				
				dataEntityList.add(item);
			}
			return dataEntityList;
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("exQuotaDetailPayment", e);
			}
		}
		return null;
	}

	private DataEntity paymentFuction(DynamicRequest entities) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("paymentFuction PERCENTAGE");
		}
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);		
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();
		loanPaymentRequest.setPaymentType("A");
		loanPaymentRequest.setPaymentTypeCan("A");
		loanPaymentRequest.setCancel("N");
		loanPaymentRequest.setDateFormat(103);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);
		
		ServiceResponse serviceResponse = this.execute(logger,
				Parameter.PROCESS_LOAN_PAYMENT, serviceRequestTO);
		DataEntity dataEntity = new DataEntity();
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
					.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanPaymentValues[] loanPaymentValues = (LoanPaymentValues[]) serviceResponseTO
						.getValue("returnLoanPaymentValues");				
				
				for (LoanPaymentValues paymentValues : loanPaymentValues) {
					dataEntity.set(PrepaymentRate.PERCENTAGE,
							paymentValues.getPercentage());					
					break;
				}
				entities.setEntity(PrepaymentRate.ENTITY_NAME, dataEntity);
			}
		}		
		return dataEntity;
	}

}
