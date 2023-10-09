package com.cobiscorp.cobis.assts.customevents.parameter;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;

public abstract class GeneralValidation {
	private static final ILogger logger = LogFactory
			.getLogger(GeneralValidation.class);

	private static final String DEBE_SELECCIONAR_OPERACION = "ASSTS.LBL_ASSTS_DEBESELNN_37143";
	private static final String DEBE_SELECCIONAR_REAJUSTE = "ASSTS.LBL_ASSTS_DEBESELCT_29478";

	private GeneralValidation() {

	}

	public static List<String> validationReadjustment(
			Parameter.TYPEEXECUTION typeExecution, DataEntity readjustment,
			DataEntity loan) {
		List<String> listMessages = new ArrayList<String>();

		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al validationReadjustment: "
					+ typeExecution.toString());
		}

		try {
			if (loan == null
					|| loan.get(Loan.LOANBANKID) == null
					|| Parameter.EMPTY_VALUE.equals(loan.get(Loan.LOANBANKID)
							.trim())) {
				GeneralFunction.setMessage(listMessages,
						DEBE_SELECCIONAR_OPERACION);
			}

			validationReadjusment(typeExecution, readjustment, listMessages);
		} catch (Exception ex) {
			GeneralFunction.setMessage(listMessages, ex.getMessage());

			logger.logError(ex);
		}

		return listMessages;
	}

	private static void validationReadjusment(
			Parameter.TYPEEXECUTION typeExecution, DataEntity readjustment,
			List<String> listMessages) {
		switch (typeExecution) {
		case UPDATE:
		case DELETE:
			validation(readjustment, listMessages);
			break;

		default:
			break;
		}
	}

	private static void validation(DataEntity readjustment,
			List<String> listMessages) {
		if (readjustment == null
				|| readjustment.get(ReadjustmentLoanCab.SECUENCIAL) == null
				|| Parameter.EMPTY_VALUE.equals(readjustment
						.get(ReadjustmentLoanCab.SECUENCIAL).toString().trim())) {
			GeneralFunction.setMessage(listMessages, DEBE_SELECCIONAR_REAJUSTE);
		}
	}
}
