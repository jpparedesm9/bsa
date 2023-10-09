package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.bsl.Version;
import com.cobiscorp.cobis.assts.customevents.servlet.MainServlet;
import com.cobiscorp.cobis.assts.model.QueryDocumentHistory;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SearchDocumentsHistorical extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocumentsHistorical.class);

	public SearchDocumentsHistorical(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug("Ingreso executeQuery SearchDocumentsHistorical");

		DataEntityList lista = new DataEntityList();
		// QueryDocumentsRequest queryDocuments = new QueryDocumentsRequest();

		// FilesUtilClass filesUtilClass = new FilesUtilClass();
		// String session = filesUtilClass.getSession(request);
		String session = SessionManager.getSessionId();
		try {
			LOGGER.logDebug("data: " + arg0.getData().toString());

			String groupId = null;
			String processInstance = null;
			String folder = null;
			String description = null;
			String documentId = null;
			String extension = null;
			String customerId = null;

			// Seteo de campos

			if (arg0.getData() != null) {
				if (arg0.getData().get("processInstance") != null) {
					processInstance = arg0.getData().get("processInstance").toString();
				}
				if (arg0.getData().get("customerId") != null) {
					customerId = arg0.getData().get("customerId").toString();
				}
				if (arg0.getData().get("groupId") != null) {
					groupId = arg0.getData().get("groupId").toString();
				}
				if (arg0.getData().get("description") != null) {
					description = (String) arg0.getData().get("description");
				}
				if (arg0.getData().get("documentId") != null) {
					documentId = (String) arg0.getData().get("documentId");
				}
				if (arg0.getData().get("extension") != null) {
					extension = (String) arg0.getData().get("extension");
				}
				if (arg0.getData().get("folder") != null) {
					folder = (String) arg0.getData().get("folder");
				}

				LOGGER.logDebug("processInst: " + processInstance);
				LOGGER.logDebug("clientId: " + customerId);
				LOGGER.logDebug("groupId: " + groupId);
				LOGGER.logDebug("description: " + description);
				LOGGER.logDebug("documentId: " + documentId);
				LOGGER.logDebug("extension: " + extension);
				LOGGER.logDebug("folder: " + folder);

				LOGGER.logDebug("--------------->>> Inicia busqueda de Historial de Documentos");
				List<Version> versiones = null;
				if (folder.equals("Customer")) {
					LOGGER.logDebug("---->> Inicia Customer");
					if (("0".equals(processInstance)) && ("0".equals(groupId))) {
						versiones = MainServlet.getVersionsHistorical(session, folder, customerId, (folder == null ? "" : folder) + "/" + (customerId == null ? "" : customerId)
								+ "/" + (documentId == null ? "" : documentId) + "." + (extension == null ? "" : extension), this.getServiceIntegration());
					} else if ((!"0".equals(processInstance)) && (!"0".equals(groupId)) && (!"0".equals(customerId))) {
						versiones = MainServlet.getVersionsHistorical(session, folder, customerId, (folder == null ? "" : folder) + "/" + (groupId == null ? "" : groupId) + "/"
								+ (processInstance == null ? "" : processInstance) + "/" + (customerId == null ? "" : customerId) + "/" + (documentId == null ? "" : documentId)
								+ "." + (extension == null ? "" : extension), this.getServiceIntegration());
					}

					LOGGER.logDebug("---->> Termina Customer");
				} else if ("Inbox".equals(folder)) {
					LOGGER.logDebug("---->> Inicia Inbox");
					versiones = MainServlet.getVersionsHistorical(session, folder, processInstance, (folder == null ? "" : folder) + "/"
							+ (processInstance == null ? "" : processInstance) + "/" + (extension == null ? "" : extension), this.getServiceIntegration());
					LOGGER.logDebug("---->> Termina Inbox");
				}

				if (versiones != null) {
					LOGGER.logDebug("Entra a scannedDocumentsResponses");
					for (Version documents : versiones) {
						DataEntity documentos = new DataEntity();
						documentos.set(QueryDocumentHistory.DESCRIPTION, description);
						documentos.set(QueryDocumentHistory.UPLOADED, 'S');
						if (customerId != null) {
							documentos.set(QueryDocumentHistory.CUSTOMERID, Integer.parseInt(customerId));
						}
						documentos.set(QueryDocumentHistory.DOCUMENTID, documentId);
						if (processInstance != null) {
							documentos.set(QueryDocumentHistory.PROCESSINSTANCE, Integer.parseInt(processInstance));
						}
						if (groupId != null) {
							documentos.set(QueryDocumentHistory.GROUPID, Integer.parseInt(groupId));
						}
						documentos.set(QueryDocumentHistory.EXTENSION, extension);
						documentos.set(QueryDocumentHistory.FOLDER, folder);
						/* Versiones */
						documentos.set(QueryDocumentHistory.DOCUMENTVERSION, documents.getVersion());
						documentos.set(QueryDocumentHistory.DATEVERSION, documents.getDate());

						LOGGER.logDebug("documents.getVersion()" + documents.getVersion());
						LOGGER.logDebug("documents.getDate()" + documents.getDate());

						LOGGER.logDebug("documents DESCRIPTION: " + documentos.get(QueryDocumentHistory.DESCRIPTION));
						LOGGER.logDebug("documents EXTENSION: " + documentos.get(QueryDocumentHistory.EXTENSION));

						lista.add(documentos);
						// LOGGER.logDebug("Documento: "+documents.getDocumentId());
					}
				}
			}
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los datos del grupo-->", e);
		}
		return lista.getDataList();

	}
}
