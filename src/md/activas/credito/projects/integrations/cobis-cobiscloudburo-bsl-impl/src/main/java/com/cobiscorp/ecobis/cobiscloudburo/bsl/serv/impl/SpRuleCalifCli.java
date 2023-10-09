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

public class SpRuleCalifCli extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpRuleCalifCli.class);

	private SpRuleCalifCli() {
		// private constructor because it is a class utility
	}

	/**
	 * @name SpInterfaceRule
	 * @desciption Inicializa el sp: cob_credito..sp_eje_regla_calif_cli
	 * @user
	 * @param aProcedureRequest aParameter
	 * @return
	 */
	private static void initializeRuleCalifCli(IProcedureRequest aProcedureRequest, Request aParameter) {

		String targetId = null;
		String database = "cob_credito";
		String spName = "sp_eje_regla_calif_cli";

		initialize(aProcedureRequest, aParameter, database, spName, targetId);

		// Mapa donde viene los parametros de entrada
		Map wParameter = (Map) aParameter.getInfo().get("aParameter");
		Object wParameterValue;

		if (wParameter.containsKey("idCobis")) {
			wParameterValue = wParameter.get("idCobis");
			aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("idRule")) {
			wParameterValue = wParameter.get("idRule");
			aProcedureRequest.addInputParam("@i_regla", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("idChannel")) {
			wParameterValue = wParameter.get("idChannel");
			aProcedureRequest.addInputParam("@i_canal", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("typeRatingCustomerEvaluation")) {
			wParameterValue = wParameter.get("typeRatingCustomerEvaluation");
			aProcedureRequest.addInputParam("@i_tipo_calif_eva_cli", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("validityBureauDays")) {
			wParameterValue = wParameter.get("validityBureauDays");
			aProcedureRequest.addInputParam("@i_dias_vig_buro", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("evaluateRule")) {
			wParameterValue = wParameter.get("evaluateRule");
			aProcedureRequest.addInputParam("@i_evaluar_reglas", ICTSTypes.SQLCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}
		
		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_nivel_riesgo_1", ICTSTypes.SQLCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_nivel_riesgo_2", ICTSTypes.SQLCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_color", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_letra", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}
		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_vigencia", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_tipo_calif", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}
	}

	/**
	 * @name SpInterfaceRule
	 * @desciption ejecuta el sp: cob_credito..sp_eje_regla_calif_cli
	 * @user
	 * @param
	 * @return
	 */

	public static void executeRuleCalifCli(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {
		String wInfo = "[SpInterfaceRule][executeRuleCalifCli]";
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< SpInterfaceRule executeRuleCalifCli >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< SpInterfaceRule aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

		initializeRuleCalifCli(wProcedureRequest, aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);

		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

		logger.logDebug(wInfo + "statusCode: " + wProcedureResponse.getReturnCode());
		logger.logDebug(wInfo + "aResultQualificationBureauRule: " + wLResult);
		logger.logDebug(wInfo + "aParamQualificationBureauRule: " + wLParams);
		
		aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		aParameter.getInfo().put("aResultRuleCalifCli", wLResult);
		aParameter.getInfo().put("aParamRuleCalifCli", wLParams);

		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}

}
