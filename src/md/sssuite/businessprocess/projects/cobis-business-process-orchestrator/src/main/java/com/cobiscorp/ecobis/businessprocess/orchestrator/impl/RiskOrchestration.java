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

@Component(name = "RiskOrchestration", immediate = false)
@Service(value = { ICISSPBaseOrchestration.class, IOrchestrator.class })
@Properties(value = { @Property(name = "service.description", value = "RiskOrchestration"), @Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"), @Property(name = "service.identifier", value = "RiskOrchestration"),
		@Property(name = "service.spName", value = "cob_procesador..riskOrchestration") })
public class RiskOrchestration extends SPJavaOrchestrationBase {

	private static final String AN_ORIGINAL_REQUEST = "anOriginalRequest";
	private static final String COB_CARTERA_SP_VAR_ACT_RIESGO_CLI_ORG = "cob_credito..sp_var_act_riesgo_cli_org";
	private static final String STEP_ONE_RESPONSE = "stepOneResponse";
	
	private final ILogger LOGGER = this.getLogger();
	
	@Override
	public void loadConfiguration(IConfigurationReader arg0) {

	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, Map<String, Object> aBagSPJavaOrchestration) {
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Starting risk orchestration (@i_id_inst_proc = " + anOriginalRequest.readValueParam("@i_id_inst_proc") + ")");
			LOGGER.logDebug("(@i_user = " + anOriginalRequest.readValueParam("anOriginalRequest") + ")");
		}
		
		aBagSPJavaOrchestration.put(AN_ORIGINAL_REQUEST, anOriginalRequest);
		executeSpCustomerRisk(aBagSPJavaOrchestration);
		
		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	@Override
	public IProcedureResponse processResponse(IProcedureRequest anOriginalProcedureReq, Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(anOriginalProcedureReq));
	    String[] wAllProcedureResponse = {STEP_ONE_RESPONSE};
	    CISResponseManagmentHelper.addOutputParamsResponseS(wProcedureRespFinal, anOriginalProcedureReq, wAllProcedureResponse, aBagSPJavaOrchestration);
	    CISResponseManagmentHelper.addResultsetsResponseS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
	    IProcedureResponse wProcedureResponseStepOne = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
	    if (wProcedureResponseStepOne != null && wProcedureResponseStepOne.getMessageListSize() != 0) {
	    	CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
	        wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
	    } else {
	        wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
	    }
	    return wProcedureRespFinal;
	}
	
	
	private boolean executeSpCustomerRisk(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CARTERA_SP_VAR_ACT_RIESGO_CLI_ORG);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_id_inst_proc", ICTSTypes.SQLINT1, wOriginalRequest.readValueParam("@i_id_inst_proc"));
		wProcedureRequest.addInputParam("@i_user", ICTSTypes.SQLVARCHAR, wOriginalRequest.readValueParam("@i_user"));
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_ONE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();

	}

}
