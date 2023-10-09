package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanHeaderInfoRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanHeaderInfoResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanHeaderController extends BaseEvent {

	public LoanHeaderController(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(LoanHeaderInitDataEvent.class);

	public ServiceResponse loadLoanHeader(DataEntity loan) {
		ServiceRequestTO request = new ServiceRequestTO();
		LoanHeaderInfoRequest loanHeaderInfoRequest = new LoanHeaderInfoRequest();
		loanHeaderInfoRequest.setDateFormat(101);
		loanHeaderInfoRequest.setLoanBankID(loan.get(Loan.LOANBANKID));

		request.addValue("inLoanHeaderInfoRequest", loanHeaderInfoRequest);
		ServiceResponse response = execute(getServiceIntegration(), logger,
				"Loan.LoansQueries.ReadLoanHeaderInfo", request);

		if (response != null && response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();

			LoanHeaderInfoResponse[] clResponseList = (LoanHeaderInfoResponse[]) resultado
					.getValue("returnLoanHeaderInfoResponse");
			for (LoanHeaderInfoResponse clResponse : clResponseList) {

				loan.set(Loan.OPERATIONTYPEID, clResponse.getOperationTypeID());
				loan.set(Loan.OPERATIONTYPE, clResponse.getOperationType());
				loan.set(Loan.OFFICEID, clResponse.getOfficeID());
				loan.set(Loan.OFFICE, clResponse.getOffice());
				loan.set(Loan.LOANBANKID, clResponse.getLoanBankID());
				loan.set(Loan.LOANID, clResponse.getLoanID());
				loan.set(Loan.CURRENCYNAME, clResponse.getCurrencyName());
				loan.set(Loan.OFFICER, clResponse.getOfficer());
				loan.set(Loan.AMOUNT, clResponse.getAmount());
				loan.set(Loan.CLIENTID, clResponse.getClientID());
				loan.set(Loan.CLIENTNAME, clResponse.getClientName());
				loan.set(Loan.IDTYPE, clResponse.getIdType());
				loan.set(Loan.IDENTITYCARDNUMBER, clResponse.getIdentityCard());
				loan.set(Loan.STATUSID, clResponse.getStatusID());
				loan.set(Loan.STATUS, clResponse.getStatus());
				loan.set(Loan.STARTDATE,
						clResponse.getStartDate() != null ? clResponse
								.getStartDate().getTime() : null);
				loan.set(Loan.ENDDATE,
						clResponse.getEndDate() != null ? clResponse
								.getEndDate().getTime() : null);
				loan.set(Loan.FEEENDDATE,
						clResponse.getFeeEndDate() != null ? clResponse
								.getFeeEndDate().getTime() : null);
				loan.set(Loan.BALANCEDUE, clResponse.getBalanceDue());
				loan.set(Loan.NEXTPAYMENT, clResponse.getNextPayment());
				loan.set(Loan.EFFECTIVEANUALRATE,
						clResponse.getEffectiveAnualRate());
			}

		} else {
			logger.logDebug("*****************************************************ResponseJSI"
					+ response.getMessages().toString());
			loan.set(Loan.OPERATIONTYPEID, null);
			loan.set(Loan.OPERATIONTYPE, null);
			loan.set(Loan.OFFICEID, null);
			loan.set(Loan.OFFICE, null);
			loan.set(Loan.LOANID, null);
			loan.set(Loan.CURRENCYNAME, null);
			loan.set(Loan.OFFICER, null);
			loan.set(Loan.AMOUNT, null);
			loan.set(Loan.CLIENTID, null);
			loan.set(Loan.CLIENTNAME, null);
			loan.set(Loan.IDTYPE, null);
			loan.set(Loan.IDENTITYCARDNUMBER, null);
			loan.set(Loan.STATUSID, null);
			loan.set(Loan.STATUS, null);
			loan.set(Loan.STARTDATE, null);
			loan.set(Loan.ENDDATE, null);
			loan.set(Loan.FEEENDDATE, null);
			loan.set(Loan.BALANCEDUE, null);
			loan.set(Loan.NEXTPAYMENT, null);
			loan.set(Loan.EFFECTIVEANUALRATE, null);
			loan.set(Loan.LASTPROCESSDATE, null);
		}
		return response;

	}
}
