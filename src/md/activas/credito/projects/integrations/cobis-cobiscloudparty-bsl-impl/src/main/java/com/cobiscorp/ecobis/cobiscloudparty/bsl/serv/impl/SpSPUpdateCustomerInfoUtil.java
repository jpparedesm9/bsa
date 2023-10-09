/**
 * Archivo: SpSPUpdateCustomerInfoUtil.java
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

public class SpSPUpdateCustomerInfoUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSPUpdateCustomerInfoUtil.class);
  
  private SpSPUpdateCustomerInfoUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeSPUpdateCustomerInfo
     * @desciption Inicializa el sp: cobis..sp_persona_upd
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeSPUpdateCustomerInfo(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cobis";
		String spName = "sp_persona_upd";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("bank")) {
			wParameterValue = wParameter.get("bank");
			aProcedureRequest.addInputParam("@i_banco", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("riskScore")) {
			wParameterValue = wParameter.get("riskScore");
			aProcedureRequest.addInputParam("@i_calificacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("indRiskScore")) {
			wParameterValue = wParameter.get("indRiskScore");
			aProcedureRequest.addInputParam("@i_calificacion_ind", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("bankAccount")) {
			wParameterValue = wParameter.get("bankAccount");
			aProcedureRequest.addInputParam("@i_ea_cta_banco", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("execute")) {
			wParameterValue = wParameter.get("execute");
			aProcedureRequest.addInputParam("@i_ejecutar", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("status")) {
			wParameterValue = wParameter.get("status");
			aProcedureRequest.addInputParam("@i_estado_std", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("operationType")) {
			wParameterValue = wParameter.get("operationType");
			aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("customerId")) {
			wParameterValue = wParameter.get("customerId");
			aProcedureRequest.addInputParam("@i_persona", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("transaction")) {
			wParameterValue = wParameter.get("transaction");
			aProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		logger.logDebug("<<<<<<<<<< initializeSPUpdateCustomerInfo >>>>>>>>>>"+ wParameter);
		
		
	}

    /**
     * @name       executeSPUpdateCustomerInfo
     * @desciption ejecuta el sp: cobis..sp_persona_upd
     * @user       
     * @param      
     * @return
     */
	public static void executeSPUpdateCustomerInfo(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudparty][executeSPUpdateCustomerInfo]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeSPUpdateCustomerInfo >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeSPUpdateCustomerInfo(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultSPUpdateCustomerInfo", wLResult);
		aParameter.getInfo().put("aParamSPUpdateCustomerInfo", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

