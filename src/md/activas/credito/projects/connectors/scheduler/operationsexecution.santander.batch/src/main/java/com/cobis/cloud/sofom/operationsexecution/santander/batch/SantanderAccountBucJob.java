package com.cobis.cloud.sofom.operationsexecution.santander.batch;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobis.cloud.sofom.operationsexecution.santander.dto.ProcedureEntityRequestDTO;
import com.cobis.cloud.sofom.operationsexecution.santander.dto.ProcedureEntityResponseDTO;
import com.cobis.cloud.sofom.operationsexecution.santander.dto.SantanderAccountBucDTO;
import com.cobis.cloud.sofom.operationsexecution.santander.util.SPUtil;
import com.cobis.cloud.sofom.operationsexecution.santander.util.Util;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.security.ContextFactory;
import com.cobiscorp.cobis.cts.security.ServerManager;
import com.cobiscorp.cobis.cts.security.SessionManager;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.cts.services.orchestrator.IServiceOrchestrator;
import com.cobiscorp.cobis.cts.services.session.SessionCrypt;
import com.cobiscorp.cobis.scheduler.api.ICobisJob;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;

/**
 * @author srojas
 * 
 */
@Component
@Service({ ICobisJob.class })
@Properties(value = { @Property(name = "service.impl", value = "SantanderAccountBucJob") })
public class SantanderAccountBucJob implements ICobisJob {
	private static final ILogger LOGGER = LogFactory.getLogger(SantanderAccountBucJob.class);

	@Reference(name = "servOrchestator", referenceInterface = IServiceOrchestrator.class, bind = "setServOrchestator", unbind = "unSetServOrchestator", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IServiceOrchestrator servOrchestator;

	@Reference(name = "sessionManager1", referenceInterface = SessionManager.class, bind = "setSessionManager1", unbind = "unSetSessionManager1", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private SessionManager sessionManager1;

	@Reference(name = "serverManager", referenceInterface = ServerManager.class, bind = "setServerManager", unbind = "unSetServerManager", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ServerManager serverManager;

	@Reference(name = "contextFactory", referenceInterface = ContextFactory.class, bind = "setContextFactory", unbind = "unSetContextFactory", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ContextFactory contextFactory;

	@Reference(name = "spOrchestrator", referenceInterface = ISPOrchestrator.class, bind = "setSpOrchestrator", unbind = "unSetSpOrchestrator", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISPOrchestrator spOrchestrator;

	private static final String COLUMN_ENTITY_ID = "cbs_ente";
	private static final String COLUMN_PROCEDURE_NUMBER = "cbs_tramite";

	public void setServOrchestator(IServiceOrchestrator servOrchestator) {
		this.servOrchestator = servOrchestator;
	}

	public void unSetServOrchestator(IServiceOrchestrator servOrchestator) {
		this.servOrchestator = null;
	}

	public void setSessionManager1(SessionManager sessionManager1) {
		this.sessionManager1 = sessionManager1;
	}

	public void unSetSessionManager1(SessionManager sessionManager1) {
		this.sessionManager1 = null;
	}

	public void setServerManager(ServerManager serverManager) {
		this.serverManager = serverManager;
	}

	public void unSetServerManager(ServerManager serverManager) {
		this.serverManager = null;
	}

	public void setContextFactory(ContextFactory contextFactory) {
		this.contextFactory = contextFactory;
	}

	public void unSetContextFactory(ContextFactory contextFactory) {
		this.contextFactory = null;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

	public void unSetSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = null;
	}

	public void execute(Map map) {
		String ERROR_MESSAGE = "ERROR AL CONSULTAR EL SERVICIO PARA OBTENER EL BUC Y CUENTA SANTANDER";

		LOGGER.logInfo("Start job SantanderAccountBucJob");
		LOGGER.logDebug(map);
		/**
		 * Iterator it = map.entrySet().iterator(); while (it.hasNext()) { Map.Entry
		 * pair = (Map.Entry) it.next(); LOGGER.logInfo(pair.getKey() + " = " +
		 * pair.getValue()); //it.remove(); }
		 */
		String sessionId = (String) map.get(ICOBISTS.HEADER_SESSION_ID);
		String backendId = (String) map.get(ICOBISTS.HEADER_BACK_END_ID);
		LOGGER.logInfo("sessionIdMapa " + sessionId);

		String sessionDecrypt = SessionCrypt.decriptSessionID(sessionId, "address", "hostname");

		String contextId = Util.createContext(sessionDecrypt, backendId, sessionManager1, serverManager, contextFactory);
		String filter = (String) map.get(ICobisJob.FILTER_KEY);

		LOGGER.logInfo("filter " + filter);
		LOGGER.logInfo("contextId " + contextId);

		if (contextId == null || sessionId == null) {
			LOGGER.logError(ERROR_MESSAGE + " No se definió la sessión y/o el contexto.");
		} else {
			LOGGER.logInfo("Start job Santander");
			try {
				String returnMessages = getAccountAndBucFromSantander(sessionDecrypt, contextId, backendId);
				LOGGER.logInfo("Start job SantanderAccountBucJob despues");
				if (!"".equals(returnMessages)) {
					LOGGER.logInfo("Start job SantanderAccountBucJob returnMessages");
					LOGGER.logError(ERROR_MESSAGE + " (Retorno Servicio: " + returnMessages + ")");
				}
				LOGGER.logInfo("Start job SantanderAccountBucJob returnMessages despues");
			} catch (Exception e) {
				LOGGER.logError(ERROR_MESSAGE, e);
			}
		}
	}

	private String getAccountAndBucFromSantander(String sessionId, String contextId, String backendId) {
		LOGGER.logInfo("Start getAccountAndBucFromSantander");

		try {

			List<ProcedureEntityResponseDTO> procedureEntities = searchAccountBucIntents(sessionId, contextId, backendId);
			if (procedureEntities != null && procedureEntities.size() > 0) {

				for (ProcedureEntityResponseDTO procedureEntity : procedureEntities) {
					LOGGER.logDebug("Entra a validar Cuenta y Buc en Santander");
					SantanderAccountBucDTO santanderAccountAndBuc = validateAccountBucSantander(procedureEntity.getEntityId(), sessionId, contextId);

					ProcedureEntityRequestDTO procedureEntityRequest = new ProcedureEntityRequestDTO();

					procedureEntityRequest.setEntityId(procedureEntity.getEntityId());
					procedureEntityRequest.setProcedureNumber(procedureEntity.getProcedureNumber());
					LOGGER.logDebug("Entity Id: " + procedureEntity.getEntityId());
					LOGGER.logDebug("ProcedureNumber: " + procedureEntity.getProcedureNumber());

					procedureEntityRequest.setHasAccountAndBuc("N");

					if (santanderAccountAndBuc != null && santanderAccountAndBuc.getAccount() != null && santanderAccountAndBuc.getBuc() != null) {
						procedureEntityRequest.setHasAccountAndBuc("S");
					}

					updateAccountBucIntents(procedureEntityRequest, sessionId, contextId, backendId);

				}
			}
		} catch (Exception ex) {
			LOGGER.logError("Exception getAccountAndBucFromSantander: ", ex);
		}
		return "";
	}

	private List<ProcedureEntityResponseDTO> searchAccountBucIntents(String sessionId, String contextId, String backendId) throws Exception {

		// List<ProcedureEntityResponseDTO> procedureEntityResponse = new
		// ArrayList<ProcedureEntityResponseDTO>();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logInfo("Start searchAccountBucIntents");
		}
		List<ProcedureEntityResponseDTO> procedureEntityResponses = new ArrayList<ProcedureEntityResponseDTO>();
		try {

			String spName = "cob_credito..sp_santander_cuenta_buc_job";

			IProcedureRequest procReq = SPUtil.addHeaderToStoreProcedure(sessionId, contextId, backendId, spName, "211000");
			procReq.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "Q");

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Ejecutando sp: " + spName);
			}

			IProcedureResponse procedureResponse = spOrchestrator.execute(procReq, null, null);
			procedureEntityResponses = SPUtil.mapProcedureEntityResponse(procedureResponse, COLUMN_ENTITY_ID, COLUMN_PROCEDURE_NUMBER);

		} catch (Exception ex) {
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logInfo("Finish searchAccountBucIntents");
			}
		}
		return procedureEntityResponses;
	}

	private int updateAccountBucIntents(ProcedureEntityRequestDTO procedureEntity, String sessionId, String contextId, String backendId) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logInfo("Start updateAccountBucIntents");
		}
		try {
			String spName = "cob_credito..sp_santander_cuenta_buc_job";

			IProcedureRequest procReq = SPUtil.addHeaderToStoreProcedure(sessionId, contextId, backendId, spName, "211000");
			procReq.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "U");
			procReq.addInputParam("@i_ente", ICTSTypes.SQLINT4, String.valueOf(procedureEntity.getEntityId()));
			procReq.addInputParam("@i_tramite", ICTSTypes.SQLINT4, String.valueOf(procedureEntity.getProcedureNumber()));
			procReq.addInputParam("@i_tiene_cta_buc", ICTSTypes.SQLCHAR, String.valueOf(procedureEntity.getHasAccountAndBuc()));

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Ejecutando sp: " + spName);
			}

			IProcedureResponse procResp = spOrchestrator.execute(procReq, null, null);

			int returnCode = procResp.getReturnCode();
			LOGGER.logDebug("returnCode: " + returnCode);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logInfo("Finish updateAccountBucIntents");
			}
			return returnCode;
		} catch (Exception ex) {
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logInfo("Finish updateAccountBucIntents");
			}
		}
	}

	private SantanderAccountBucDTO validateAccountBucSantander(Integer customerId, String sessionId, String contextId) throws Exception {
		if (LOGGER.isDebugEnabled())
			LOGGER.logInfo("Start validateAccountBucSantander");

		try {

			OrchestrationClientValidationResponse orchestrationClientValidationResponse = SPUtil.executeService(customerId, sessionId, contextId, servOrchestator,
					"OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander", "inValidationProspectServiceRequest",
					"outOrchestrationClientValidationResponse");

			LOGGER.logDebug("orchestrationClientValidationResponse>>" + orchestrationClientValidationResponse);
			if (orchestrationClientValidationResponse != null && orchestrationClientValidationResponse.getCustomerCoreInfo() != null) {
				LOGGER.logDebug("Tiene respuesta Cuenta y Buc");
				LOGGER.logDebug("orchestrationClientValidationResponse.getCustomerCoreInfo()>>" + orchestrationClientValidationResponse.getCustomerCoreInfo());
				SantanderAccountBucDTO santanderAccountBucDTO = new SantanderAccountBucDTO();
				santanderAccountBucDTO.setAccount(orchestrationClientValidationResponse.getCustomerCoreInfo().getCustomerAccountId());
				santanderAccountBucDTO.setBuc(orchestrationClientValidationResponse.getCustomerCoreInfo().getBuc());
				return santanderAccountBucDTO;

			}

		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish validateAccountBucSantander");
		}
		return null;

	}

}
