package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.customevents.commons.UtilDisbursement;
import com.cobiscorp.cobis.assts.model.DetailPaymentForm;
import com.cobiscorp.cobis.assts.model.DisbursementResult;
import com.cobiscorp.cobis.assts.model.LiquidateResult;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteQueryDetailPaymentForm extends BaseEvent implements
		IExecuteQuery {
	private static final ILogger logger = LogFactory
			.getLogger(RemoveRowDetailPaymentForm.class);

	public ExecuteQueryDetailPaymentForm(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			IExecuteQueryEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logInfo("WATQ ExecuteQueryDetailPaymentForm.executeDataEvent(..) :: entities="
					+ entities.getData());
		}

		BigDecimal sumDisbursementTotal = new BigDecimal(Parameter.ZERO_VALUE);
		DataEntityList detailDisbursementList = new DataEntityList();

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		DataEntity loan = getLoanEntity(entities, args);
		String bankId = loan.get(Loan.LOANBANKID);

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
		try {
			response = execute(getServiceIntegration(), logger,
					Parameter.LOAN_DISBURSEMENT_INFO, request);
		} catch (Exception e) {
			logger.logError("WATQ Error: "+e);
		}
		if (logger.isDebugEnabled()) {
			logger.logInfo("WATQ ExecuteQueryDetailPaymentForm.executeDataEvent(..) :: Ejecutado execute(getServiceIntegration()");
		}
		if ((response != null) && (response.isResult())) {
			ServiceResponseTO responseTo = (ServiceResponseTO) response
					.getData();

			ReadDisbursementFormResponse[] readDisbursementFormResponse = (ReadDisbursementFormResponse[]) responseTo
					.getValue("returnReadDisbursementFormResponse");
			if ((readDisbursementFormResponse != null)
					&& (readDisbursementFormResponse.length > 0)) {
				for (ReadDisbursementFormResponse detailDisbursement : readDisbursementFormResponse) {
					detailDisbursementList
							.add(loadDataEntityDetailDisbursement(detailDisbursement));
					sumDisbursementTotal = detailDisbursement.getAmount().add(
							sumDisbursementTotal);
					if (logger.isDebugEnabled()) {
						logger.logDebug("WATQ ExecuteQueryDetailPaymentForm.executeDataEvent(..) : sumTot= "
								+ sumDisbursementTotal);
					}
				}
			}
			entities.setEntityList(DetailPaymentForm.ENTITY_NAME,
					detailDisbursementList);
			setDisbursementResultEntity(entities, sumDisbursementTotal);
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ ExecuteQueryDetailPaymentForm.executeDataEvent(..) : entities= "
						+ entities.getData());
			}
		} else {
			GeneralFunction.handleResponse(args, response, null);
		}
		return detailDisbursementList.getDataList();
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
			logger.logDebug("WATQ ExecuteQueryDetailPaymentForm.setDisbursementResultEntity(..) : disbursementResult.SUMTOTAL= "
					+ disbursementResult.get(DisbursementResult.SUMTOTAL));
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

	private DataEntity getLoanEntity(DynamicRequest entities,
			ICommonEventArgs eventArgs) {
		DataEntity loanSession = null;
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

		if (loanInstance != null) {
			if (loanInstance.get(LoanInstancia.IDINSTANCIA) != null) {
				loanSession = (DataEntity) AssetsSessionManager
						.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
			}

		} else {
			IExecuteQueryEventArgs executeQueryEvents = (IExecuteQueryEventArgs) eventArgs;
			Map<String, Object> customParameters = executeQueryEvents
					.getParameters().getCustomParameters();
			Map<String, Object> parameters = (Map<String, Object>) customParameters
					.get("parameters");
			Map<String, Object> maploanInstance = (Map<String, Object>) parameters
					.get("loanInstancia");
			if (maploanInstance != null) {
				loanSession = (DataEntity) AssetsSessionManager
						.getLoan((String) maploanInstance.get("idInstancia"));
			}
		}

		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		return loan;
	}
}
