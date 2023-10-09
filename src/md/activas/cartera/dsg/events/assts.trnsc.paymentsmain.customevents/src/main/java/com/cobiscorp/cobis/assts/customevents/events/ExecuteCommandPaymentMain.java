package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.Calendar;

import cobiscorp.ecobis.assets.cloud.dto.CreditDetailRequest;
import cobiscorp.ecobis.assets.cloud.dto.GroupTransactResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanPayEntryRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.CondonationDetail;
import com.cobiscorp.cobis.assts.model.LeftOverPayment;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.Negotiation;
import com.cobiscorp.cobis.assts.model.Payment;
import com.cobiscorp.cobis.assts.model.Priorities;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteCommandPaymentMain extends BaseEvent implements
		IExecuteCommand {

	private char dataTransSuccess;
	private static final ILogger logger = LogFactory
			.getLogger(ExecuteCommandPaymentMain.class);

	public ExecuteCommandPaymentMain(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		
		String paymentType = "I";
		
		Object[] parameters = new Object[18];
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		DataEntity loanInstancia = entities.getEntity(LoanInstancia.ENTITY_NAME);
		
		payment.set(Payment.UNAPPLIEDPAYMENTS, null);
		payment.set(Payment.UNAPPLIEDAMOUNT, BigDecimal.valueOf(0));
		
		if (loanInstancia.get(LoanInstancia.TIPO) != null) 
			paymentType = loanInstancia.get(LoanInstancia.TIPO);

		if ("I".equals(paymentType)) {
			BigDecimal amountMn = payment.get(Payment.VALUE).multiply(payment.get(Payment.PAYQUOTATIONVALUE));
			BigDecimal value = payment.get(Payment.VALUE);
			parameters[1] = "I";
			parameters[2] = "S";
			parameters[6] = payment.get(Payment.CURRENCYTYPE);
			parameters[12] =  payment.get(Payment.QUOTATIONVALUE);
			parameters[14] = "COT";
			if (Double.valueOf(String.valueOf(value)) > 0) {
				parameters[3] = "PAG";
				parameters[4] = payment.get(Payment.PAYMENTTYPE);
				parameters[5] = payment.get(Payment.REFERENCE);
				parameters[7] = payment.get(Payment.NOTE);
				parameters[8] = payment.get(Payment.VALUE);
				parameters[11] =  payment.get(Payment.PAYQUOTATIONVALUE);
				parameters[13] = "COT"; 
				parameters[10] = amountMn;
				parameters[9] = amountMn.divide(payment.get(Payment.QUOTATIONVALUE));
				parameters[15] = 0; 
				parameters[16] = 0; 
				parameters[17] = 0.00;
				dataTrans(parameters);
				parameters[2] = "N";
			}
			
			DataEntityList condonationDetail = entities.getEntityList(CondonationDetail.ENTITY_NAME);
			if (!condonationDetail.isEmpty()) {
				parameters[3] = "CON";
				parameters[5] = "";
				for (DataEntity c : condonationDetail) {
					BigDecimal valueToCondone2 = c.get(CondonationDetail.VALUETOCONDONE).multiply(payment.get(Payment.PAYQUOTATIONVALUE));
					
					parameters[4] = c.get(CondonationDetail.CONCEPT);
					parameters[7] = c.get(CondonationDetail.OBSERVATION);
					parameters[8] = c.get(CondonationDetail.VALUETOCONDONE);
					parameters[9] = valueToCondone2.divide(payment.get(Payment.QUOTATIONVALUE));
					parameters[10] = valueToCondone2;
					parameters[11] = payment.get(Payment.PAYQUOTATIONVALUE);
					parameters[11] = parameters[11] == null ? new BigDecimal(0) : parameters[11];  
					parameters[13] = parameters[14];
					double percentage  = c.get(CondonationDetail.PERCENTAGE).doubleValue();
					parameters[15] = 0; 
					parameters[16] = 0; 
					parameters[17] = percentage;
					
					dataTrans(parameters);
					parameters[2] = "N";
				}
			}
			
			DataEntity leftOverPayment = entities.getEntity(LeftOverPayment.ENTITY_NAME);
			value = leftOverPayment.get(LeftOverPayment.VALUE);
			amountMn = leftOverPayment.get(LeftOverPayment.VALUE).multiply(leftOverPayment.get(LeftOverPayment.LEFTOVERQUOTATIONVALUE));
			 
			if (Double.valueOf(String.valueOf(value)) > 0 && String.valueOf(leftOverPayment.get(LeftOverPayment.CURRENCYTYPE)) != "" && String.valueOf(leftOverPayment.get(LeftOverPayment.PAYMENTTYPE)) != "") {
				parameters[3] = "SOB";
				parameters[4] = leftOverPayment.get(LeftOverPayment.PAYMENTTYPE);
				parameters[5] = leftOverPayment.get(LeftOverPayment.REFERENCE);
				parameters[6] = leftOverPayment.get(LeftOverPayment.CURRENCYTYPE);
				parameters[7] = leftOverPayment.get(LeftOverPayment.NOTE);
				parameters[8] = leftOverPayment.get(LeftOverPayment.VALUE);
				parameters[11] = leftOverPayment.get(LeftOverPayment.LEFTOVERQUOTATIONVALUE);
				parameters[13] = "COT";
				parameters[10] = amountMn;
				parameters[9] = amountMn.divide(payment.get(Payment.PAYQUOTATIONVALUE));
				parameters[15] = 0; 
				parameters[16] = 0; 
				parameters[17] = 0.0;
				dataTrans(parameters);
			 }
			
			if (dataTransSuccess == 'S') {
				generatePayment(entities, iExecuteCommandEventArgs);
			}
		}
		
		logger.logDebug("paymentType       --> " + paymentType);
		logger.logDebug("CONTINUEPAYMENT   --> " + payment.get(Payment.CONTINUEPAYMENT));
		logger.logDebug("UNAPPLIEDPAYMENTS --> " + payment.get(Payment.UNAPPLIEDPAYMENTS));
		logger.logDebug("UNAPPLIEDAMOUNT   --> " + payment.get(Payment.UNAPPLIEDAMOUNT));
		
		
		if ("G".equals(paymentType)) {
			
			//Check if there are any unapplied group payments
			if (payment.get(Payment.CONTINUEPAYMENT) == null) {
				checkUnapliedPayments(entities, iExecuteCommandEventArgs);
				if (payment.get(Payment.UNAPPLIEDPAYMENTS) == null || payment.get(Payment.UNAPPLIEDPAYMENTS) > 0) {
					payment.set(Payment.CONTINUEPAYMENT, "N");
				} else {
					payment.set(Payment.CONTINUEPAYMENT, "S");
				}
			}
			
			logger.logDebug("CONTINUEPAYMENT   --> " + payment.get(Payment.CONTINUEPAYMENT));
			logger.logDebug("UNAPPLIEDPAYMENTS --> " + payment.get(Payment.UNAPPLIEDPAYMENTS));
			logger.logDebug("UNAPPLIEDAMOUNT   --> " + payment.get(Payment.UNAPPLIEDAMOUNT));
			
			if ("S".equals(payment.get(Payment.CONTINUEPAYMENT))) {
				generateGroupPaymentOrder(entities, iExecuteCommandEventArgs);
			}
			
		}
		
	}

	public void dataTrans(Object[] parameters) {

		CreditDetailRequest creditDetailRequest = new CreditDetailRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;

		creditDetailRequest.setAccion((String) parameters[1]);
		creditDetailRequest.setEncerar((String) parameters[2]);
		creditDetailRequest.setType((String) parameters[3]);
		creditDetailRequest.setConcept((String) parameters[4]);
		creditDetailRequest.setAccount((String) parameters[5]);
		creditDetailRequest.setCurrency((Integer) parameters[6]);
		creditDetailRequest.setAmounMpg((BigDecimal) parameters[8]);
		if ("CON".equals(parameters[3])) {
			creditDetailRequest.setAmounMop((BigDecimal) parameters[8]);
		} else {
			creditDetailRequest.setAmounMop((BigDecimal) parameters[9]);
		}
		creditDetailRequest.setAmounMn((BigDecimal) parameters[10]);
		creditDetailRequest.setPriceMpg((BigDecimal) parameters[11]);
		creditDetailRequest.setPriceMop((BigDecimal) parameters[12]);
		creditDetailRequest.setTpriceMpg((String) parameters[13]);
		creditDetailRequest.setTpriceMop((String) parameters[14]);
		creditDetailRequest.setInscription((Integer) parameters[15]);
		creditDetailRequest.setLoad((Integer) parameters[16]);
		creditDetailRequest.setBank((String) parameters[5]);
		creditDetailRequest.setPercent((Double) parameters[17]);
		creditDetailRequest.setBeneficiary((String) parameters[7]); 

		serviceRequestTO.addValue("inCreditDetailRequest", creditDetailRequest);
		serviceResponse = this.execute(logger, Parameter.PROCESS_CREDITDETAIL, serviceRequestTO);
		if (serviceResponse.isResult()) {
			dataTransSuccess = 'S';
		} else {
			dataTransSuccess = 'N';
		}
	}

	public void generatePayment(DynamicRequest entities,
			IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al generatePayment");
		}
		LoanPayEntryRequest loanPayEntryRequest = new LoanPayEntryRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		DataEntity negotiation = entities.getEntity(Negotiation.ENTITY_NAME);
		DataEntityList priorities = entities.getEntityList(Priorities.ENTITY_NAME);

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(payment.get(Payment.DATE));
		
		String onLine = payment.get(Payment.ONLINE) ? "S" : "N";
		String fullFee = negotiation.get(Negotiation.FULLFEE) ? "S" : "N";
		String additionalPayment = negotiation.get(Negotiation.ADDITIONALPAYMENTS) ? "S" : "N";
		String numCheck = payment.get(Payment.NUMCHECK) == null ? "0" : payment.get(Payment.NUMCHECK);

		loanPayEntryRequest.setAction("I");
		loanPayEntryRequest.setLoanBankID(loan.get(Loan.LOANBANKID).trim());
		loanPayEntryRequest.setType("PAG");
		loanPayEntryRequest.setEffectiveDate(calendar);
		loanPayEntryRequest.setExecute(onLine);
		loanPayEntryRequest.setRetention(payment.get(Payment.RETENTION));
		loanPayEntryRequest.setFullFee(fullFee);
		loanPayEntryRequest.setCalculateReturn(negotiation.get(Negotiation.CALCULATERETURN));
		loanPayEntryRequest.setAnticipated(additionalPayment);
		loanPayEntryRequest.setReductionType(negotiation.get(Negotiation.REDUCTIONTYPE));
		loanPayEntryRequest.setProjected(negotiation.get(Negotiation.INTERESTTYPE));
		loanPayEntryRequest.setApplicationType(negotiation.get(Negotiation.PAYMENTTYPE));
		loanPayEntryRequest.setCapitalOnly("N");
		loanPayEntryRequest.setCancel("N");
		
		String prioritiesString = "";
		for (DataEntity p : priorities) {
			prioritiesString = prioritiesString + p.get(Priorities.PRIORITY) + ";";
		}
		prioritiesString = prioritiesString.substring(0, prioritiesString.length() - 1) + "#";
		loanPayEntryRequest.setPriorities(prioritiesString);
		
		loanPayEntryRequest.setPrepaidRate(BigDecimal.valueOf(payment.get(Payment.PREPAYRATE)));  //29.6268
		
		if ("S".equals(loan.get(Loan.NEWSTATUS))){
			if (logger.isDebugEnabled()) {
				logger.logDebug("El valor de la multa parametro: " + payment.get(Payment.FINEPREPAYMENT));
			}
			loanPayEntryRequest.setPrepaymentFine(payment.get(Payment.FINEPREPAYMENT));  //202.00
		}
		
		loanPayEntryRequest.setSequentialEntry(0);
		loanPayEntryRequest.setVerifyRates("S");
		loanPayEntryRequest.setBeneficiary("");
		
		Integer checkNumber = new Integer(numCheck);
		loanPayEntryRequest.setCheckNumber(checkNumber);
		loanPayEntryRequest.setBankID(payment.get(Payment.BANK));
		
		serviceRequestTO.addValue("inLoanPayEntryRequest", loanPayEntryRequest);
		serviceResponse = this.execute(logger, Parameter.PROCESS_PAYMENTENTRY, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				String mensaje = "Pago realizado correctamente";
				iExecuteCommandEventArgs.getMessageManager().showInfoMsg(mensaje);
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(mensaje);
		}
	}
	
	private void generateGroupPaymentOrder (DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al generateGroupPaymentOrder");
		}
		
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		BigDecimal amountMn = payment.get(Payment.VALUE).multiply(payment.get(Payment.PAYQUOTATIONVALUE));
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(payment.get(Payment.DATE));
		
		CreditDetailRequest creditDetailRequest = new CreditDetailRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;

		creditDetailRequest.setAccion("G");
		creditDetailRequest.setEncerar("S");
		creditDetailRequest.setType("PAG");
		creditDetailRequest.setConcept(payment.get(Payment.PAYMENTTYPE));
		creditDetailRequest.setAccount(payment.get(Payment.REFERENCE));
		creditDetailRequest.setCurrency(payment.get(Payment.CURRENCYTYPE));
		creditDetailRequest.setAmounMpg(payment.get(Payment.VALUE));
		creditDetailRequest.setAmounMop(amountMn.divide(payment.get(Payment.QUOTATIONVALUE)));
		
		creditDetailRequest.setAmounMn(amountMn);
		creditDetailRequest.setPriceMpg(payment.get(Payment.PAYQUOTATIONVALUE));
		creditDetailRequest.setPriceMop(payment.get(Payment.QUOTATIONVALUE));
		creditDetailRequest.setTpriceMpg("COT");
		creditDetailRequest.setTpriceMop("COT");
		creditDetailRequest.setInscription(0);
		creditDetailRequest.setLoad(0);
		creditDetailRequest.setBank(loan.get(Loan.LOANBANKID).trim());
		creditDetailRequest.setPercent(0);
		creditDetailRequest.setBeneficiary(payment.get(Payment.NOTE)); 
		creditDetailRequest.setEffectiveDate(calendar);
		
		payment.set(Payment.CONTINUEPAYMENT, null);

		serviceRequestTO.addValue("inCreditDetailRequest", creditDetailRequest);
		serviceResponse = this.execute(logger, Parameter.PROCESS_CREDITDETAIL, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				String mensaje = "Orden de Pago Grupal registrado correctamente";
				args.getMessageManager().showInfoMsg(mensaje);
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
			args.getMessageManager().showErrorMsg(mensaje);
		}
		
	}
	
	private void checkUnapliedPayments(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al checkUnapliedPayments");
		}
		
		LoanPayEntryRequest loanPayEntryRequest = new LoanPayEntryRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		
		loanPayEntryRequest.setAction("G");
		loanPayEntryRequest.setLoanBankID(loan.get(Loan.LOANBANKID).trim());
		
		serviceRequestTO.addValue("inLoanPayEntryRequest", loanPayEntryRequest);
		serviceResponse = this.execute(logger, "Loan.ProductListCredit.QueryPendingPayment", serviceRequestTO);
		if (serviceResponse.isResult()) {			
			ServiceResponseTO resultado = (ServiceResponseTO) serviceResponse.getData();
			GroupTransactResponse[] clResponse = (GroupTransactResponse[]) resultado.getValue("returnGroupTransactResponse");
			
			for (GroupTransactResponse result : clResponse) {
				payment.set(Payment.UNAPPLIEDPAYMENTS, result.getTransactionNumber());
				payment.set(Payment.UNAPPLIEDAMOUNT, result.getLoanBalance());
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
			args.getMessageManager().showErrorMsg(mensaje);
		}
	}

}
