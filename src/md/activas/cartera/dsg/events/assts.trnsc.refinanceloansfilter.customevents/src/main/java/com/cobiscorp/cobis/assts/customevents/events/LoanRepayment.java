package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.LoanRepaymentRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.RefinanceLoanFilter;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanRepayment extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory
			.getLogger(OperationTypeCatalog.class);

	public LoanRepayment(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		int contador = 0;
		BigDecimal totalToRefinance = new BigDecimal(0);
		DataEntity refinanceLoanFilter = entities
				.getEntity("RefinanceLoanFilter");
		DataEntityList refinanceLoanList = entities
				.getEntityList("RefinanceLoans");
		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		LoanRepaymentRequest loanRepaymentRequest = new LoanRepaymentRequest();
		String trama = "";
		for (DataEntity r : refinanceLoanList) {
			totalToRefinance = totalToRefinance.add((BigDecimal) r
					.get(RefinanceLoans.CAPITALBALANCE));
			totalToRefinance = totalToRefinance.add((BigDecimal) r
					.get(RefinanceLoans.INTERESTBALANCE));
			totalToRefinance = totalToRefinance.add((BigDecimal) r
					.get(RefinanceLoans.DEFAULTBALANCE));
			totalToRefinance = totalToRefinance.add((BigDecimal) r
					.get(RefinanceLoans.OTHERCONCEPTSBALANCE));
			if (contador == 30) {
				if (loanRepaymentRequest.getOperationA() == null) {
					loanRepaymentRequest.setOperationA(trama);
				} else if (loanRepaymentRequest.getOperationB() == null) {
					loanRepaymentRequest.setOperationB(trama);
				} else if (loanRepaymentRequest.getOperationC() == null) {
					loanRepaymentRequest.setOperationC(trama);
				} else if (loanRepaymentRequest.getOperationD() == null) {
					loanRepaymentRequest.setOperationC(trama);
				}
				trama = "";
				contador = 0;
			}
			logger.logInfo(">>>>>>OPERACIONES" + trama);
			trama = trama + (String) r.get(RefinanceLoans.LOAN) + ",";
			contador++;
		}
		logger.logInfo(">>>>>>OPERACIONES2" + trama);
		if (contador > 0) {
			logger.logInfo(">>>>>>OPERACIONES3" + trama);
			logger.logInfo(">>>>>>OPERACIONA"
					+ loanRepaymentRequest.getOperationA());
			if (loanRepaymentRequest.getOperationA() == null) {
				loanRepaymentRequest.setOperationA(trama);
			} else if (loanRepaymentRequest.getOperationB() == null) {
				loanRepaymentRequest.setOperationB(trama);
			} else if (loanRepaymentRequest.getOperationC() == null) {
				loanRepaymentRequest.setOperationC(trama);
			} else if (loanRepaymentRequest.getOperationD() == null) {
				loanRepaymentRequest.setOperationC(trama);
			}
		}
		loanRepaymentRequest.setOperation('I');
		if (refinanceLoanFilter.get(RefinanceLoanFilter.CLIENTID) != null) {
			loanRepaymentRequest.setEnte(((Integer) refinanceLoanFilter
					.get(RefinanceLoanFilter.CLIENTID)).intValue());
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.OPERATIONTYPE) != null) {
			loanRepaymentRequest.setToperation((String) refinanceLoanFilter
					.get(RefinanceLoanFilter.OPERATIONTYPE));
		}
		totalToRefinance = totalToRefinance
				.add((BigDecimal) refinanceLoanFilter
						.get(RefinanceLoanFilter.ADDITIONALVALUE));

		logger.logInfo(">>>>>>totalToRefinance"
				+ totalToRefinance.setScale(2, 4));
		if (totalToRefinance != null) {
			loanRepaymentRequest.setRenewBalance(totalToRefinance
					.setScale(2, 4));
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.NEWLOANTERM) != null) {
			loanRepaymentRequest.setTerm(((Integer) refinanceLoanFilter
					.get(RefinanceLoanFilter.NEWLOANTERM)).intValue());
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.PERIODICITY) != null) {
			loanRepaymentRequest.setTypeTerm((String) refinanceLoanFilter
					.get(RefinanceLoanFilter.PERIODICITY));
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.CURRENCYTYPE) != null) {
			loanRepaymentRequest.setTypeMoney(((Integer) refinanceLoanFilter
					.get(RefinanceLoanFilter.CURRENCYTYPE)).intValue());
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.ADDICIONALPAYMETHOD) != null) {
			loanRepaymentRequest.setTypePayment((String) refinanceLoanFilter
					.get(RefinanceLoanFilter.ADDICIONALPAYMETHOD));
		}
		if (refinanceLoanFilter.get(RefinanceLoanFilter.ACCOUNT) != null) {
			loanRepaymentRequest.setSavingsAccount((String) refinanceLoanFilter
					.get(RefinanceLoanFilter.ACCOUNT));
		}
		serviceRequest.addValue("inLoanRepaymentRequest", loanRepaymentRequest);
		ServiceResponse response = execute(logger, Parameter.LOANREPAYMENT,
				serviceRequest);
		if (response.isResult()) {
			logger.logInfo(">>>>>>TERMINO BIEN1");
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			if (resultado.isSuccess()) {
				logger.logInfo(">>>>>>TERMINO BIEN2" + resultado.getData());
				Object numeroOperacion = (Map) resultado
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (((Map) numeroOperacion).get("@o_banco_generado") != null) {
					logger.logInfo(">>>>>>OPERACION"
							+ (String) ((Map) numeroOperacion)
									.get("@o_banco_generado"));
					refinanceLoanFilter.set(RefinanceLoanFilter.OPERATION,
							(String) ((Map) numeroOperacion)
									.get("@o_banco_generado"));
				} else {
					logger.logInfo(">>>>>>NO HAY OPERACION");
				}
			} else {
				args.setSuccess(false);
			}
		} else {
			args.setSuccess(false);
			String mensaje = GeneralFunction.getMessageError(
					response.getMessages(), null);
			args.getMessageManager().showErrorMsg(mensaje);
		}
	}
}
