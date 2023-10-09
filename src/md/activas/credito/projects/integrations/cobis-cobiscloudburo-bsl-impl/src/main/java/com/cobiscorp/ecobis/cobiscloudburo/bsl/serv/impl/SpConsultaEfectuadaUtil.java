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
import com.cobiscorp.cobis.cts.domains.IResponseBlock;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;


import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request;

public class SpConsultaEfectuadaUtil extends SpUtil {
	private static ILogger logger = LogFactory.getLogger(SpConsultaEfectuadaUtil.class);
	  
	  private SpConsultaEfectuadaUtil() {
	    //private constructor because it is a class utility
	  }
	  
	  /**
	     * @name       initializeConsultaEfectuada
	     * @desciption Inicializa el sp: cob_credito..sp_consulta_buro
	     * @user       
	     * @param      aProcedureRequest
		 *             aParameter
	     * @return
	     */
	  private static void initializeConsultaEfectuada(IProcedureRequest aProcedureRequest, Request aParameter){
			
			String targetId = null;
			String database = "cob_credito";
			String spName = "sp_consulta_buro";
			
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
			
			if (wParameter.containsKey("fechaConsulta")) {
				wParameterValue = wParameter.get("fechaConsulta");
	            aProcedureRequest.addInputParam("@i_fecha_consulta", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("identificacionBuro")) {
				wParameterValue = wParameter.get("identificacionBuro");
	            aProcedureRequest.addInputParam("@i_identificacion_buro", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("claveOtorgante")) {
				wParameterValue = wParameter.get("claveOtorgante");
	            aProcedureRequest.addInputParam("@i_clave_otorgante", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("nombreOtorgante")) {
				wParameterValue = wParameter.get("nombreOtorgante");
	            aProcedureRequest.addInputParam("@i_nombre_otorgante", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("telefonoOtorgante")) {
				wParameterValue = wParameter.get("telefonoOtorgante");
	            aProcedureRequest.addInputParam("@i_telefono_otorgante", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("tipoContrato")) {
				wParameterValue = wParameter.get("tipoContrato");
	            aProcedureRequest.addInputParam("@i_tipo_contrato", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("claveUnidadMonetaria")) {
				wParameterValue = wParameter.get("claveUnidadMonetaria");
	            aProcedureRequest.addInputParam("@i_clave_monetaria", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("importeContrato")) {
				wParameterValue = wParameter.get("importeContrato");
	            aProcedureRequest.addInputParam("@i_importe_contrato", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("indicadorTipoResponsabilidad")) {
				wParameterValue = wParameter.get("indicadorTipoResponsabilidad");
	            aProcedureRequest.addInputParam("@i_ind_tipo_responsa", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("consumidorNuevo")) {
				wParameterValue = wParameter.get("consumidorNuevo");
	            aProcedureRequest.addInputParam("@i_consumidor_nuevo", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("resultadoFinal")) {
				wParameterValue = wParameter.get("resultadoFinal");
	            aProcedureRequest.addInputParam("@i_resultado_final", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}
			
			if (wParameter.containsKey("identificadorOrigenConsulta")) {
				wParameterValue = wParameter.get("identificadorOrigenConsulta");
	            aProcedureRequest.addInputParam("@i_identificador_cons", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
			}		
		}
	  
	  /**
	     * @name       executeConsultaBuro
	     * @desciption ejecuta el sp: cob_credito..sp_consulta_buro
	     * @user       
	     * @param      
	     * @return
	     */
		public static void executeConsultaBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
			String wInfo = "[cobiscloudburo][executeConsultaBuro]";		
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeCuentaBuro >>>>>>>>>>");
				logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
				logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
			}

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
			
			initializeConsultaEfectuada(wProcedureRequest,aParameter);
			IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

			evaluateResponseStatusSP(wProcedureResponse);
				
			List wLResult = SpUtil.getResultSets(wProcedureResponse);
			List wLParams = SpUtil.getParams(wProcedureResponse);

	    aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
			
			aParameter.getInfo().put("aResultCuentaBuro", wLResult);
			aParameter.getInfo().put("aParamCuentaBuro", wLParams);

			
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
			}
		}
		
}
