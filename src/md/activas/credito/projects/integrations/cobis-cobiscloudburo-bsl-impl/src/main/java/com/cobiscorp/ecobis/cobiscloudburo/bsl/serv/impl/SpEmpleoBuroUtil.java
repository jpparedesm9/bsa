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

public class SpEmpleoBuroUtil extends SpUtil{
	private static ILogger logger = LogFactory.getLogger(SpEmpleoBuroUtil.class);
	
	private SpEmpleoBuroUtil() {
	    //private constructor because it is a class utility
	  }
	/**
     * @name       initializeInterfaceBuro
     * @desciption Inicializa el sp: cob_credito..sp_empleo_buro
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
  private static void initializeEmpleoBuro(IProcedureRequest aProcedureRequest, Request aParameter){
	    String targetId = null;
		String database = "cob_credito";
		String spName = "sp_empleo_buro";
		
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
		
		if (wParameter.containsKey("nombreEmpresa")) {
			wParameterValue = wParameter.get("nombreEmpresa");
            aProcedureRequest.addInputParam("@i_nombre_empresa", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("direccionUno")) {
			wParameterValue = wParameter.get("direccionUno");
            aProcedureRequest.addInputParam("@i_direccion_uno", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("direccionDos")) {
			wParameterValue = wParameter.get("direccionDos");
            aProcedureRequest.addInputParam("@i_direccion_dos", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("coloniaPoblacion")) {
			wParameterValue = wParameter.get("coloniaPoblacion");
            aProcedureRequest.addInputParam("@i_colonia", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("delegacionMunicipio")) {
			wParameterValue = wParameter.get("delegacionMunicipio");
            aProcedureRequest.addInputParam("@i_delegacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("ciudad")) {
			wParameterValue = wParameter.get("ciudad");
            aProcedureRequest.addInputParam("@i_ciudad", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("estado")) {
			wParameterValue = wParameter.get("estado");
            aProcedureRequest.addInputParam("@i_estado", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("codigoPostal")) {
			wParameterValue = wParameter.get("codigoPostal");
            aProcedureRequest.addInputParam("@i_codigo_postal", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("numeroTelefono")) {
			wParameterValue = wParameter.get("numeroTelefono");
            aProcedureRequest.addInputParam("@i_numero_telefono", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("extension")) {
			wParameterValue = wParameter.get("extension");
            aProcedureRequest.addInputParam("@i_extension", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("fax")) {
			wParameterValue = wParameter.get("fax");
            aProcedureRequest.addInputParam("@i_fax", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	
		if (wParameter.containsKey("cargo")) {
			wParameterValue = wParameter.get("cargo");
            aProcedureRequest.addInputParam("@i_cargo", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("fechaContratacion")) {
			wParameterValue = wParameter.get("fechaContratacion");
            aProcedureRequest.addInputParam("@i_fecha_contratacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("claveMoneda")) {
			wParameterValue = wParameter.get("claveMoneda");
            aProcedureRequest.addInputParam("@i_clave_moneda", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("salario")) {
			wParameterValue = wParameter.get("salario");
            aProcedureRequest.addInputParam("@i_salario", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("baseSalarial")) {
			wParameterValue = wParameter.get("baseSalarial");
            aProcedureRequest.addInputParam("@i_base_salarial", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("numeroEmpleado")) {
			wParameterValue = wParameter.get("numeroEmpleado");
            aProcedureRequest.addInputParam("@i_num_empleado", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("fechaUltimoDiaEmpleo")) {
			wParameterValue = wParameter.get("fechaUltimoDiaEmpleo");
            aProcedureRequest.addInputParam("@i_fecha_ult_dia", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("fechaReportoEmpleo")) {
			wParameterValue = wParameter.get("fechaReportoEmpleo");
            aProcedureRequest.addInputParam("@i_fecha_reporto_empl", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("fechaVerificacionEmpleo")) {
			wParameterValue = wParameter.get("fechaVerificacionEmpleo");
            aProcedureRequest.addInputParam("@i_fecha_verificacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("modoVerificacion")) {
			wParameterValue = wParameter.get("modoVerificacion");
            aProcedureRequest.addInputParam("@i_modo_verificacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("codigoPais")) {
			wParameterValue = wParameter.get("codigoPais");
            aProcedureRequest.addInputParam("@i_codigo_pais", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
  }
  
  /**
   * @name       executeCuentaBuro
   * @desciption ejecuta el sp: cob_credito..sp_empleo_buro
   * @user       
   * @param      
   * @return
   */
	public static void executeEmpleoBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeEmpleoBuro]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeEmpleoBuro >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeEmpleoBuro(wProcedureRequest,aParameter);
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
