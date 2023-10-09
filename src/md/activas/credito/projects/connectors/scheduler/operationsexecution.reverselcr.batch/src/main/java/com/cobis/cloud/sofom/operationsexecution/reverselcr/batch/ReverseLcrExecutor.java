package com.cobis.cloud.sofom.operationsexecution.reverselcr.batch;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.services.session.SessionCrypt;
import com.cobiscorp.cobis.scheduler.api.ICobisJob;

public class ReverseLcrExecutor implements ICobisJob {
	private static final ILogger logger = LogFactory.getLogger(ReverseLcrExecutor.class);
	private ISPOrchestrator spOrchestrator;

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

	@SuppressWarnings("rawtypes")
	public void execute(Map map) {
		String ERROR_MESSAGE = "ERROR PROCESANDO DESEMBOLSOS LCR";

		logger.logInfo("Start job ReverseLcrExecutor");

		String sessionId = String.valueOf(map.get("sessionId"));
		String sessionDecrypt = SessionCrypt.decriptSessionID(sessionId, "address", "hostname");
		try {
			int returnCode = processSynchronization(sessionDecrypt);
			if (returnCode != 0) {
				logger.logError(ERROR_MESSAGE + " (Retorno SP: " + returnCode + ")");
			}
		} catch (Exception e) {
			logger.logError(ERROR_MESSAGE, e);
		}
	}

	private int processSynchronization(String sessionId) {
		String spName = "cob_cartera..sp_lcr_resp_desembolso";
		if (logger.isDebugEnabled()) {
			logger.logDebug("=========> Ejecutando sp: " + spName);
		}

		IProcedureRequest procReq = new ProcedureRequestAS();
		procReq.setSpName(spName);
        procReq.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
        procReq.addFieldInHeader(ICOBISTS.HEADER_TRN, ICOBISTS.HEADER_STRING_TYPE, "77511");

		if (logger.isDebugEnabled()) {
			logger.logDebug("=========> Session id: " + sessionId);
		}

		IProcedureResponse procResp = spOrchestrator.execute(procReq, null, null);

		int returnCode = procResp.getReturnCode();

		if (logger.isDebugEnabled()) {
			logger.logDebug("Codigo de retorno de sp: " + returnCode);
		}

		return returnCode;
	}
}
