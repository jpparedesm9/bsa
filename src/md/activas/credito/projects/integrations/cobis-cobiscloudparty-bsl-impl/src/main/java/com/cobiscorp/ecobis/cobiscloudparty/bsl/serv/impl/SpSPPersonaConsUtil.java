/**
 * Archivo: SpSPPersonaConsUtil.java
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

public class SpSPPersonaConsUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSPPersonaConsUtil.class);
  
  private SpSPPersonaConsUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeSPPersonaCons
     * @desciption Inicializa el sp: cobis..sp_persona_cons
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeSPPersonaCons(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cobis";
		String spName = "sp_persona_cons";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("mode")) {
			wParameterValue = wParameter.get("mode");
			aProcedureRequest.addInputParam("@i_modo", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("operation")) {
			wParameterValue = wParameter.get("operation");
			aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("customerId")) {
			wParameterValue = wParameter.get("customerId");
			aProcedureRequest.addInputParam("@i_persona", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("trn")) {
			wParameterValue = wParameter.get("trn");
			aProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	}

    /**
     * @name       executeSPPersonaCons
     * @desciption ejecuta el sp: cobis..sp_persona_cons
     * @user       
     * @param      
     * @return
     */
	public static void executeSPPersonaCons(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudparty][executeSPPersonaCons]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeSPPersonaCons >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeSPPersonaCons(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultSPPersonaCons", wLResult);
		aParameter.getInfo().put("aParamSPPersonaCons", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

