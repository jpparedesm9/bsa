package com.cobiscorp.cobis.assts.customevents.parameter;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter.TYPEEXECUTION;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentDetalilsLoan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;

public abstract class GeneralValidation {
	private static final ILogger logger = LogFactory
			.getLogger(GeneralValidation.class);

	private static final String DEBE_SELECCIONAR_OPERACION = "ASSTS.LBL_ASSTS_DEBESELNN_37143";
	private static final String DEBE_SELECCIONAR_REAJUSTE = "ASSTS.LBL_ASSTS_DEBESELCT_29478";
	private static final String DEBE_SELECCIONAR_DETALLE_REAJUSTE = "ASSTS.LBL_ASSTS_DEBESELNO_78735";
	private static final String DEBE_INGRESAR_VALOR_FAC_PORC = "ASSTS.LBL_ASSTS_SEDEBEIAF_79454";
	private static final String DEBE_INGRESAR_PORC = "ASSTS.LBL_ASSTS_DESERINSN_80560";
	private static final String DEBE_INGRESAR_INFORMACION_COMPLETA = "ASSTS.LBL_ASSTS_PARAINGLE_54663";
	private static final String DEBE_INGRESA_MAYOR_CERO = "ASSTS.LBL_ASSTS_SISEINGAE_33960";

	private GeneralValidation() {

	}

	public static List<String> validationReadjustmentDetails(
			Parameter.TYPEEXECUTION typeExecution,
			DataEntity readjustmentDetail, DataEntity readjustment,
			DataEntity loan) {
		List<String> listMessages = new ArrayList<String>();

		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al validationReadjustmentDetails "
					+ typeExecution.toString());
		}

		try {
			validationGeneric(readjustment, loan, listMessages);
			validationDetailReadjusment(typeExecution, readjustmentDetail,
					listMessages);
		} catch (Exception ex) {
			GeneralFunction.setMessage(listMessages, ex.getMessage());
			logger.logError(ex);
		}

		return listMessages;
	}

	private static void validationGeneric(DataEntity readjustment,
			DataEntity loan, List<String> listMessages) {

		if (loan == null
				|| loan.get(Loan.LOANBANKID) == null
				|| Parameter.EMPTY_VALUE.equals(loan.get(Loan.LOANBANKID)
						.trim())) {
			GeneralFunction
					.setMessage(listMessages, DEBE_SELECCIONAR_OPERACION);
		}

		if (readjustment == null
				|| readjustment.get(ReadjustmentLoanCab.SECUENCIAL) == null
				|| Parameter.EMPTY_VALUE.equals(readjustment
						.get(ReadjustmentLoanCab.SECUENCIAL).toString().trim())) {
			GeneralFunction.setMessage(listMessages, DEBE_SELECCIONAR_REAJUSTE);
		}
	}

	private static void validationDetailReadjusment(
			Parameter.TYPEEXECUTION typeExecution,
			DataEntity readjustmentDetail, List<String> listMessages) {
		if (typeExecution != Parameter.TYPEEXECUTION.SEARCH
				&& (readjustmentDetail == null
						|| readjustmentDetail
								.get(ReadjustmentDetalilsLoan.CONCEPTO) == null || Parameter.EMPTY_VALUE
							.equals(readjustmentDetail.get(
									ReadjustmentDetalilsLoan.CONCEPTO).trim()))) {
			GeneralFunction.setMessage(listMessages,
					DEBE_SELECCIONAR_DETALLE_REAJUSTE);
		}

		if (typeExecution == TYPEEXECUTION.UPDATE) {
			updateValidation(readjustmentDetail, listMessages);
		}
	}

	private static void updateValidation(DataEntity readjustmentDetail,
			List<String> listMessages) {
		if (readjustmentDetail != null) {
			if (isAllNull(readjustmentDetail)) {
				GeneralFunction.setMessage(listMessages,
						DEBE_INGRESAR_VALOR_FAC_PORC);
			} else if (isNotPorcentage(readjustmentDetail)) {
				GeneralFunction.setMessage(listMessages, DEBE_INGRESAR_PORC);
			} else if (isNotCompleteInformation(readjustmentDetail)) {
				GeneralFunction.setMessage(listMessages,
						DEBE_INGRESAR_INFORMACION_COMPLETA);
			} else if (readjustmentDetail
					.get(ReadjustmentDetalilsLoan.PORCENTAJE) != null
					&& (readjustmentDetail
							.get(ReadjustmentDetalilsLoan.PORCENTAJE) <= 0)) {
				GeneralFunction.setMessage(listMessages,
						DEBE_INGRESA_MAYOR_CERO);
			}
		}
	}

	private static Boolean isAllNull(DataEntity readjustmentDetail) {
		Boolean resultado = false;
		if (readjustmentDetail.get(ReadjustmentDetalilsLoan.REFERENCIAL) == null
				&& readjustmentDetail.get(ReadjustmentDetalilsLoan.SIGNO) == null
				&& readjustmentDetail.get(ReadjustmentDetalilsLoan.FACTOR) == null
				&& readjustmentDetail.get(ReadjustmentDetalilsLoan.PORCENTAJE) == null) {
			resultado = true;
		}
		return resultado;
	}

	private static Boolean isNotPorcentage(DataEntity readjustmentDetail) {
		Boolean resultado = false;
		if ((readjustmentDetail.get(ReadjustmentDetalilsLoan.PORCENTAJE) != null)
				&& (readjustmentDetail
						.get(ReadjustmentDetalilsLoan.REFERENCIAL) != null
						|| readjustmentDetail
								.get(ReadjustmentDetalilsLoan.SIGNO) != null || readjustmentDetail
						.get(ReadjustmentDetalilsLoan.FACTOR) != null)) {
			resultado = true;
		}
		return resultado;
	}

	private static Boolean isNotCompleteInformation(
			DataEntity readjustmentDetail) {
		Boolean resultado = false;
		if ((readjustmentDetail.get(ReadjustmentDetalilsLoan.PORCENTAJE) == null)
				&& (readjustmentDetail
						.get(ReadjustmentDetalilsLoan.REFERENCIAL) == null
						|| readjustmentDetail
								.get(ReadjustmentDetalilsLoan.SIGNO) == null || readjustmentDetail
						.get(ReadjustmentDetalilsLoan.FACTOR) == null)) {
			resultado = true;
		}
		return resultado;
	}
}
