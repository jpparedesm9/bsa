package com.cobiscorp.cobis.assets.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.common.BaseEvent;

public class ValidationForm extends BaseEvent{

	public ValidationForm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(AmortizationTable.class);

	public static String validationOpcionMenu(DataEntity loan,
			DataEntity loanInstancia) {
		try {

			String message = Parameter.EMPTY_VALUE;

			if ("3".equals(loanInstancia.get(LoanInstancia.IDOPTIONMENU))) {
				if ("A130COPPRI".equals(loan.get(Loan.DESOPERATIONTYPE))) {
					message = "ASSTS.MSG_ASSTS_VALIDACIO_12345";

					loanInstancia.set(LoanInstancia.ERRORVALIDATION, true);

				} else {
					loanInstancia.set(LoanInstancia.ERRORVALIDATION, false);
				}
			}

			return message;

		} catch (Exception e) {
			logger.logError(e);
			return "";
		}

	}

}
