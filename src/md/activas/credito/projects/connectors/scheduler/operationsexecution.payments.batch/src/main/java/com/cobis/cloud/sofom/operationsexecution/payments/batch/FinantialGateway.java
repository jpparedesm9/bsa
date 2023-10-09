package com.cobis.cloud.sofom.operationsexecution.payments.batch;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.services.session.SessionCrypt;
import com.cobiscorp.cobis.scheduler.api.ICobisJob;

import java.util.Map;

public class FinantialGateway implements ICobisJob {
    private static final ILogger logger = LogFactory.getLogger(FinantialGateway.class);
    private ISPOrchestrator spOrchestrator;

    public ISPOrchestrator getSpOrchestrator() {
        return spOrchestrator;
    }

    public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
        this.spOrchestrator = spOrchestrator;
    }

    public void execute(Map map) {
        String ERROR_MESSAGE = "ERROR PROCESANDO PAGOS DE CORRESPONSALES";

        logger.logInfo("Start job FinantialGateway");

        String sessionId = String.valueOf(map.get("sessionId"));
        if (logger.isDebugEnabled()) {
            logger.logDebug("Job sessionId crypted: " + sessionId);
        }
        String sessionDecrypt = SessionCrypt.decriptSessionID(sessionId, "address", "hostname");

        try {
            int returnCode = processPayments(sessionDecrypt);
            if (returnCode != 0) {
                logger.logError(ERROR_MESSAGE + " (Retorno SP: " + returnCode + ")");
            }
        } catch (Exception e) {
            logger.logError(ERROR_MESSAGE, e);
        }
    }

    private int processPayments(String sessionId) {
        String spName = "cob_cartera..sp_pagos_corresponsal_batch";
        logger.logDebug("INGRESO processPayments: "+spName);

        IProcedureRequest procReq = new ProcedureRequestAS();
        procReq.setSpName(spName);
        procReq.addInputParam("@i_param1", ICTSTypes.SQLCHAR, "B");
        procReq.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
        
        logger.logDebug("SESSION ID TANQUEO: "+sessionId);
       
        procReq.addFieldInHeader(ICOBISTS.HEADER_TRN, ICOBISTS.HEADER_STRING_TYPE, "775071");
        
        if (logger.isDebugEnabled()) {
            logger.logDebug("Job sessionId decrypted: " + sessionId);
            logger.logDebug("Ejecutando sp: " + spName);
        }

        IProcedureResponse procResp = spOrchestrator.execute(procReq, null, null);

        int returnCode = procResp.getReturnCode();

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: " + returnCode);
        }

        return returnCode;
    }
}
