/**
 * Archivo: SpInterfaceBuroUtil.java
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

public class SpInterfaceBuroUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpInterfaceBuroUtil.class);
  
  private SpInterfaceBuroUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeInterfaceBuro
     * @desciption Inicializa el sp: cob_credito..sp_interface_buro
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeInterfaceBuro(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cob_credito";
		String spName = "sp_interface_buro";
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);

		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("idCobis")) {
			wParameterValue = wParameter.get("idCobis");
			      aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
		if (wParameter.containsKey("date")) {
			wParameterValue = wParameter.get("date");
			      aProcedureRequest.addInputParam("@i_fecha", ICTSTypes.SQLDATETIME, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
		if (wParameter.containsKey("operationType")) {
			wParameterValue = wParameter.get("operationType");
			      aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
    
		if (wParameter.containsKey("riskScore")) {
			wParameterValue = wParameter.get("riskScore");
			      aProcedureRequest.addInputParam("@i_riesgo", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("folio")) {
			wParameterValue = wParameter.get("folio");
			      aProcedureRequest.addInputParam("@i_folio", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}    
		
		if (wParameter.containsKey("procedureNumber")) {
			wParameterValue = wParameter.get("procedureNumber");
			      aProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}   

		if (wParameter.containsKey("instProc")) {
			wParameterValue = wParameter.get("instProc");
			aProcedureRequest.addInputParam("@i_id_inst_proc", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("expirationDays")) {
			wParameterValue = wParameter.get("expirationDays");
			aProcedureRequest.addInputParam("@i_dias_caducidad", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}
		/*
		 * if (wParameter.containsKey("xml")) { wParameterValue =
		 * wParameter.get("xml"); aProcedureRequest.addInputParam("@i_xml",
		 * ICTSTypes.SQLVARBINARY, (wParameterValue == null ) ? null :
		 * wParameterValue.toString()); }
		 */
    
	}

    /**
     * @name       executeInterfaceBuro
     * @desciption ejecuta el sp: cob_credito..sp_interface_buro
     * @user       
     * @param      
     * @return
     */
	public static void executeInterfaceBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeInterfaceBuro]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeInterfaceBuro >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeInterfaceBuro(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);
		
		aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultInterfaceBuro", wLResult);
		aParameter.getInfo().put("aParamInterfaceBuro", wLParams);

		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	
}
