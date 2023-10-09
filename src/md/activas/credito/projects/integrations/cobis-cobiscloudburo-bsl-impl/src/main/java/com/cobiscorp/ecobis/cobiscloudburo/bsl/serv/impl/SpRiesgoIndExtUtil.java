/**
 * Archivo: SpRiesgoIndExtUtil.java
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

public class SpRiesgoIndExtUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpRiesgoIndExtUtil.class);
  
  private SpRiesgoIndExtUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeRiesgoIndExt
     * @desciption Inicializa el sp: cobis..sp_riesgo_ind_externo
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeRiesgoIndExt(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cobis";
		String spName = "sp_riesgo_ind_externo";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("clientId")) {
			wParameterValue = wParameter.get("clientId");
			      aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
		if (wParameter.containsKey("validityBureauDays")) {
			wParameterValue = wParameter.get("validityBureauDays");
			      aProcedureRequest.addInputParam("@i_dias_vig_buro", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("typeRatingCustomerEvaluation")) {
			wParameterValue = wParameter.get("typeRatingCustomerEvaluation");
			aProcedureRequest.addInputParam("@i_tipo_calif_eva_cli", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("evaluateRule")) {
			wParameterValue = wParameter.get("evaluateRule");
			aProcedureRequest.addInputParam("@i_evaluar_reglas", ICTSTypes.SQLCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			      aProcedureRequest.addOutputParam("@o_nivel", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		//Color
		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			      aProcedureRequest.addOutputParam("@o_semaforo", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	}

    /**
     * @name       executeRiesgoIndExt
     * @desciption ejecuta el sp: cobis..sp_riesgo_ind_externo
     * @user       
     * @param      
     * @return
     */
	public static void executeRiesgoIndExt(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeRiesgoIndExt]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeRiesgoIndExt >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeRiesgoIndExt(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);
		
		logger.logDebug("statusCode: " + wProcedureResponse.getReturnCode());
		logger.logDebug("aResultRiesgoIndExt: " + wLResult);
		logger.logDebug("aParamRiesgoIndExt: " + wLParams);
		
        aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		aParameter.getInfo().put("aResultRiesgoIndExt", wLResult);
		aParameter.getInfo().put("aParamRiesgoIndExt", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

