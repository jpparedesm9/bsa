/**
 * Archivo: SpSpDeviceUtil.java
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

package com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.impl;

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


import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.Request;

public class SpSpDeviceUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSpDeviceUtil.class);
  
  private SpSpDeviceUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeSpDevice
     * @desciption Inicializa el sp: cob_sincroniza..sp_device
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeSpDevice(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_sincroniza";
		String spName = "sp_device";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("alias")) {
			wParameterValue = wParameter.get("alias");
			  aProcedureRequest.addInputParam("@i_alias", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("deviceId")) {
			wParameterValue = wParameter.get("deviceId");
			  aProcedureRequest.addInputParam("@i_device_id", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("login")) {
			wParameterValue = wParameter.get("login");
			  aProcedureRequest.addInputParam("@i_login", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("operation")) {
			wParameterValue = wParameter.get("operation");
			  aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("status")) {
			wParameterValue = wParameter.get("status");
			  aProcedureRequest.addInputParam("@i_status", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("returnName")) {
			wParameterValue = wParameter.get("returnName");
			  aProcedureRequest.addInputParam("i_ret_fu_nombre", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("firstTime")) {
			wParameterValue = wParameter.get("firstTime");
			  aProcedureRequest.addInputParam("@i_first_time", ICTSTypes.SQLINT1, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	}

    /**
     * @name       executeSpDevice
     * @desciption ejecuta el sp: cob_sincroniza..sp_device
     * @user       
     * @param      
     * @return
     */
	public static void executeSpDevice(com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobisclouddevicemanagement][executeSpDevice]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobisclouddevicemanagementSERVImpl executeSpDevice >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobisclouddevicemanagementSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeSpDevice(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultSpDevice", wLResult);
		aParameter.getInfo().put("aParamSpDevice", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobisclouddevicemanagementSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}
