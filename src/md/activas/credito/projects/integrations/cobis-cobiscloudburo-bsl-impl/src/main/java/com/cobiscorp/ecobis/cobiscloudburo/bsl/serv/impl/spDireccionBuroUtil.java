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

public class spDireccionBuroUtil extends SpUtil {
     private static ILogger logger = LogFactory.getLogger(spDireccionBuroUtil.class);
	
	private spDireccionBuroUtil() {
	    //private constructor because it is a class utility
	  }
	/**
     * @name       initializeInterfaceBuro
     * @desciption Inicializa el sp: cob_credito..sp_domicilio_buro
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeDireccionBuro(IProcedureRequest aProcedureRequest, Request aParameter){
	    String targetId = null;
		String database = "cob_credito";
		String spName = "sp_domicilio_buro";
		
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
            aProcedureRequest.addInputParam("@i_cliente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
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
            aProcedureRequest.addInputParam("@i_num_telefono", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("tipoDomicilio")) {
			wParameterValue = wParameter.get("tipoDomicilio");
            aProcedureRequest.addInputParam("@i_tipo_domicilio", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("indicadorEspecialDomicilio")) {
			wParameterValue = wParameter.get("indicadorEspecialDomicilio");
            aProcedureRequest.addInputParam("@i_indicador_especial", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("codPais")) {
			wParameterValue = wParameter.get("codPais");
            aProcedureRequest.addInputParam("@i_codigo_pais", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("fechaReporteDireccion")) {
			wParameterValue = wParameter.get("fechaReporteDireccion");
            aProcedureRequest.addInputParam("@i_fecha_reporte", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
		if (wParameter.containsKey("ciudad")) {
			wParameterValue = wParameter.get("ciudad");
            aProcedureRequest.addInputParam("@i_ciudad", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}	
	 }
	
	/**
	   * @name       executeCuentaBuro
	   * @desciption ejecuta el sp: cob_credito..sp_domicilio_buro
	   * @user       
	   * @param      
	   * @return
	   */
	public static void executeDireccionBuro(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudburo][executeDireccionBuro]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeDireccionBuro >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeDireccionBuro(wProcedureRequest,aParameter);
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
