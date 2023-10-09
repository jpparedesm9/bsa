package com.cobiscorp.cobis.assts.customevents.events;

import java.util.Date;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanAdditionalInformation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ApplyLiquidationLoan extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory
			.getLogger(ApplyLiquidationLoan.class);

	public ApplyLiquidationLoan(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		ServiceResponse response = null;
		try {
			ServiceRequestTO request = new ServiceRequestTO();
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity loanAddInf = entities
					.getEntity(LoanAdditionalInformation.ENTITY_NAME);
			String bankId = loan.get(Loan.LOANBANKID);
			Date liqDate = loanAddInf
					.get(LoanAdditionalInformation.DATETODISBURSE);
			Character renovation = (Character) Parameter.PARAMETER_DISBURSEMENT;
			if (loanAddInf != null
					&& loanAddInf.get(LoanAdditionalInformation.RENOVATION) != null) {
				renovation = loanAddInf
						.get(LoanAdditionalInformation.RENOVATION);
			}
			if ((bankId != null) && (liqDate != null) && (renovation != null)) {
				LoanRequest loanRequest = new LoanRequest();
				loanRequest.setPrepaymentRate(Parameter.NUM_REGISTRO);
				loanRequest.setRow(Parameter.NUM_REG_TR_MON.intValue());
				loanRequest.setShellbank(bankId);
				loanRequest.setBank(bankId);
				loanRequest.setLiquidationDate(GeneralFunction
						.convertDateToCalendar(liqDate));
				loanRequest.setRenovation(renovation);

				request.addValue("inLoanRequest", loanRequest);

				response = execute(getServiceIntegration(), logger,
						Parameter.APPLY_LIQUIDATION_LOAN, request);
				if ((response != null) && (response.isResult())) {
					if(logger.isDebugEnabled()){
						logger.logInfo("WATQ ApplyLiquidationLoan.executeCommand(..) :: response.isResult()="
								+ response.isResult());
					}
					
					ServiceResponseTO responseTo = (ServiceResponseTO) response
							.getData();
					Map<String, String> outBankIdResponse = (Map<String, String>) responseTo
							.getValue("com.cobiscorp.cobis.cts.service.response.output");					

					if (outBankIdResponse.get("@o_banco_generado") != null) {
						loan.set(Loan.LOANBANKID,
								outBankIdResponse.get("@o_banco_generado"));						
						entities.setEntity(Loan.ENTITY_NAME, loan);
						GeneralFunction.handleResponse(args, response, null);
					} else {
						GeneralFunction.handleResponse(args, response, "ASSTS.MSG_ASSTS_ERRORALNN_94337");
					}
				}else {
					GeneralFunction.handleResponse(args, response, null);
				}

			}
		} catch (Exception e) {
			logger.logDebug("ApplyLiquidationLoan.executeCommand(..) -> Exception = "
					+ e);
		}

	}
}
