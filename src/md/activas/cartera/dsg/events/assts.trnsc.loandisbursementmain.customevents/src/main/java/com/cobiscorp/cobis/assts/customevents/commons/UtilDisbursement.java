package com.cobiscorp.cobis.assts.customevents.commons;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.DetailPaymentForm;
import com.cobiscorp.cobis.assts.model.DisbursementResult;
import com.cobiscorp.cobis.assts.model.LiquidateResult;
import com.cobiscorp.cobis.assts.model.Loan;
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
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.loadDataGridDetailDisbursement(..) : Entro");
		}
		BigDecimal sumDisbursementTotal = new BigDecimal("0");
		DataEntityList detailDisbursementList = new DataEntityList();

		ReadDisbursementFormResponse[] readDisbursementFormResponse = (ReadDisbursementFormResponse[]) responseTo
				.getValue("returnReadDisbursementFormResponse");
		if ((readDisbursementFormResponse != null)
				&& (readDisbursementFormResponse.length > 0)) {
			for (ReadDisbursementFormResponse detailDisbursement : readDisbursementFormResponse) {
				detailDisbursementList
						.add(loadDataEntityDetailDisbursement(detailDisbursement));
				sumDisbursementTotal = detailDisbursement.getAmountm().add(
						sumDisbursementTotal);
				if (logger.isDebugEnabled()) {
					logger.logDebug("WATQ UtilDisbursement.loadDataGridDetailDisbursement(..) : Amount= "
							+ detailDisbursement.getAmountm());
				}
			}
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.loadDataGridDetailDisbursement(..) : entities="
					+ entities.getData());
		}
		entities.setEntityList(DetailPaymentForm.ENTITY_NAME,
				detailDisbursementList);
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ UtilDisbursement.loadDataGridDetailDisbursement(..) : sumTot= "
					+ sumDisbursementTotal);
		}
		setDisbursementResultEntity(entities, sumDisbursementTotal);
	}

	private void setDisbursementResultEntity(DynamicRequest entities,
			BigDecimal sumDisbursementTotal) {
		DataEntity disbursementResult = entities
				.getEntity(DisbursementResult.ENTITY_NAME);
		DataEntity liquidateResult = entities
				.getEntity(LiquidateResult.ENTITY_NAME);

		if (liquidateResult != null && disbursementResult != null) {
			disbursementResult.set(DisbursementResult.SUMTOTAL,
					sumDisbursementTotal);
			disbursementResult
					.set(DisbursementResult.DIFFERENCE,
							((BigDecimal) liquidateResult
									.get(LiquidateResult.SUMTOTAL))
									.subtract(sumDisbursementTotal));

			entities.setEntity(DisbursementResult.ENTITY_NAME,
					disbursementResult);
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ UtilDisbursement.setDisbursementResultEntity(..) : disbursementResult.getData= "
						+ disbursementResult.getData());
			}
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
				Integer.valueOf(detailDisbursement.getDisbursementId()));
		item.set(DetailPaymentForm.DISBURSEMENTRATE,
				detailDisbursement.getDisbursementrate());
		item.set(DetailPaymentForm.OBSERVATIONS,
				detailDisbursement.getDisbursemenDescripction());
		item.set(DetailPaymentForm.OFFICEID,
				Integer.valueOf(detailDisbursement.getOfficeId()));
		item.set(DetailPaymentForm.OFFICENAME,
				detailDisbursement.getOfficerName());
		item.set(DetailPaymentForm.PRENOTIFICATION,
				Integer.valueOf(detailDisbursement.getPreNotification()));
		item.set(DetailPaymentForm.PRODUCTCATEGORY,
				detailDisbursement.getProductCategory());
		item.set(DetailPaymentForm.QUOTE,
				Double.valueOf(detailDisbursement.getQuote()));
		item.set(DetailPaymentForm.QUOTEOP,
				Double.valueOf(detailDisbursement.getQuoteOp()));
		item.set(DetailPaymentForm.QUOTETYPEOP,
				detailDisbursement.getTypeQuoteOp());
		item.set(DetailPaymentForm.SEQUENTIAL,
				Integer.valueOf(detailDisbursement.getSequential()));
		item.set(DetailPaymentForm.TYPEQUOTATION,
				String.valueOf(detailDisbursement.getContributionRate()));
		return item;
	}

	public void executeLoadDisbursementInformation(DynamicRequest entities) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		String bankId = (String) loan.get(Loan.LOANBANKID);

		ReadDisbursementFormRequest readDisbursementFormRequest = new ReadDisbursementFormRequest();
		readDisbursementFormRequest.setBankReal(bankId);
		readDisbursementFormRequest.setFictitiousBank(bankId);
		readDisbursementFormRequest.setFormatDate(Parameter.CODEDATEFORMAT);
		readDisbursementFormRequest
				.setFromCre(Parameter.PARAMETER_DISBURSEMENT);
		readDisbursementFormRequest
				.setRenewal(Parameter.PARAMETER_DISBURSEMENT);

		request.addValue("inReadDisbursementFormRequest",
				readDisbursementFormRequest);

		request.addValue("inReadDisbursementFormRequest",
				readDisbursementFormRequest);
		try {
			response = execute(getServiceIntegration(), logger,
					Parameter.LOAN_DISBURSEMENT_INFO, request);
		} catch (Exception e) {
			logger.logError("error en el archivo" , e);
		}
		if (logger.isDebugEnabled()) {
			logger.logInfo("WATQ LoanDisbusementInformation.showLoanDisbursementInformation(..) :: Ejecutado execute(getServiceIntegration()");
		}
		if ((response != null) && (response.isResult())) {
			ServiceResponseTO responseTo = (ServiceResponseTO) response
					.getData();
			loadDataGridDetailDisbursement(responseTo, entities);
		}

	}

}
