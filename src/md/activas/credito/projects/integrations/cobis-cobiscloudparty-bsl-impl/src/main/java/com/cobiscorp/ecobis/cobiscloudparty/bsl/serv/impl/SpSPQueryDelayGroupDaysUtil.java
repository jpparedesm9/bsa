/**
 * Archivo: SpSPQueryDelayGroupDaysUtil.java
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
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;

import com.cobiscorp.cobis.cts.domains.ICTSTypes;


import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request;

public class SpSPQueryDelayGroupDaysUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSPQueryDelayGroupDaysUtil.class);
  
  private SpSPQueryDelayGroupDaysUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeSPQueryDelayGroupDays
     * @desciption Inicializa el sp: cob_credito..sp_dias_atraso_grupal
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeSPQueryDelayGroupDays(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_credito";
		String spName = "sp_dias_atraso_grupal";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("cyclesNumber")) {
			wParameterValue = wParameter.get("cyclesNumber");
			aProcedureRequest.addInputParam("@i_ciclos_ant", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("cycleStatus")) {
			wParameterValue = wParameter.get("cycleStatus");
			aProcedureRequest.addInputParam("@i_es_ciclo_ant", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("idGroup")) {
			wParameterValue = wParameter.get("idGroup");
			aProcedureRequest.addInputParam("@i_grupo", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_resultado", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	}

    /**
     * @name       executeSPQueryDelayGroupDays
     * @desciption ejecuta el sp: cob_credito..sp_dias_atraso_grupal
     * @user       
     * @param      
     * @return
     */
	public static void executeSPQueryDelayGroupDays(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudparty][executeSPQueryDelayGroupDays]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeSPQueryDelayGroupDays >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeSPQueryDelayGroupDays(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultSPQueryDelayGroupDays", wLResult);
		aParameter.getInfo().put("aParamSPQueryDelayGroupDays", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

