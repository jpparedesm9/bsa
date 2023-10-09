/**
 * Archivo: SpSPCustomerBuroUtil.java
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

public class SpSPCustomerBuroUtil extends SpUtil {

	private static ILogger logger = LogFactory.getLogger(SpSPCustomerBuroUtil.class);
  
  private SpSPCustomerBuroUtil() {
    //private constructor because it is a class utility
  }

   /**
     * @name       initializeSPCustomerBuro
     * @desciption Inicializa el sp: cobis..sp_info_cliente_buro
     * @user       
     * @param      aProcedureRequest
	 *             aParameter
     * @return
     */
	private static void initializeSPCustomerBuro(IProcedureRequest aProcedureRequest, Request aParameter){
		
		String targetId = null;
		String database = "cobis";
		String spName = "sp_info_cliente_buro";//PNV
		
		initialize(aProcedureRequest, aParameter, database, spName, targetId);


		//Mapa donde viene los parametros de entrada
		Map wParameter = (Map)aParameter.getInfo().get("aParameter");
		Object wParameterValue;
		if (wParameter.containsKey("idCustomer")) {
			wParameterValue = wParameter.get("idCustomer");
			aProcedureRequest.addInputParam("@i_codigo_cliente", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("operation")) {
			wParameterValue = wParameter.get("operation");
			aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		if (wParameter.containsKey("subType")) {
			wParameterValue = wParameter.get("subType");
			aProcedureRequest.addInputParam("@i_sub_tipo", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		// Para que retorne X o N en lugar de  Ñ
		if (wParameter.containsKey("validateLetterN")) {
			wParameterValue = wParameter.get("validateLetterN");
			aProcedureRequest.addInputParam("@i_tipo_para_n", ICTSTypes.SQLVARCHAR, (wParameterValue == null ) ? null : wParameterValue.toString());
		}

		// caso#203112
		if (wParameter.containsKey("daysValidity")) {
			wParameterValue = wParameter.get("daysValidity");
			aProcedureRequest.addInputParam("@i_dias_vigencia", ICTSTypes.SQLINT4, (wParameterValue == null ) ? null : wParameterValue.toString());
		}
	}

    /**
     * @name       executeSPCustomerBuro
     * @desciption ejecuta el sp: cobis..sp_info_cliente_buro
     * @user       
     * @param      
     * @return
     */
	public static void executeSPCustomerBuro(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {	
		String wInfo = "[cobiscloudparty][executeSPCustomerBuro]";		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeSPCustomerBuro >>>>>>>>>>");
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
			logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
		}

		IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
		
		initializeSPCustomerBuro(wProcedureRequest,aParameter);
		IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

		evaluateResponseStatusSP(wProcedureResponse);
			
		List wLResult = SpUtil.getResultSets(wProcedureResponse);
		List wLParams = SpUtil.getParams(wProcedureResponse);

        aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());
		
		aParameter.getInfo().put("aResultSPCustomerBuro", wLResult);
		aParameter.getInfo().put("aParamSPCustomerBuro", wLParams);

		
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeServiceCheck >>>>>>>>>>");
		}
	}
	

}

