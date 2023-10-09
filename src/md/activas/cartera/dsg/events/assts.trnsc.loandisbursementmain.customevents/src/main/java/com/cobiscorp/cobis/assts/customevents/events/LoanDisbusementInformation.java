package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.DetailLoanResponseList;
import cobiscorp.ecobis.assets.cloud.dto.HeaderLoanResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadGlobalVariablesResponse;
import cobiscorp.ecobis.assets.cloud.dto.TrnDetailRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.customevents.commons.UtilDisbursement;
import com.cobiscorp.cobis.assts.model.DetailAmountsToCancel;
import com.cobiscorp.cobis.assts.model.LiquidateResult;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanAdditionalInformation;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanDisbusementInformation extends BaseEvent implements
		IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoanDisbusementInformation.class);

	public LoanDisbusementInformation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities,
			IDataEventArgs eventArgs) {
		showLoanHeaderInfo(entities, eventArgs);
		showLoanDisbursementInformation(entities, eventArgs);
	}

	private ServiceResponse showLoanDisbursementInformation(
			DynamicRequest entities, IDataEventArgs eventArgs) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		String bankId = (String) loan.get(Loan.LOANBANKID);
		Integer loanStatus = loan.get(Loan.STATUSID);
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

		if (loanStatus == 0) {

			ReadDisbursementFormRequest readDisbursementFormRequest = new ReadDisbursementFormRequest();
			readDisbursementFormRequest.setBankReal(bankId);
			readDisbursementFormRequest.setFictitiousBank(bankId);
			readDisbursementFormRequest.setFormatDate(Integer
					.valueOf(Parameter.CODEDATEFORMAT));
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
				logger.logDebug("Error: " + e);
			}
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ LoanDisbusementInformation.showLoanDisbursementInformation(..) :: Ejecutado execute(getServiceIntegration()");
			}
			if ((response != null) && (response.isResult())) {
				ServiceResponseTO responseTo = (ServiceResponseTO) response
						.getData();
				loadDataDetailLoanResponseList(responseTo, entities);
				loadDataHeaderLoanResponse(responseTo, entities);

				UtilDisbursement utilDist = new UtilDisbursement(
						this.getServiceIntegration());
				utilDist.loadDataGridDetailDisbursement(responseTo, entities);

			} else {
				GeneralFunction.handleResponse(eventArgs, response, null);
			}
		} else {
			loanInstance.set(LoanInstancia.ERRORVALIDATION, true);
			entities.setEntity(LoanInstancia.ENTITY_NAME, loanInstance);
		}
		return response;
	}

	public void loadDataHeaderLoanResponse(ServiceResponseTO responseTo,
			DynamicRequest entities) {
		HeaderLoanResponse[] returnHeaderLoanResponseList = (HeaderLoanResponse[]) responseTo
				.getValue("returnHeaderLoanResponse");
		if ((returnHeaderLoanResponseList != null)
				&& (returnHeaderLoanResponseList.length > 0)) {
			for (HeaderLoanResponse detailLoanResponseList : returnHeaderLoanResponseList) {
				entities.setEntity(
						LoanAdditionalInformation.ENTITY_NAME,
						getQuotationLoanToLoanAdditionalInformation(detailLoanResponseList));

				DataEntity itemLiquidateResult = new DataEntity();
				if (detailLoanResponseList!= null && detailLoanResponseList.getValueDisburse() != null) {
					itemLiquidateResult.set(LiquidateResult.SUMTOTAL,
							BigDecimal.valueOf(detailLoanResponseList
									.getValueDisburse()));
				}
				entities.setEntity(LiquidateResult.ENTITY_NAME,
						itemLiquidateResult);

			}
		}
	}

	private DataEntity getQuotationLoanToLoanAdditionalInformation(
			HeaderLoanResponse detailLoanResponseList) {
		DataEntity itemHeaderLoanEntity = new DataEntity();
		ServiceRequestTO request = new ServiceRequestTO();
		TrnDetailRequest trnDetailRequest = new TrnDetailRequest();
		trnDetailRequest.setDateValue(GeneralFunction
				.convertDateToCalendar(GeneralFunction.convertStringToDate(
						ServerParamUtil.getProcessDate(),
						Parameter.TYPEDATEFORMAT.MMDDYYYY)));
		request.addValue("inTrnDetailRequest", trnDetailRequest);

		ServiceResponse response = execute(getServiceIntegration(), logger,
				Parameter.READ_GLOBAL_VARIABLES, request);
		if ((response != null) && (response.isResult())) {
			ServiceResponseTO responseTo = (ServiceResponseTO) response
					.getData();

			ReadGlobalVariablesResponse[] returnReadGlobalVariablesResponse = (ReadGlobalVariablesResponse[]) responseTo
					.getValue("returnReadGlobalVariablesResponse");
			if ((returnReadGlobalVariablesResponse != null)
					&& (returnReadGlobalVariablesResponse.length > 0)) {
				for (ReadGlobalVariablesResponse readGlobalVariablesResponse : returnReadGlobalVariablesResponse) {
					
					if ((detailLoanResponseList != null)
							&& (detailLoanResponseList.getCurrency() != null)
							&& (detailLoanResponseList.getCurrency().intValue() == readGlobalVariablesResponse
									.getCurrency())) {
						itemHeaderLoanEntity.set(
								LoanAdditionalInformation.QUOTATION, BigDecimal
										.valueOf(readGlobalVariablesResponse
												.getAmount()));
						itemHeaderLoanEntity.set(
								LoanAdditionalInformation.DATETODISBURSE,
								GeneralFunction.convertStringToDate(
										ServerParamUtil.getProcessDate(),
										Parameter.TYPEDATEFORMAT.MMDDYYYY));
						itemHeaderLoanEntity.set(
								LoanAdditionalInformation.AMOUNTOPERATION,
								BigDecimal.valueOf(detailLoanResponseList
										.getAmountOpt().doubleValue()));
						itemHeaderLoanEntity.set(
								LoanAdditionalInformation.AMOUNTTOCANCEL,
								BigDecimal.valueOf(readGlobalVariablesResponse
										.getAmount()
										* detailLoanResponseList.getAmountOpt()
												.doubleValue()));
						itemHeaderLoanEntity
								.set(LoanAdditionalInformation.LBLAMOUNTTOCANCEL,
										"");
					}
				}
			}
		}
		return itemHeaderLoanEntity;
	}

	private void loadDataDetailLoanResponseList(ServiceResponseTO responseTo,
			DynamicRequest entities) {
		DataEntityList detailLoanListEntity = new DataEntityList();
		DataEntity itemDetailAmountsToCancel = null;
		DetailLoanResponseList[] returnDetailLoanResponseList = (DetailLoanResponseList[]) responseTo
				.getValue("returnDetailLoanResponseList");
		if ((returnDetailLoanResponseList != null)
				&& (returnDetailLoanResponseList.length > Parameter.ZERO_VALUE)) {
			for (DetailLoanResponseList detailLoanResponseList : returnDetailLoanResponseList) {
				itemDetailAmountsToCancel = new DataEntity();
				itemDetailAmountsToCancel.set(
						DetailAmountsToCancel.DESCRIPTION,
						detailLoanResponseList.getDescription());
				itemDetailAmountsToCancel.set(DetailAmountsToCancel.ITEM,
						detailLoanResponseList.getConcept());
				itemDetailAmountsToCancel.set(DetailAmountsToCancel.VALUE,
						detailLoanResponseList.getAmount());
				detailLoanListEntity.add(itemDetailAmountsToCancel);
			}
			entities.setEntityList(DetailAmountsToCancel.ENTITY_NAME,
					detailLoanListEntity);
		}
	}

	private void showLoanHeaderInfo(DynamicRequest entities,
			IDataEventArgs eventArgs) {
		DataEntity loanSession = null;
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		if (loanInstance != null) {
			if (loanInstance.get(LoanInstancia.IDINSTANCIA) != null) {
				loanSession = (DataEntity) AssetsSessionManager
						.getLoan((String) loanInstance
								.get(LoanInstancia.IDINSTANCIA));
			}
		} else {
			IExecuteQueryEventArgs executeQueryEvents = (IExecuteQueryEventArgs) eventArgs;
			Map<String, Object> customParameters = executeQueryEvents
					.getParameters().getCustomParameters();
			Map<String, Object> parameters = (Map) customParameters
					.get("parameters");
			Map<String, Object> maploanInstance = (Map) parameters
					.get("loanInstancia");
			if (maploanInstance != null) {
				loanSession = (DataEntity) AssetsSessionManager
						.getLoan((String) maploanInstance.get("idInstancia"));
			}
		}
		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}
	}
}
