package com.cobiscorp.ecobis.businessprocess.orchestrator.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.cobiscorp.cobisv.commons.context.Session;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;


@Component(name = "CommitAddAmountOrchestrator", immediate = false)
@Service(value = { ICISSPBaseOrchestration.class, IOrchestrator.class })
@Properties(value = { @Property(name = "service.description", value = "CommitAddAmountOrchestrator"), @Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"), @Property(name = "service.identifier", value = "CommitAddAmountOrchestrator"),
		@Property(name = "service.spName", value = "cob_procesador..commitAddAmount") })
public class CommitAddAmountOrchestrator extends SPJavaOrchestrationBase {

	private static final String AN_ORIGINAL_REQUEST = "anOriginalRequest";
	private static final String STEP_ONE_RESPONSE = "stepOneResponse";
	private static final String STEP_TWO_RESPONSE = "stepTwoResponse";
	private static final String STEP_THREE_RESPONSE = "stepThreeResponse";
	
	private static final String COB_CREDITO_SP_FONDO_GARANTIAS = "cob_credito..sp_fondo_garantias";
	
	
	private final ILogger LOGGER = this.getLogger();
	

	@Override
	public void loadConfiguration(IConfigurationReader arg0) {

	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, Map<String, Object> aBagSPJavaOrchestration) {
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Starting CommitDisbursmetLoanOrchestrator orchestration (@i_tramite = " + anOriginalRequest.readValueParam("@i_tramite") + ")");
		}
		
		aBagSPJavaOrchestration.put(AN_ORIGINAL_REQUEST, anOriginalRequest);
		// 1.- execute cob_credito..sp_consulta_tramite - Consulta numero de operacion
		if (comminAddAmount(aBagSPJavaOrchestration)) {
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug("CommitDisbursmetLoanOrchestrator orchestration Step One --> query number bank ");
			}
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
					
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Finishing CommitPaymentPlan orchestration");
		}
		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	@Override
	public IProcedureResponse processResponse(IProcedureRequest anOriginalProcedureReq, Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(anOriginalProcedureReq));
	    String[] wAllProcedureResponse = {STEP_ONE_RESPONSE, STEP_TWO_RESPONSE};
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
	    return wProcedureRespFinal;
	}
	
	private boolean comminAddAmount(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CREDITO_SP_FONDO_GARANTIAS);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, wOriginalRequest.readValueParam("@i_tramite"));
		wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "Q");
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "21520");
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_ONE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();

	}
	
}
