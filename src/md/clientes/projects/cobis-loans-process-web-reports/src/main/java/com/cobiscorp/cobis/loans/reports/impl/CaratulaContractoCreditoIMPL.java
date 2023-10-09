package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;

public class CaratulaContractoCreditoIMPL {
	private static final ILogger logger = LogFactory.getLogger(CaratulaContractoCreditoIMPL.class);

	public static List<CreditPaymentsDTO> getCreditPaymentsList(LoanInfResponse[] loanInfResponseList) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("CaratulaContractoCreditoIMPL.getCreditPaymentsList - INI ");
		}
		if (loanInfResponseList != null) {
			logger.logDebug("loanInfResponseList - length:" + loanInfResponseList.length);
			List<CreditPaymentsDTO> returnList = new ArrayList<CreditPaymentsDTO>();
			for (int i = 0; i < loanInfResponseList.length; i++) {
				CreditPaymentsDTO payment = new CreditPaymentsDTO();
				payment.setNumberSeq(loanInfResponseList[i].getNumberSeq());
				payment.setAmount(Functions.getStringCurrencyFormated(loanInfResponseList[i].getMaxAmount()));
				payment.setDueDate(Functions.convertCalendarToString(loanInfResponseList[i].getDueDate(), ConstantValue.valueConstant.DF_DDMMYYYY));
				if (logger.isDebugEnabled()) {
					logger.logDebug("CaratulaContractoCreditoIMPL.getCreditPaymentsList - FOR INI ");
					logger.logDebug("loanInfResponseList - NumberSeq: " + payment.getNumberSeq());
				}
				returnList.add(payment);
			}
			return returnList;
		}
		return null;
	}

}
