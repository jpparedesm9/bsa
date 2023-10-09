package com.cobiscorp.cobis.cstmr.events;

//import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.ScannedDocumentsDetail;
import com.cobiscorp.cobis.cstmr.services.Documents;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IGridRowCommand;
import com.cobiscorp.designer.api.customization.arguments.IGridRowCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class UploadDocuments extends BaseEvent implements IGridRowCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UploadDocuments.class);

	public UploadDocuments(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeRowCommad(DataEntity entities, IGridRowCommandEventArgs arg1) {

		LOGGER.logDebug("Ingreso a la actualizacion de documentos");
		LOGGER.logDebug("entra");
		ScannedDocumentsRequest documentsRequest = new ScannedDocumentsRequest();
		LOGGER.logDebug("getSession: " + SessionManager.getSession().toString());
		String pathFile = SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH).toString();

		try {
			// Seteo de campos
			int transactionType = 0; // Este valor se usa para especificar la ruta en la que se va subir el archivo
			String extension = pathFile.substring(pathFile.lastIndexOf('.') + 1);
			LOGGER.logDebug("extension: " + extension);
			documentsRequest.setCustomerId(entities.get(ScannedDocumentsDetail.CUSTOMERID));
			documentsRequest.setGroupId(0);// Es 0 porq clientes individuales no tienen grupo
			LOGGER.logDebug("CUSTOMERID: " + entities.get(ScannedDocumentsDetail.CUSTOMERID));
			LOGGER.logDebug("PROCESSINSTANCE: " + entities.get(ScannedDocumentsDetail.PROCESSINSTANCE));
			if (entities.get(ScannedDocumentsDetail.PROCESSINSTANCE) > 0) {
				// Cuando es un crédito individual
				documentsRequest.setProcessInst(entities.get(ScannedDocumentsDetail.PROCESSINSTANCE));
				transactionType = 2;
			} else {
				// Es cuando estamos enviando archivos de prospecto o personas naturales
				documentsRequest.setProcessInst(0);
				transactionType = 1;
			}
			documentsRequest.setDocumentType(entities.get(ScannedDocumentsDetail.DOCUMENTID));
			documentsRequest.setExtension(extension);
			LOGGER.logDebug("transactionType: " + transactionType);

			LOGGER.logDebug("CustomerId: " + documentsRequest.getCustomerId());
			LOGGER.logDebug("GroupId: " + documentsRequest.getGroupId());
			LOGGER.logDebug("ProcessInst: " + documentsRequest.getProcessInst());
			LOGGER.logDebug("DocumentType: " + documentsRequest.getDocumentType());
			LOGGER.logDebug("Extension: " + documentsRequest.getExtension());

			LOGGER.logDebug("--------------->>> Inicia ValidaciOn Extensiones");
			
			ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
			ParameterResponse paramResponse = parameterManagement.getParameter(4, "EXTVDC", "CLI", arg1); // Se crea por el caso #208303
			Boolean contine = false; // Se crea por el caso #208303

			if (paramResponse != null && documentsRequest.getExtension() != null) {
				String validExtensions = paramResponse.getParameterValue();
				LOGGER.logDebug("-->>Extensiones VAlidas(deben estar separadas con ;): " + validExtensions);

				String separadorPC = ";";
				String[] validExtensionsoArreglo = validExtensions.split(separadorPC);

				for (String exts : validExtensionsoArreglo) {
					if (exts.toUpperCase().equals(documentsRequest.getExtension().toUpperCase())) {
						contine = true;
						break;
					}
				}
			}

			if (contine) {
				LOGGER.logDebug("--------------->>> Inicia busqueda de Documentos para clientes Individuales");
				Documents documentsManager = new Documents(getServiceIntegration());

				if (!documentsManager.updateScannedDocuments(documentsRequest, arg1)) {
					arg1.setSuccess(false);
				} else {
					LOGGER.logDebug("Ruta: " + SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH));
					LOGGER.logDebug("Ingresa a guardar archivo en Alfresco");

					UploadAlfresco loadFilesAlfresco = new UploadAlfresco(getServiceIntegration());
					loadFilesAlfresco.uploadFile(transactionType, String.valueOf(documentsRequest.getCustomerId()),
							String.valueOf(documentsRequest.getDocumentType()),
							String.valueOf(documentsRequest.getProcessInst()),
							String.valueOf(documentsRequest.getGroupId()), pathFile);

					arg1.getMessageManager().showSuccessMsg("El documento ha sido subido con exito");
					arg1.setSuccess(true);
				}
			} else {
				LOGGER.logDebug("--------------->>> Error extensiones no vAlidas");
				arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_EXTENSIMC_13881"); // Extensión del documento no válida
				arg1.setSuccess(false);
			}

		} catch (Exception e) {
			ExceptionUtils.showError("Error al subir el documento documento-->" + e.getMessage(), e, arg1, LOGGER);
		}

	}

}
