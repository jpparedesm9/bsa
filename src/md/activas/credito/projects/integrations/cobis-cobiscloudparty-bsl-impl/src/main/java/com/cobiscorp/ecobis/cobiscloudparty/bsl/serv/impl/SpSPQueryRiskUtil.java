/**
 * Archivo: SpInterfaceCreditBuroUtil.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.impl;

import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request;

public class SpSPQueryRiskUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSPQueryRiskUtil.class);
  
  private SpSPQueryRiskUtil() {
    //private constructor because it is a class utility
  }
	   /**
	     * @name       initializeInterfaceRiskInd
	     * @desciption Inicializa el sp: cob_credito..sp_var_calif_buro_cred_int
	     * @user       
	     * @param      aProcedureRequest
	     * @return
	     */
		private static void initializeInterfaceRiskInd(IProcedureRequest aProcedureRequest, Request aParameter){
			
			String targetId = null;
			String database = "cob_credito";
			String spName = "sp_var_calif_buro_cred_int";
			
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
				aProcedureRequest.addOutputParam("@o_resultado", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}	
		}

	    /**
	     * @name       executeInterfaceRisk
	     * @desciption ejecuta el sp: cob_credito..sp_var_calif_buro_cred_int
	     * @user       
	     * @param      
	     * @return
	     */
		public static void executeInterfaceRiskInd(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
			String wInfo = "[cobiscloudburo][executeInterfaceRiskInd]";		
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< SpSPQueryRiskUtil executeInterfaceRiskInd >>>>>>>>>>");
				logger.logDebug(wInfo + "<<<<<<<<<< SpSPQueryRiskUtil aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
				logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
			}

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
			
			initializeInterfaceRiskInd(wProcedureRequest,aParameter);
			IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

			evaluateResponseStatusSP(wProcedureResponse);
				
			List wLResult = SpUtil.getResultSets(wProcedureResponse);
			List wLParams = SpUtil.getParams(wProcedureResponse);
			
			aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
			
			aParameter.getInfo().put("aResultInterfaceRisk", wLResult);
			aParameter.getInfo().put("aParamInterfaceRisk", wLParams);
			
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< SpSPQueryRiskUtil executeInterfaceRiskInd >>>>>>>>>>");
			}
		}	

		   /**
	     * @name       initializeInterfaceRiskGroup
	     * @desciption Inicializa el sp: cob_credito..sp_var_buro_credito_grupal
	     * @user       
	     * @param      aProcedureRequest
	     * @return
	     */
		private static void initializeInterfaceRiskGroup(IProcedureRequest aProcedureRequest, Request aParameter){
			
			String targetId = null;
			String database = "cob_credito";
			String spName = "sp_var_buro_credito_grupal";
			
			initialize(aProcedureRequest, aParameter, database, spName, targetId);

			//Mapa donde viene los parametros de entrada
			Map wParameter = (Map)aParameter.getInfo().get("aParameter");
			Object wParameterValue;
			if (wParameter.containsKey("groupId")) {
				wParameterValue = wParameter.get("groupId");
				aProcedureRequest.addInputParam("@i_grupo", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			if (wParameter.containsKey("clientId")) {
				wParameterValue = wParameter.get("clientId");
				aProcedureRequest.addInputParam("@i_cliente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			if (wParameter.containsKey("result")) {
				wParameterValue = wParameter.get("result");
				aProcedureRequest.addOutputParam("@o_resultado", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}	
		}

	    /**
	     * @name       executeInterfaceRisk
	     * @desciption ejecuta el sp: cob_credito..sp_var_buro_credito_grupal
	     * @user       
	     * @param      
	     * @return
	     */
		public static void executeInterfaceRiskGroup(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
			String wInfo = "[cobiscloudburo][executeInterfaceRisk]";		
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< SpSPQueryRiskUtil executeInterfaceRiskGroup >>>>>>>>>>");
				logger.logDebug(wInfo + "<<<<<<<<<< SpSPQueryRiskUtil aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
				logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
			}

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
			
			initializeInterfaceRiskGroup(wProcedureRequest,aParameter);
			IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

			evaluateResponseStatusSP(wProcedureResponse);
				
			List wLResult = SpUtil.getResultSets(wProcedureResponse);
			List wLParams = SpUtil.getParams(wProcedureResponse);
			
			aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
			
			aParameter.getInfo().put("aResultInterfaceRisk", wLResult);
			aParameter.getInfo().put("aParamInterfaceRisk", wLParams);
			
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< SpSPQueryRiskUtil executeInterfaceRiskGroup >>>>>>>>>>");
			}
		}	
}

