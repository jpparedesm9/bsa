/**
 * Archivo: SpCreditAmountRuleUtil.java
 * Fecha..: 
 * Autor..: 
 * Motivo.:caso #168293 Flujo de originación Auto onboarding
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

public class SpGenerateMatrixUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpIndividualRiskRuleUtil.class);

	private SpGenerateMatrixUtil() {
		// private constructor because it is a class utility
	}

	/**
	 * @name initializeIndividualRiskRule
	 * @desciption Inicializa el sp: cobis..sp_eje_regla_valid_cli
	 * @user
	 * @param aProcedureRequest aParameter
	 * @return
	 */
	private static void initializeGenerateMatriz(IProcedureRequest aProcedureRequest, Request aParameter) {

		String targetId = null;
		String database = "cobis";
		String spName = "sp_eje_regla_valid_cli";

		initialize(aProcedureRequest, aParameter, database, spName, targetId);

		// Mapa donde viene los parametros de entrada
		Map wParameter = (Map) aParameter.getInfo().get("aParameter");
		Object wParameterValue;

		if (wParameter.containsKey("clientId")) {
			wParameterValue = wParameter.get("clientId");
			aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("opcionId")) {
			wParameterValue = wParameter.get("opcionId");
			aProcedureRequest.addInputParam("@i_opcion", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("result")) {
			wParameterValue = wParameter.get("result");
			aProcedureRequest.addOutputParam("@o_continua", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
		}

	}

	/**
	 * @name executeIndividualRiskRule
	 * @desciption ejecuta el sp: cobis..sp_eje_regla_valid_cli
	 * @user
	 * @param
	 * @return
	 */
	public static void executeGenerateMatriz(com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {
		String wInfo = "[cobiscloudburo][executeIndividualRiskRule]";
		logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudburoSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo() + "-->>>aSpOrchestrator: " + aSpOrchestrator);

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

		initializeGenerateMatriz(wProcedureRequest, aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);

		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

		logger.logDebug(wInfo + "statusCode: " + wProcedureResponse.getReturnCode());
		logger.logDebug(wInfo + "aResultGenerateMatriz: " + wLResult);
		logger.logDebug(wInfo + "aParamGenerateMatriz: " + wLParams);

		aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		aParameter.getInfo().put("aResultGenerateMatriz", wLResult);
		aParameter.getInfo().put("aParamGenerateMatriz", wLParams);

	}

}
