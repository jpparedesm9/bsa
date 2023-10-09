package com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request;

import java.util.List;
import java.util.Map;

public class SpProductoSantanderUtil extends SpUtil {

    private static ILogger logger = LogFactory.getLogger(SpProductoSantanderUtil.class);

    private SpProductoSantanderUtil() {
        //private constructor because it is a class utility
    }

    /**
     * @param aProcedureRequest aParameter
     * @return
     * @name initializeSPProductoSantanderInfo
     * @desciption Inicializa el sp: cobis..sp_persona_upd
     * @user
     */
    private static void initializeSPProductoSantanderInfo(IProcedureRequest aProcedureRequest, Request aParameter) {

        String targetId = null;
        String database = "cob_credito";
        String spName = "sp_producto_santander";

        initialize(aProcedureRequest, aParameter, database, spName, targetId);


        //Mapa donde viene los parametros de entrada
        Map wParameter = (Map) aParameter.getInfo().get("aParameter");
        Object wParameterValue;

        if (wParameter.containsKey("customerId")) {
            wParameterValue = wParameter.get("customerId");
            aProcedureRequest.addInputParam("@i_ente", ICTSTypes.SQLINT4, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("buc")) {
            wParameterValue = wParameter.get("buc");
            aProcedureRequest.addInputParam("@i_buc", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("contractNumber")) {
            wParameterValue = wParameter.get("contractNumber");
            aProcedureRequest.addInputParam("@i_numero_contrato", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("productId")) {
            wParameterValue = wParameter.get("productId");
            aProcedureRequest.addInputParam("@i_codigo_producto", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("subproductId")) {
            wParameterValue = wParameter.get("subproductId");
            aProcedureRequest.addInputParam("@i_codigo_subproducto", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("status")) {
            wParameterValue = wParameter.get("status");
            aProcedureRequest.addInputParam("@i_estado", ICTSTypes.SQLCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }

        if (wParameter.containsKey("currencyCode")) {
            wParameterValue = wParameter.get("currencyCode");
            aProcedureRequest.addInputParam("@i_codigo_moneda", ICTSTypes.SQLVARCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }


        if (wParameter.containsKey("operation")) {
            wParameterValue = wParameter.get("operation");
            aProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, (wParameterValue == null) ? null : wParameterValue.toString());
        }
        logger.logDebug("<<<<<<<<<< initializeSPProductoSantanderInfo >>>>>>>>>>" + wParameter);


    }

    /**
     * @param
     * @return
     * @name executeSPProductoSantanderInfo
     * @desciption ejecuta el sp: cob_credito..sp_producto_santander
     * @user
     */
    public static void executeSPProductoSantanderInfo(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Request aParameter, ISPOrchestrator aSpOrchestrator) {
        String wInfo = "[cobiscloudparty][executeSPProductoSantanderInfo]";
        if (logger.isDebugEnabled()) {
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeSPProductoSantanderInfo >>>>>>>>>>");
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl aRequest parameter >>>>>>>>>> " + aParameter.getInfo());
            logger.logDebug(wInfo + "<<<<<<<<<< it arrives ok with >>>>>>>>>>" + aSpOrchestrator);
        }

        IProcedureRequest wProcedureRequest = new ProcedureRequestAS();

        initializeSPProductoSantanderInfo(wProcedureRequest, aParameter);
        IProcedureResponse wProcedureResponse = executeProcedure(wProcedureRequest, aSpOrchestrator);

        evaluateResponseStatusSP(wProcedureResponse);

        List wLResult = SpUtil.getResultSets(wProcedureResponse);
        List wLParams = SpUtil.getParams(wProcedureResponse);

        aParameter.getInfo().put("statusCode", wProcedureResponse.getReturnCode());

        aParameter.getInfo().put("aResultSPProductoSantanderInfo", wLResult);
        aParameter.getInfo().put("aParamSPProductoSantanderInfo", wLParams);


        if (logger.isDebugEnabled()) {
            logger.logDebug(wInfo + "<<<<<<<<<< cobiscloudpartySERVImpl executeServiceCheck >>>>>>>>>>");
        }
    }
}
