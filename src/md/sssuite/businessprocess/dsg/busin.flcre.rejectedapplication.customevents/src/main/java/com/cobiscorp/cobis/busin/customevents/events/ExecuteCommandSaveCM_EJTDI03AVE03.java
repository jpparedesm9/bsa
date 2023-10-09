package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RejectRequest;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandSaveCM_EJTDI03AVE03 extends BaseEvent implements
		IExecuteCommand {
	private static ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandSaveCM_EJTDI03AVE03.class);

	public ExecuteCommandSaveCM_EJTDI03AVE03(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {

		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logError("RejectedApp - Start ExecuteCommandSaveCM_EJTDI03AVE03");
			}

			DataEntity originalHeader = entities
					.getEntity(OriginalHeader.ENTITY_NAME);

			int applicationNumber = originalHeader
					.get(OriginalHeader.APPLICATIONNUMBER);
			TransactionManagement transactionManagement = new TransactionManagement(
					super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement
					.getProcessedNumber(applicationNumber, args,
							new BehaviorOption(true));

			RejectRequest RejectRequestDTO = new RejectRequest();

			RejectRequestDTO.setTransact(processedNumber.getTramite());
			RejectRequestDTO.setReason(originalHeader.get(
					OriginalHeader.REJECTIONREASON).toString());
			RejectRequestDTO.setTxtReason(originalHeader
					.get(OriginalHeader.REJECTIONEXCUSE));

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logError("RejectedApp - Tramite : "
						+ RejectRequestDTO.getTransact());
				LOGGER.logError("RejectedApp - Razón : "
						+ RejectRequestDTO.getReason());
				LOGGER.logError("RejectedApp - Justificación : "
						+ RejectRequestDTO.getTxtReason());
			}

			boolean resultado = transactionManagement.RejectApplication(
					RejectRequestDTO, args, new BehaviorOption(true));

			if (resultado != true) {
				args.getMessageManager().showErrorMsg(
						"NO se ejecutó  Operación");
			} else {
				args.getMessageManager().showSuccessMsg("Operacion OK");
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REJECTED_EXECUTE_SAVEAPP, e, args, LOGGER);
		}
	}
}
