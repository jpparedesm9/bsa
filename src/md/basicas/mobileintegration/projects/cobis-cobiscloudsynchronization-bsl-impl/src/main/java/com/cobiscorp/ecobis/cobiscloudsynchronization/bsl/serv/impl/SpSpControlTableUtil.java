/**
 * Archivo: SpSpControlTableUtil.java
 * Fecha..:
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.impl;

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


import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.Request;

public class SpSpControlTableUtil extends SpUtil {

    private static ILogger logger = LogFactory.getLogger(SpSpControlTableUtil.class);

    private SpSpControlTableUtil() {
        //private constructor because it is a class utility
    }

    /**
     * @name initializeSpControlTable
     * @desciption Inicializa el sp: cob_sincroniza..sp_tabla_control
     * @user
     * @param      aProcedureRequest
     *             aParameter
     * @return
     */
    private static void initializeSpControlTable(IProcedureRequest aProcedureRequest, Request aParameter) {

        String targetId = null;
        String database = "cob_sincroniza";
        String spName = "sp_tabla_control";

        initialize(aProcedureRequest, aParameter, database, spName, targetId);


        //Mapa donde viene los parametros de entrada
        Map wParameter = (Map) aParameter.getInfo().get("aParameter");
        Object wParameterValue;
        if (wParameter.containsKey("state")) {
            wParameterValue = wParameter.get("state");
            aProcedureRequest.addInputParam("@i_estado", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("idSync")) {
            wParameterValue = wParameter.get("idSync");
            aProcedureRequest.addInputParam("@i_id_sync", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("user")) {
            wParameterValue = wParameter.get("user");
            aProcedureRequest.addInputParam("@i_user", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("operation")) {
            wParameterValue = wParameter.get("operation");
            aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("syncDate")) {
            wParameterValue = wParameter.get("syncDate");
            aProcedureRequest.addInputParam("@i_fecha_sin", ICTSTypes.SQLDATETIME4, (wParameterValue == null) ? null : wParameterValue.toString());
        }
    }

    /**
     * @name executeSpControlTable
     * @desciption ejecuta el sp: cob_sincroniza..sp_tabla_control
     * @user
     * @param
     * @return
     */
    public static void executeSpControlTable(com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {
        String wInfo = "[cobiscloudsynchronization][executeSpControlTable]";
        if (logger.isDebugEnabled()) {
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudsynchronizationSERVImpl executeSpControlTable >>>>>>>>>>");
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudsynchronizationSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
            logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
        }

        IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

        initializeSpControlTable(wProcedureRequest, aParameter);
        IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

        evaluateResponseStatusSP(wProcedureResponse);

        List wLResult = SpUtil.getResultSets(wProcedureResponse);
        List wLParams = SpUtil.getParams(wProcedureResponse);

        aParameter.getInfo().put("statusCode", 0);

        aParameter.getInfo().put("aResultSpControlTable", wLResult);
        aParameter.getInfo().put("aParamSpControlTable", wLParams);


        if (logger.isDebugEnabled()) {
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudsynchronizationSERVImpl executeServiceCheck >>>>>>>>>>");
        }
    }


}

