package com.cobiscorp.cobis.assets.commons.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadPaymentFormRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadPaymentFormResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.DetailPaymentForm;
import com.cobiscorp.cobis.assts.model.DisbursementResult;
import com.cobiscorp.cobis.assts.model.LiquidateResult;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class UtilDisbursement extends BaseEvent {
	private static final ILogger logger = LogFactory
			.getLogger(UtilDisbursement.class);

	public UtilDisbursement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	public void loadDataGridDetailDisbursement(ServiceResponseTO responseTo,
			DynamicRequest entities) {
		BigDecimal sumDisbursementTotal = new BigDecimal("0");
		if (logger.isDebugEnabled()) {
			logger.logDebug("UtilDisbursement.loadDataGridDetailDisbursement(..) : Entro");
		}
		DataEntityList detailDisbursementList = new DataEntityList();
		ReadDisbursementFormResponse[] readDisbursementFormResponse = (ReadDisbursementFormResponse[]) responseTo
				.getValue("returnReadDisbursementFormResponse");

		if (readDisbursementFormResponse != null
				&& readDisbursementFormResponse.length > 0) {
			for (ReadDisbursementFormResponse detailDisbursement : readDisbursementFormResponse) {
				detailDisbursementList
						.add(loadDataEntityDetailDisbursement(detailDisbursement));
				sumDisbursementTotal = detailDisbursement.getAmount().add(
						sumDisbursementTotal);
				if (logger.isDebugEnabled()) {
					logger.logDebug("WATQ UtilDisbursement.loadDataGridDetailDisbursement(..) : Amount= "
							+ detailDisbursement.getAmount());
					logger.logDebug("WATQ UtilDisbursement.loadDataGridDetailDisbursement(..) : sumTot= "
							+ sumDisbursementTotal);

				}
			}
		}
		entities.setEntityList(DetailPaymentForm.ENTITY_NAME,
				detailDisbursementList);
		setDisbursementResultEntity(entities, sumDisbursementTotal);
	}
	private void setDisbursementResultEntity(DynamicRequest entities,
			BigDecimal sumDisbursementTotal) {
		DataEntity disbursementResult = entities
				.getEntity(DisbursementResult.ENTITY_NAME);
		DataEntity liquidateResult = entities
				.getEntity(LiquidateResult.ENTITY_NAME);

		disbursementResult.set(DisbursementResult.SUMTOTAL,
				sumDisbursementTotal);

		disbursementResult.set(DisbursementResult.DIFFERENCE,
				(liquidateResult.get(LiquidateResult.SUMTOTAL))
						.subtract(sumDisbursementTotal));

		entities.setEntity(DisbursementResult.ENTITY_NAME, disbursementResult);
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.setDisbursementResultEntity(..) : disbursementResult.getData= "
					+ disbursementResult.getData());
		}
	}

	private DataEntity loadDataEntityDetailDisbursement(
			ReadDisbursementFormResponse detailDisbursement) {
		DataEntity item = new DataEntity();
		item.set(DetailPaymentForm.ACCOUNT, detailDisbursement.getAccount());
		item.set(DetailPaymentForm.AMOUNT, detailDisbursement.getAmount());
		item.set(DetailPaymentForm.AMOUNTMN, detailDisbursement.getAmountmn());
		item.set(DetailPaymentForm.AMOUNTOP, detailDisbursement.getAmountm());
		item.set(DetailPaymentForm.BENEFICIARY,
				detailDisbursement.getBeneficiary());
		item.set(DetailPaymentForm.CURRENCYDESCRIPTION,
				detailDisbursement.getCurrencyDescription());
		item.set(DetailPaymentForm.CURRENCYID,
				Integer.valueOf(detailDisbursement.getCurrency().trim()));
		item.set(DetailPaymentForm.DISBURSEMENTID,
				detailDisbursement.getDisbursementId());
		item.set(DetailPaymentForm.DISBURSEMENTRATE,
				detailDisbursement.getDisbursementrate());
		item.set(DetailPaymentForm.OBSERVATIONS,
				detailDisbursement.getDisbursemenDescripction());
		item.set(DetailPaymentForm.OFFICEID, detailDisbursement.getOfficeId());
		item.set(DetailPaymentForm.OFFICENAME,
				detailDisbursement.getOfficerName());
		item.set(DetailPaymentForm.PRENOTIFICATION,
				detailDisbursement.getPreNotification());
		item.set(DetailPaymentForm.PRODUCTCATEGORY,
				detailDisbursement.getProductCategory());
		item.set(DetailPaymentForm.QUOTE, detailDisbursement.getQuote());
		item.set(DetailPaymentForm.QUOTEOP, detailDisbursement.getQuoteOp());
		item.set(DetailPaymentForm.QUOTETYPEOP,
				detailDisbursement.getTypeQuoteOp());
		item.set(DetailPaymentForm.SEQUENTIAL,
				detailDisbursement.getSequential());
		item.set(DetailPaymentForm.TYPEQUOTATION,
				String.valueOf(detailDisbursement.getContributionRate()));
		return item;
	}
	
	public String getPaymentFormCategory(DataEntity paymentForm,
			DataEntity loanInf) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.getPaymentFormCategory :: paymentForm= "
					+ paymentForm.getData());
			logger.logDebug("WATQ UtilDisbursement.getPaymentFormCategory :: loanInf= "
					+ loanInf.getData());
		}
		if (paymentForm != null
				&& paymentForm.get(PaymentForm.PAYFORMID) != null
				&& loanInf.get(Loan.DESOPERATIONTYPE) != null
				&& paymentForm.get(PaymentForm.CURRENCYID) != null) {

			ReadPaymentFormRequest readPaymentFormRequest = new ReadPaymentFormRequest();
			readPaymentFormRequest.setOperation(Parameter.OPERATIONA);
			readPaymentFormRequest.setType(Parameter.ONE_VALUE);
			readPaymentFormRequest.setCreditLine(loanInf
					.get(Loan.DESOPERATIONTYPE));
			readPaymentFormRequest.setCurrency(paymentForm
					.get(PaymentForm.CURRENCYID));

			return executeServicePaymentFormCategory(readPaymentFormRequest,
					paymentForm);

		}
		return null;
	}

	private String executeServicePaymentFormCategory(
			ReadPaymentFormRequest readPaymentFormRequest,
			DataEntity paymentForm) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;
		ServiceResponseTO responseTo = null;
		ReadPaymentFormResponse[] returnReadPaymentFormResponse = null;
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.executeServicePaymentFormCategory :: A");

		}
		request.addValue("inReadPaymentFormRequest", readPaymentFormRequest);
		response = execute(getServiceIntegration(), logger,
				Parameter.QUERY_LOAN_PAYFORM_CATEGORY, request);
		if ((response != null) && (response.isResult())) {
			responseTo = (ServiceResponseTO) response.getData();
		}
		if (responseTo != null) {
			returnReadPaymentFormResponse = (ReadPaymentFormResponse[]) responseTo
					.getValue("returnReadPaymentFormResponse");
		}
		if (returnReadPaymentFormResponse != null) {
			return validatePaymentFormCategory(returnReadPaymentFormResponse,
					paymentForm.get(PaymentForm.PAYFORMID));
		}
		return null;
	}

	private String validatePaymentFormCategory(
			ReadPaymentFormResponse[] returnReadPaymentFormResponse,
			String paymentFormId) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.validatePaymentFormCategory(..) :: paymentFormId= "
					+ paymentFormId.trim());
		}

		for (ReadPaymentFormResponse readPaymentFormResponse : returnReadPaymentFormResponse) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ UtilDisbursement.validatePaymentFormCategory(..) :: Product= "
						+ readPaymentFormResponse.getProduct().trim());
			}

			if (readPaymentFormResponse.getProduct().trim()
					.equals(paymentFormId.trim())) {
				logger.logDebug("WATQ UtilDisbursement.validatePaymentFormCategory(..) :: Category= "
						+ readPaymentFormResponse.getCategory());
				return readPaymentFormResponse.getCategory();
			}
		}
		return null;
	}
	public boolean useLoop(String[] arr, String targetValue) {
		for (String s : arr) {
			if (s.trim().equals(targetValue.trim())) {
				return true;
			}
		}
		return false;
	}

}
