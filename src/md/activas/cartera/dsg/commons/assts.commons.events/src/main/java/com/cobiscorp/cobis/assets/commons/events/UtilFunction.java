package com.cobiscorp.cobis.assets.commons.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.HeaderLoanResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadGlobalVariablesResponse;
import cobiscorp.ecobis.assets.cloud.dto.TrnDetailRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.LoanAdditionalInformation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class UtilFunction extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(UtilFunction.class);

	public UtilFunction(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntity getQuotationCurrency(HeaderLoanResponse detailLoanResponseList) {
		DataEntity itemHeaderLoanEntity = new DataEntity();
		ServiceRequestTO request = new ServiceRequestTO();
		TrnDetailRequest trnDetailRequest = new TrnDetailRequest();
		trnDetailRequest
				.setDateValue(GeneralFunction.convertDateToCalendar(GeneralFunction.convertStringToDate(ServerParamUtil.getProcessDate(), Parameter.TYPEDATEFORMAT.MMDDYYYY)));
		request.addValue("inTrnDetailRequest", trnDetailRequest);

		ServiceResponse response = execute(getServiceIntegration(), logger, Parameter.READ_GLOBAL_VARIABLES, request);
		if (response != null && response.isResult()) {
			ServiceResponseTO responseTo = (ServiceResponseTO) response.getData();

			ReadGlobalVariablesResponse[] returnReadGlobalVariablesResponse = (ReadGlobalVariablesResponse[]) responseTo.getValue("returnReadGlobalVariablesResponse");

			logger.logInfo("returnReadGlobalVariablesResponse: " + returnReadGlobalVariablesResponse);

			if (returnReadGlobalVariablesResponse != null && returnReadGlobalVariablesResponse.length > 0) {
				logger.logInfo("returnReadGlobalVariablesResponse length:" + returnReadGlobalVariablesResponse.length);
				for (ReadGlobalVariablesResponse readGlobalVariablesResponse : returnReadGlobalVariablesResponse) {
					if (logger.isDebugEnabled()) {
						logger.logInfo("-->getQuotationLoan(..) :: readGlobalVariablesResponse=" + readGlobalVariablesResponse.toString());
						logger.logInfo("-->setQuotationLoanToLoanAdditionalInformation(..) :: Moneda=" + readGlobalVariablesResponse.getCurrency());
						
					}

					logger.logDebug("detailLoanResponseList" + detailLoanResponseList);
					if (detailLoanResponseList != null && detailLoanResponseList.getCurrency() != null
							&& detailLoanResponseList.getCurrency() == readGlobalVariablesResponse.getCurrency()) {
						itemHeaderLoanEntity.set(LoanAdditionalInformation.QUOTATION, BigDecimal.valueOf(readGlobalVariablesResponse.getAmount()));
						itemHeaderLoanEntity.set(LoanAdditionalInformation.DATETODISBURSE,
								GeneralFunction.convertStringToDate(ServerParamUtil.getProcessDate(), Parameter.TYPEDATEFORMAT.MMDDYYYY));
						itemHeaderLoanEntity.set(LoanAdditionalInformation.AMOUNTOPERATION, BigDecimal.valueOf(detailLoanResponseList.getAmountOpt()));
						itemHeaderLoanEntity.set(LoanAdditionalInformation.AMOUNTTOCANCEL,
								BigDecimal.valueOf(readGlobalVariablesResponse.getAmount() * detailLoanResponseList.getAmountOpt()));
						itemHeaderLoanEntity.set(LoanAdditionalInformation.LBLAMOUNTTOCANCEL, "");
					}
				}
			}
		}
		return itemHeaderLoanEntity;
	}
}
