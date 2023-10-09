/**
 * Archivo: SpSpDeviceLockUtil.java
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

public class SpSpDeviceLockUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSpDeviceLockUtil.class);
  
  private SpSpDeviceLockUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeSpDeviceLock
     * @desciption Inicializa el sp: cob_sincroniza..sp_device_lock
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeSpDeviceLock(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_sincroniza";
		String spName = "sp_device_lock";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("comment")) {
			wParameterValue = wParameter.get("comment");
			  aProcedureRequest.addInputParam("@i_comment", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("deviceId")) {
			wParameterValue = wParameter.get("deviceId");
			  aProcedureRequest.addInputParam("@i_device_id", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("deviceLockId")) {
			wParameterValue = wParameter.get("deviceLockId");
			  aProcedureRequest.addInputParam("@i_device_lock_id", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("lockDate")) {
			wParameterValue = wParameter.get("lockDate");
			  aProcedureRequest.addInputParam("@i_lock_date", ICTSTypes.SQLDATETIME, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("lockStatus")) {
			wParameterValue = wParameter.get("lockStatus");
			  aProcedureRequest.addInputParam("@i_lock_status", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("operation")) {
			wParameterValue = wParameter.get("operation");
			  aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	}

    /**
     * @name       executeSpDeviceLock
     * @desciption ejecuta el sp: cob_sincroniza..sp_device_lock
     * @user       
     * @param      
     * @return
     */
	public static void executeSpDeviceLock(com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobisclouddevicemanagement][executeSpDeviceLock]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobisclouddevicemanagementSERVImpl executeSpDeviceLock >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobisclouddevicemanagementSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeSpDeviceLock(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultSpDeviceLock", wLResult);
		aParameter.getInfo().put("aParamSpDeviceLock", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobisclouddevicemanagementSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}
