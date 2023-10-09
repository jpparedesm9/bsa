package com.cobiscorp.cobis.bmtrc.customevents.events;

import com.cobiscorp.cobis.bmtrc.customevents.constants.Constants;
import com.cobiscorp.cobis.bmtrc.customevents.manager.BioCheckManager;
import com.cobiscorp.cobis.bmtrc.model.Customer;
import com.cobiscorp.cobis.bmtrc.model.ValidationData;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SavedBiometricValidation extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(SavedBiometricValidation.class);

	public SavedBiometricValidation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			DataEntity data = entities.getEntity(ValidationData.ENTITY_NAME);
			DataEntityList customerList = entities.getEntityList(Customer.ENTITY_NAME);
			BioCheckManager biocheckManager = new BioCheckManager(this.getServiceIntegration());
			int pending = 0;

			String validationResult = biocheckManager.validateData(data.get(ValidationData.CUSTOMERID), data.get(ValidationData.PROCESSINSTANCE), "G", args);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Resultado de Validacion: " + validationResult);
			}
			String validationResultStatus = "";

			String[] validationResultArray = validationResult.split(";");
			String validationResultLimits = validationResultArray[0];

			if (validationResultArray.length > 0) {
				validationResultStatus = validationResultArray[1];
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("validationResultStatus: " + validationResultStatus);
			}

			if (Constants.PENDING_RESPONSE.equals(validationResultStatus)) {
				args.setSuccess(false);
				data.set(ValidationData.RESULTVALIDATION, Constants.PENDING);
				args.getMessageManager().showErrorMsg("Existen Clientes Pendientes");

			} else if (Constants.REJECTED_RESPONSE_DOC.equals(validationResultStatus)) {
				args.setSuccess(false);
				data.set(ValidationData.RESULTVALIDATION, Constants.REJECTED);
				args.getMessageManager().showErrorMsg("Revisar Documentación de clientes Sin Huella");
			} else {
				args.setSuccess(true);
				if (Constants.REJECTED_RESPONSE.equals(validationResultStatus)) {
					args.setSuccess(false);
					data.set(ValidationData.RESULTVALIDATION, Constants.REJECTED);
					args.getMessageManager().showErrorMsg("Existen Clientes Rechazados");
				} else {
					if (Constants.NEGATIVE_RESPONSE.equals(validationResultLimits)) {
						args.setSuccess(false);
						data.set(ValidationData.RESULTVALIDATION, Constants.REJECTED);
						args.getMessageManager().showErrorMsg("El grupo excede el número establecido de clientes limitado");
					} else {
						data.set(ValidationData.RESULTVALIDATION, Constants.APPROVED);
					}
				}

			}

		} catch (Exception e) {
			LOGGER.logError("Error: ", e);
			args.getMessageManager().showErrorMsg("Ocurrió un error al realizar la Validación");
			args.setSuccess(false);
		}

	}

}
