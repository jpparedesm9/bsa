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
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.ecobis.businessprocess.orchestrator.UtilsOrchestrator;

@Component(name = "CommitPaymetPlanOrchestrator", immediate = false)
@Service(value = { ICISSPBaseOrchestration.class, IOrchestrator.class })
@Properties(value = { @Property(name = "service.description", value = "CommitPaymetPlanOrchestrator"), @Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"), @Property(name = "service.identifier", value = "CommitPaymetPlanOrchestrator"),
		@Property(name = "service.spName", value = "cob_procesador..commitPaymentPlan") })
public class CommitPaymetPlanOrchestrator extends SPJavaOrchestrationBase {

	private static final String AN_ORIGINAL_REQUEST = "anOriginalRequest";
	private static final String STEP_TWO_RESPONSE = "stepTwoResponse";
	private static final String STEP_ONE_RESPONSE = "stepOneResponse";
	private static final String STEP_THREE_RESPONSE = "stepThreeResponse";
	//private static final String COB_CREDITO_SP_CONSULTA_TRAMITE = "cob_credito..sp_tramite";
	private static final String COB_CREDITO_SP_CONSULTA_TRAMITE = "cob_pac..sp_tramite_busin";
	private static final String COB_CARTERA_SP_OPERACION_DEF = "cob_pac..sp_operacion_def_busin";
	private static final String COB_CARTERA_SP_APR_EXCEPCION = "cob_credito..sp_apr_excepcion";

	private final ILogger LOGGER = this.getLogger();

	@Override
	public void loadConfiguration(IConfigurationReader arg0) {

	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, Map<String, Object> aBagSPJavaOrchestration) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Starting commitPaymentPlan orchestration (@i_banco = " + anOriginalRequest.readValueParam("@i_banco") + ")");
		}

		aBagSPJavaOrchestration.put(AN_ORIGINAL_REQUEST, anOriginalRequest);

		// 1.- execute cob_credito..sp_consulta_tramite - Consulta numero de operacion
		if (this.queryNumberBank(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitDisbursmetLoanOrchestrator orchestration Step two --> query number bank");
			}
			return this.processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}

		// 2.- execute cob_cartera..sp_operacion_def
		if (copyFromtmpToFinalTables(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitPaymentPlan orchestration Step One --> copy from temporal to final tables ");
			}
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}

		// 2.- execute cob_credito..sp_apr_excepcion
		if (approveProcessed(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitPaymentPlan orchestration Step two --> approve processed ");
			}
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finishing CommitPaymentPlan orchestration");
		}
		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
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

	private boolean queryNumberBank(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CREDITO_SP_CONSULTA_TRAMITE);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, wOriginalRequest.readValueParam("@i_banco"));
		wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "Q");
		//wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "21520");
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "73932");
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_ONE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

	private boolean copyFromtmpToFinalTables(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CARTERA_SP_OPERACION_DEF);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");

		IProcedureResponse wProcedureResponseOne = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
		UtilsOrchestrator utilTwo = new UtilsOrchestrator(wProcedureResponseOne);
		Object valueBank = utilTwo.get(1, 1, 15);
		if ((valueBank != null) && (!valueBank.equals("")) && (!valueBank.toString().trim().isEmpty())) {
			// SI YA TIENE ATADO UN NUMERO DE BANCO ENTONCES LO ENVIA
			wProcedureRequest.addInputParam("@i_banco", ICTSTypes.SQLVARCHAR, valueBank.toString());
		} else {
			// CASO CONTRARIO POR DEFAULT ES EL NUMERO DE TRAMITE
			wProcedureRequest.addInputParam("@i_banco", ICTSTypes.SQLVARCHAR, wOriginalRequest.readValueParam("@i_banco"));
		}

		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_TWO_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

	private boolean approveProcessed(Map<String, Object> aBagSPJavaOrchestration) {
		Context context = ContextManager.getContext();
		CobisSession cobsession = (CobisSession) context.getSession();

		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CARTERA_SP_APR_EXCEPCION);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "21827");
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "21827");
		wProcedureRequest.addInputParam("@s_user", ICTSTypes.SQLVARCHAR, cobsession.getUser());
		wProcedureRequest.addInputParam("@i_modo", ICTSTypes.SQLINT2, "4");
		wProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINTN, wOriginalRequest.readValueParam("@i_banco"));

		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_THREE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

}
