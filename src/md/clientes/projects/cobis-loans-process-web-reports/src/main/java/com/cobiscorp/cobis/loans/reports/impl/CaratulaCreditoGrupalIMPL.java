package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;

public class CaratulaCreditoGrupalIMPL {
	private static final ILogger logger = LogFactory.getLogger(CaratulaCreditoGrupalIMPL.class);

	public static List<CreditPaymentsDTO> getPaymentsList(GroupLoanInfResponse[] groupLoanInfResponseList) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("CaratulaCreditoGrupalIMPL.getPaymentsList - INI ");
			logger.logDebug("groupLoanInfResponseList: " + groupLoanInfResponseList);
		}
		if (groupLoanInfResponseList != null) {
			List<CreditPaymentsDTO> returnList = new ArrayList<CreditPaymentsDTO>();
			for (int i = 0; i < groupLoanInfResponseList.length; i++) {
				CreditPaymentsDTO payment = new CreditPaymentsDTO();
				payment.setNumberSeq(groupLoanInfResponseList[i].getNumberSeq());
				payment.setAmount(Functions.getStringCurrencyFormated(groupLoanInfResponseList[i].getMaxAmount()));
				payment.setDueDate(Functions.convertCalendarToString(groupLoanInfResponseList[i].getDueDate(), ConstantValue.valueConstant.DF_DDMMYYYY));
				if (logger.isDebugEnabled()) {
					logger.logDebug("CaratulaCreditoGrupalIMPL.getPaymentsList - FOR INI ");
					logger.logDebug("groupLoanInfResponseList - LoanInfResponse:" + groupLoanInfResponseList[i].getNumberSeq());
				}
				returnList.add(payment);
			}
			return returnList;
		}
		return null;
	}

}
