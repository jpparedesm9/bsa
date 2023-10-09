package com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.impl;


import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.List;
import java.sql.Types;

import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;

import java.util.Collection;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;


public class SpScoreBuroUtil  extends SpUtil{

	private static ILogger logger = LogFactory.getLogger(SpScoreBuroUtil.class);
	  
	  private SpScoreBuroUtil() {
	    //private constructor because it is a class utility
	  }
	
	  /**
	     * @name       initializeInterfaceBuro
	     * @desciption Inicializa el sp: cob_credito..sp_score_buro
	     * @user       
	     * @param      aProcedureRequest
		 *             aParameter
	     * @return
	     */
	  private static void initializeScoreBuro(IProcedureRequest aProcedureRequest, Request aParameter){
			
			String targetId = null;
			String database = "cob_credito";
			String spName = "sp_score_buro";
			
			initialize(aProcedureRequest, aParameter, database, spName, targetId);
			
			//Mapa donde viene los parametros de entrada
			Map wParameter = (Map)aParameter.getInfo().get("aParameter");
			Object wParameterValue;
			
			if (wParameter.containsKey("operacion")) {
				wParameterValue = wParameter.get("operacion");
	            aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("ente")) {
				wParameterValue = wParameter.get("ente");
	            aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
	    	
			if (wParameter.containsKey("nombreScore")) {
				wParameterValue = wParameter.get("nombreScore");
	            aProcedureRequest.addInputParam("@i_nombre_score", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("codigoScore")) {
				wParameterValue = wParameter.get("codigoScore");
	            aProcedureRequest.addInputParam("@i_codigo_score", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("valorScore")) {
				wParameterValue = wParameter.get("valorScore");
	            aProcedureRequest.addInputParam("@i_valor_score", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("codigoRazon")) {
				wParameterValue = wParameter.get("codigoRazon");
	            aProcedureRequest.addInputParam("@i_codigo_razon", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("codigoError")) {
				wParameterValue = wParameter.get("codigoError");
	            aProcedureRequest.addInputParam("@i_codigo_error", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (logger.isInfoEnabled()) {
				logger.logInfo("[VALORES] **** processResponse" + aProcedureRequest.getProcedureRequestAsString());
			} 
	  }
	  
	  /**
	     * @name       executeScoreBuro
	     * @desciption ejecuta el sp: cob_credito..sp_score_buro
	     * @user       
	     * @param      
	     * @return
	     */
		public static void executeScoreBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
			String wInfo = "[cobiscloudburo][executeScoreBuro]";		
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeEmpleoBuro >>>>>>>>>>");
				logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
				logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
			}

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
			
			initializeScoreBuro(wProcedureRequest,aParameter);
			IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);
			
			if (logger.isInfoEnabled()) {
				logger.logInfo("[VALORES 2] **** processResponse" + wProcedureRequest.getProcedureRequestAsString());
			} 

			evaluateResponseStatusSP(wProcedureResponse);
				
			List wLResult = SpUtil.getResultSets(wProcedureResponse);
			List wLParams = SpUtil.getParams(wProcedureResponse);

	  aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
			
			aParameter.getInfo().put("aResultScoreBuro", wLResult);
			aParameter.getInfo().put("aParamScoreBuro", wLParams);

			
			
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
			}
		}
		
}
