package com.cobiscorp.cobis.assets.commons.events;

import java.text.SimpleDateFormat;

import cobiscorp.ecobis.assets.cloud.dto.LoanHeaderInfoRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanHeaderInfoResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowSelecting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanLoadSelect extends BaseEvent implements IGridRowSelecting {

	private static final ILogger logger = LogFactory
			.getLogger(LoanLoadSelect.class);

	public LoanLoadSelect(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private String screenCall;

	public LoanLoadSelect(ICTSServiceIntegration serviceIntegration,
			String screenCall) {
		super(serviceIntegration);
		this.screenCall = screenCall;
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {

		try {
			String loanselect = "";
			if (screenCall != null && screenCall.equals(Parameter.REFINANCE)) {
				loanselect = row.get(RefinanceLoans.LOAN);
			} else {
				loanselect = row.get(Loan.LOANBANKID);
			}

			ServiceRequestTO request = new ServiceRequestTO();

			LoanHeaderInfoRequest loanHeaderInfoRequest = new LoanHeaderInfoRequest();

			loanHeaderInfoRequest.setDateFormat(101);
			loanHeaderInfoRequest.setLoanBankID(loanselect);

			request.addValue("inLoanHeaderInfoRequest", loanHeaderInfoRequest);
			ServiceResponse response = execute(getServiceIntegration(), logger,
					"Loan.LoansQueries.ReadLoanHeaderInfo", request);

			GeneralFunction.handleResponse(args, response, null);
			DataEntity loan = row;

			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingreso executeDataEvent>>>>>>>");
				logger.logDebug("entities>>>>>>>" + loan.getData());

			}

			if (response != null && response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				LoanHeaderInfoResponse[] clResponseList = (LoanHeaderInfoResponse[]) resultado
						.getValue("returnLoanHeaderInfoResponse");
				for (LoanHeaderInfoResponse clResponse : clResponseList) {
					loan.set(Loan.OPERATIONTYPEID,
							clResponse.getOperationTypeID());
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
					loan.set(Loan.IDENTITYCARDNUMBER,
							clResponse.getIdentityCard());
					loan.set(Loan.STATUSID, clResponse.getStatusID());
					loan.set(Loan.STATUS, clResponse.getStatus());

					SimpleDateFormat formatJ = new SimpleDateFormat(
							"dd/MM/yyyy");
					String startDateStr = formatJ.format(clResponse
							.getStartDate().getTime());

					loan.set(
							Loan.STARTDATE,
							clResponse.getStartDate() != null ? GeneralFunction
									.convertStringToDate(startDateStr,
											Parameter.TYPEDATEFORMAT.DDMMYYYY)
									: null);
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

			}

			DataEntity loanInstance = args.getDynamicRequest().getEntity(
					LoanInstancia.ENTITY_NAME);

			if (screenCall != null && screenCall.equals(Parameter.REFINANCE)) {
				AssetsSessionManager.saveLoanRefinance(
						loanInstance.get(LoanInstancia.IDINSTANCIA), loan);
			} else {
				AssetsSessionManager.saveLoan(
						loanInstance.get(LoanInstancia.IDINSTANCIA), loan);
			}

		} catch (Exception ex) {
			logger.logError("Error en ConsultaPrestamoGrid.rowAction", ex);

		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza Consulta Préstamo Grid");
			}
		}

	}
}
