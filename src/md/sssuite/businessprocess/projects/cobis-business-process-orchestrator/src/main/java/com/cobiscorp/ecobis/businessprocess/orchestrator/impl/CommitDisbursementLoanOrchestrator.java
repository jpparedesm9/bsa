package com.cobiscorp.ecobis.businessprocess.orchestrator.impl;

import java.util.Map;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import com.cobiscorp.cobis.cis.sp.java.orchestration.CISResponseManagmentHelper;
import com.cobiscorp.cobis.cis.sp.java.orchestration.ICISSPBaseOrchestration;
import com.cobiscorp.cobis.cis.sp.java.orchestration.SPJavaOrchestrationBase;
import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.csp.domains.ICSP;
import com.cobiscorp.cobis.csp.services.inproc.IOrchestrator;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.ecobis.businessprocess.orchestrator.UtilsOrchestrator;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;

@Component(name = "CommitDisbursementLoanOrchestrator", immediate = false)
@Service(value = { ICISSPBaseOrchestration.class, IOrchestrator.class })
@Properties(value = { @Property(name = "service.description", value = "CommitDisbursementLoanOrchestrator"), @Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"), @Property(name = "service.identifier", value = "CommitDisbursementLoanOrchestrator"),
		@Property(name = "service.spName", value = "cob_procesador..commitDisbursementLoan") })
public class CommitDisbursementLoanOrchestrator extends SPJavaOrchestrationBase {

	private static final String AN_ORIGINAL_REQUEST = "anOriginalRequest";
	private static final String STEP_ONE_RESPONSE = "stepOneResponse";
	private static final String STEP_TWO_RESPONSE = "stepTwoResponse";
	private static final String STEP_THREE_RESPONSE = "stepThreeResponse";

	private static final String COB_CREDITO_SP_VALIDA_CIC_INFOCRED = "cob_credito..sp_valida_cic_infocred";
	private static final String COB_CREDITO_SP_CONSULTA_TRAMITE = "cob_credito..sp_tramite";
	private static final String COB_CARTERA_SP_LIQUIDA = "cob_cartera..sp_liquida";

	private final ILogger LOGGER = this.getLogger();

	@Override
	public void loadConfiguration(IConfigurationReader arg0) {
	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, Map<String, Object> aBagSPJavaOrchestration) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Starting CommitDisbursmetLoanOrchestrator orchestration (@i_tramite = " + anOriginalRequest.readValueParam("@i_tramite") + ")");
		}

		aBagSPJavaOrchestration.put(AN_ORIGINAL_REQUEST, anOriginalRequest);

		// 1.- execute cob_credito..sp_valida_cic_infocred - Valida fechas de centrales CIC e Infocred
		if (this.validateCicInfocred(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitDisbursmetLoanOrchestrator orchestration Step one --> validate CIC Infocred");
			}
			return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}

		// 2.- execute cob_credito..sp_consulta_tramite - Consulta numero de operacion
		if (this.queryNumberBank(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitDisbursmetLoanOrchestrator orchestration Step two --> query number bank");
			}
			return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
		// 3.- execute cob_cartera..sp_liquida
		if (this.commitDisbursement(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitDisbursmetLoanOrchestrator orchestration Step three --> apply Disbursment");
			}
			return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finishing CommitPaymentPlan orchestration");
		}
		return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	@Override
	public IProcedureResponse processResponse(IProcedureRequest anOriginalProcedureReq, Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(anOriginalProcedureReq));
		String[] wAllProcedureResponse = { STEP_ONE_RESPONSE, STEP_TWO_RESPONSE, STEP_THREE_RESPONSE };
		CISResponseManagmentHelper.addOutputParamsResponseS(wProcedureRespFinal, anOriginalProcedureReq, wAllProcedureResponse, aBagSPJavaOrchestration);
		CISResponseManagmentHelper.addResultsetsResponseS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);

		IProcedureResponse wProcedureResponseStepOne = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
		if (wProcedureResponseStepOne != null && wProcedureResponseStepOne.getMessageListSize() != 0) {
			CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		IProcedureResponse wProcedureResponseStepTwo = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_TWO_RESPONSE);
		if (wProcedureResponseStepTwo != null && wProcedureResponseStepTwo.getMessageListSize() != 0) {
			CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}

		IProcedureResponse wProcedureResponseStepThree = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_THREE_RESPONSE);
		if (wProcedureResponseStepThree != null && wProcedureResponseStepThree.getMessageListSize() != 0) {
			CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}
		return wProcedureRespFinal;
	}

	private boolean validateCicInfocred(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CREDITO_SP_VALIDA_CIC_INFOCRED);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "21188");
		wProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, wOriginalRequest.readValueParam("@i_tramite"));
		wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "D");
		wProcedureRequest.addInputParam("@i_ejecuta_raiserror", ICTSTypes.SQLCHAR, "N");
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_ONE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

	private boolean queryNumberBank(Map<String, Object> aBagSPJavaOrchestration) {
		// Si Validacion fechas de CIC-Infocred tiene error no ejecuta SP
		IProcedureResponse wProcedureResponseOne = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
		UtilsOrchestrator util = new UtilsOrchestrator(wProcedureResponseOne);
		if (util.getReturnCode() != 0) { // Si Validacion fechas de CIC-Infocred tiene error no ejecuta SP
			return false;
		}
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CREDITO_SP_CONSULTA_TRAMITE);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, wOriginalRequest.readValueParam("@i_tramite"));
		wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "Q");
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "21520");
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_TWO_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

	private boolean commitDisbursement(Map<String, Object> aBagSPJavaOrchestration) {
		// Si Validacion fechas de CIC-Infocred tiene error no ejecuta SP
		IProcedureResponse wProcedureResponseOne = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
		UtilsOrchestrator utilOne = new UtilsOrchestrator(wProcedureResponseOne);
		if (utilOne.getReturnCode() != 0) { // Si Validacion fechas de CIC-Infocred tiene error no ejecuta SP
			return false;
		}

		Context context = ContextManager.getContext();
		CobisSession cobsession = (CobisSession) context.getSession();

		IProcedureResponse wProcedureResponseTwo = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_TWO_RESPONSE);
		UtilsOrchestrator utilTwo = new UtilsOrchestrator(wProcedureResponseTwo);
		String opBank = (String) utilTwo.get(1, 1, 15);

		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CARTERA_SP_LIQUIDA);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_banco_ficticio", ICTSTypes.SQLVARCHAR, opBank);
		wProcedureRequest.addInputParam("@i_banco_real", ICTSTypes.SQLVARCHAR, opBank);
		wProcedureRequest.addInputParam("@i_fecha_liq", ICTSTypes.SQLDATETIME, context.getProcessDate());
		wProcedureRequest.addInputParam("@i_originador", ICTSTypes.SQLCHAR, "S");
		wProcedureRequest.addInputParam("@i_externo", ICTSTypes.SQLCHAR, "S");

		wProcedureRequest.addInputParam("@s_user", ICTSTypes.SQLVARCHAR, cobsession.getUser());
		wProcedureRequest.addInputParam("@s_ofi", ICTSTypes.SQLINT4, cobsession.getOffice());
		wProcedureRequest.addInputParam("@s_term", ICTSTypes.SQLVARCHAR, cobsession.getTerminal());
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_THREE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}
}
