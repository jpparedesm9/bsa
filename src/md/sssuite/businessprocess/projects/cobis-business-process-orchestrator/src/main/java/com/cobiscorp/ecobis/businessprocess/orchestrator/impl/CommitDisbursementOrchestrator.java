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

@Component(name = "CommitDisbursementOrchestrator", immediate = false)
@Service(value = { ICISSPBaseOrchestration.class, IOrchestrator.class })
@Properties(value = { @Property(name = "service.description", value = "CommitDisbursementOrchestrator"), @Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"), @Property(name = "service.identifier", value = "CommitDisbursementOrchestrator"),
		@Property(name = "service.spName", value = "cob_procesador..commitDisbursement") })
public class CommitDisbursementOrchestrator extends SPJavaOrchestrationBase{

	private static final String AN_ORIGINAL_REQUEST = "anOriginalRequest";
	private static final String STEP_TWO_RESPONSE = "stepTwoResponse";
	//private static final String STEP_ONE_RESPONSE = "stepOneResponse";
	private static final String COB_CARTERA_SP_BORRAR_TMP = "cob_cartera..sp_borrar_tmp";
	
	private final ILogger LOGGER = this.getLogger();
	
	@Override
	public void loadConfiguration(IConfigurationReader arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, Map<String, Object> aBagSPJavaOrchestration) {
		// TODO Auto-generated method stub
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Starting commitDisbursement orchestration (@i_banco = " + anOriginalRequest.readValueParam("@i_banco") + ")");
		}
		
		aBagSPJavaOrchestration.put(AN_ORIGINAL_REQUEST, anOriginalRequest);
		/* 1.- execute cob_cartera..sp_operacion_def
		if (copyFromtmpToFinalTables(aBagSPJavaOrchestration)) {
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug("CommitPaymentPlan orchestration Step One --> copy from temporal to final tables ");
			}
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}*/

		// 2 execute cob_cartera..sp_borrar_tmp
		if (deleteTmpTables(aBagSPJavaOrchestration)) {
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug("CommitDisbursement orchestration Step two --> deleting temporal tables ");
			}
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Finishing CommitDisbursement orchestration");
		}
		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	@Override
	public IProcedureResponse processResponse(IProcedureRequest anOriginalProcedureReq, Map<String, Object> aBagSPJavaOrchestration) {
		// TODO Auto-generated method stub
		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(anOriginalProcedureReq));
	    String[] wAllProcedureResponse = {STEP_TWO_RESPONSE};
	    CISResponseManagmentHelper.addOutputParamsResponseS(wProcedureRespFinal, anOriginalProcedureReq, wAllProcedureResponse, aBagSPJavaOrchestration);
	    CISResponseManagmentHelper.addResultsetsResponseS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
	    /*IProcedureResponse wProcedureResponseStepOne = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
	    
	    if (wProcedureResponseStepOne != null && wProcedureResponseStepOne.getMessageListSize() != 0) {
	    	CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
	        wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
	    } else {
	        wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
	    }*/
	    IProcedureResponse wProcedureResponseStepTwo = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_TWO_RESPONSE);
	    if (wProcedureResponseStepTwo != null && wProcedureResponseStepTwo.getMessageListSize() != 0) {
	    	CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
	        wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
	    } else {
	        wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
	    }
	    return wProcedureRespFinal;
	}
	
	private boolean deleteTmpTables(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CARTERA_SP_BORRAR_TMP);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_banco", ICTSTypes.SQLVARCHAR, wOriginalRequest.readValueParam("@i_banco"));
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_TWO_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

}
