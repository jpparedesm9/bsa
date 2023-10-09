package com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.impl;

import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;

public class SpBlackListCustomerUtil extends SpUtil  {
	
	private static ILogger logger = LogFactory.getLogger(SpBlackListCustomerUtil.class);
	
	public SpBlackListCustomerUtil()
	{
		
	}
	
	/**
     * @name       SpBlackListCustomerUtil
     * @desciption Inicializa el sp: cob_credito..sp_busq_listas_cliente
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeBlackListCustomer(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_credito";
		String spName = "sp_busq_listas_cliente";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("clientId")) {
			wParameterValue = wParameter.get("clientId");
			      aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			      aProcedureRequest.addOutputParam("@o_resultado", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
	}

    /**
     * @name       executeBlackListCustomer
     * @desciption ejecuta el sp: cob_credito..sp_busq_listas_cliente
     * @user       
     * @param      
     * @return
     */
	public static void executeBlackListCustomer(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeBlackListCustomer]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeBlackListCustomer >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeBlackListCustomer(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

       aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultBlackListCustomer", wLResult);
		aParameter.getInfo().put("aParamBlackListCustomer", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}

}
