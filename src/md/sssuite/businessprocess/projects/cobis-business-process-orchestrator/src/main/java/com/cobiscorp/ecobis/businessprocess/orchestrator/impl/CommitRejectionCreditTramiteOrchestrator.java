package com.cobiscorp.ecobis.businessprocess.orchestrator.impl;

import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.cis.sp.java.orchestration.CISResponseManagmentHelper;
import com.cobiscorp.cobis.cis.sp.java.orchestration.ICISSPBaseOrchestration;
import com.cobiscorp.cobis.cis.sp.java.orchestration.SPJavaOrchestrationBase;
import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.csp.domains.ICSP;
import com.cobiscorp.cobis.csp.services.inproc.IOrchestrator;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;

@Component(name = "CommitRejectionCreditTramiteOrchestrator", immediate = false)
@Service(value = { ICISSPBaseOrchestration.class, IOrchestrator.class })
@Properties(value = { @Property(name = "service.description", value = "CommitRejectionCreditTramiteOrchestrator"),
		@Property(name = "service.vendor", value = "COBISCORP"), @Property(name = "service.version", value = "1.0.0"),
		@Property(name = "service.identifier", value = "CommitRejectionCreditTramiteOrchestrator"),
		@Property(name = "service.spName", value = "cob_procesador..commitRejectionCreditTramite") })
public class CommitRejectionCreditTramiteOrchestrator extends SPJavaOrchestrationBase {

	private static final String AN_ORIGINAL_REQUEST = "anOriginalRequest";
	private static final String STEP_ONE_RESPONSE = "stepOneResponse";
	private static final String COB_CREDITO_SP_RECHAZO = "cob_credito..sp_rechazo";

	private final ILogger LOGGER = this.getLogger();

	@Override
	public void loadConfiguration(IConfigurationReader arg0) {

	}

	@Override
	public IProcedureResponse executeJavaOrchestration(IProcedureRequest anOriginalRequest, Map<String, Object> aBagSPJavaOrchestration) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Starting commitDisbursement orchestration (@i_tramite = " + anOriginalRequest.readValueParam("@i_tramite") + ")");
			LOGGER.logDebug("Starting commitDisbursement orchestration (@i_observaciones = " + anOriginalRequest.readValueParam("@i_observaciones")
					+ ")");
		}

		aBagSPJavaOrchestration.put(AN_ORIGINAL_REQUEST, anOriginalRequest);

		// 1 execute cob_credito..sp_rechazo
		if (deleteTmpTables(aBagSPJavaOrchestration)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("CommitDisbursement orchestration Step two --> deleting temporal tables ");
			}
			return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finishing CommitDisbursement orchestration");
		}
		return processResponse(anOriginalRequest, aBagSPJavaOrchestration);
	}

	@Override
	public IProcedureResponse processResponse(IProcedureRequest anOriginalProcedureReq, Map<String, Object> aBagSPJavaOrchestration) {

		IProcedureResponse wProcedureRespFinal = (initProcedureResponse(anOriginalProcedureReq));
		String[] wAllProcedureResponse = { STEP_ONE_RESPONSE };
		CISResponseManagmentHelper.addOutputParamsResponseS(wProcedureRespFinal, anOriginalProcedureReq, wAllProcedureResponse,
				aBagSPJavaOrchestration);
		CISResponseManagmentHelper.addResultsetsResponseS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);

		IProcedureResponse wProcedureResponseStepTwo = (IProcedureResponse) aBagSPJavaOrchestration.get(STEP_ONE_RESPONSE);
		if (wProcedureResponseStepTwo != null && wProcedureResponseStepTwo.getMessageListSize() != 0) {
			CISResponseManagmentHelper.addMessagesS(wProcedureRespFinal, wAllProcedureResponse, aBagSPJavaOrchestration);
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.ERROR_EXECUTION_SERVICE);
		} else {
			wProcedureRespFinal.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		}
		return wProcedureRespFinal;

	}

	private boolean deleteTmpTables(Map<String, Object> aBagSPJavaOrchestration) {
		IProcedureRequest wOriginalRequest = ((IProcedureRequest) (aBagSPJavaOrchestration.get(AN_ORIGINAL_REQUEST)));
		IProcedureRequest wProcedureRequest = (initProcedureRequest(wOriginalRequest));
		wProcedureRequest.setSpName(COB_CREDITO_SP_RECHAZO);
		wProcedureRequest.setValueFieldInHeader(ICOBISTS.HEADER_TRN, "0");
		wProcedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, wOriginalRequest.readValueParam("@i_tramite"));
		wProcedureRequest.addInputParam("@i_observaciones", ICTSTypes.SQLVARCHAR, wOriginalRequest.readValueParam("@i_observaciones"));
		wProcedureRequest.addInputParam("@t_trn", ICTSTypes.SQLINT4, "21829");
		IProcedureResponse wProcedureResponse = executeCoreBanking(wProcedureRequest);
		aBagSPJavaOrchestration.put(STEP_ONE_RESPONSE, wProcedureResponse);
		return wProcedureResponse.hasError();
	}

}
