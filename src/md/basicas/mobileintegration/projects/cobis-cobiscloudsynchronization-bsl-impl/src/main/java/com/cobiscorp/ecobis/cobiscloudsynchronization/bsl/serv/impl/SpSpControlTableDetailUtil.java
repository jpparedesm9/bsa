/**
 * Archivo: SpSpControlTableDetailUtil.java
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

public class SpSpControlTableDetailUtil extends SpUtil {

    private static ILogger logger = LogFactory.getLogger(SpSpControlTableDetailUtil.class);

    private SpSpControlTableDetailUtil() {
        //private constructor because it is a class utility
    }

    /**
     * @name initializeSpControlTableDetail
     * @desciption Inicializa el sp: cob_sincroniza..sp_sincroniza
     * @user
     * @param      aProcedureRequest
     *             aParameter
     * @return
     */
    private static void initializeSpControlTableDetail(IProcedureRequest aProcedureRequest, Request aParameter) {

        String targetId = null;
        String database = "cob_sincroniza";
        String spName = "sp_sincroniza";

        initialize(aProcedureRequest, aParameter, database, spName, targetId);


        //Mapa donde viene los parametros de entrada
        Map wParameter = (Map) aParameter.getInfo().get("aParameter");
        Object wParameterValue;
        if (wParameter.containsKey("id")) {
            wParameterValue = wParameter.get("id");
            aProcedureRequest.addInputParam("@i_id", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("operation")) {
            wParameterValue = wParameter.get("operation");
            aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("idSync")) {
            wParameterValue = wParameter.get("idSync");
            aProcedureRequest.addInputParam("@i_id_sync", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("page")) {
            wParameterValue = wParameter.get("page");
            aProcedureRequest.addInputParam("@i_page", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("perPage")) {
            wParameterValue = wParameter.get("perPage");
            aProcedureRequest.addInputParam("@i_page_size", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
        }
    }

    /**
     * @name executeSpControlTableDetail
     * @desciption ejecuta el sp: cob_sincroniza..sp_sincroniza
     * @user
     * @param
     * @return
     */
    public static void executeSpControlTableDetail(com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {
        String wInfo = "[cobiscloudsynchronization][executeSpControlTableDetail]";
        if (logger.isDebugEnabled()) {
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudsynchronizationSERVImpl executeSpControlTableDetail >>>>>>>>>>");
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudsynchronizationSERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
            logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
        }

        IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

        initializeSpControlTableDetail(wProcedureRequest, aParameter);
        IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

        evaluateResponseStatusSP(wProcedureResponse);

        List wLResult = SpUtil.getResultSets(wProcedureResponse);
        List wLParams = SpUtil.getParams(wProcedureResponse);

        aParameter.getInfo().put("statusCode", 0);

        aParameter.getInfo().put("aResultSpControlTableDetail", wLResult);
        aParameter.getInfo().put("aParamSpControlTableDetail", wLParams);


        if (logger.isDebugEnabled()) {
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudsynchronizationSERVImpl executeServiceCheck >>>>>>>>>>");
        }
    }


}

