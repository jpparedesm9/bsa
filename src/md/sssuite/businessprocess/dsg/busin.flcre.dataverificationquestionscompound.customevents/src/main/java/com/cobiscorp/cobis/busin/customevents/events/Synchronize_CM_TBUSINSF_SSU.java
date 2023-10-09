package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class Synchronize_CM_TBUSINSF_SSU extends BaseEvent implements IExecuteCommand {

	private static ILogger LOGGER = LogFactory.getLogger(Synchronize_CM_TBUSINSF_SSU.class);

	public Synchronize_CM_TBUSINSF_SSU(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			LOGGER.logDebug("---->Ingresa a Synchronize_CM_TBUSINSF_SSU");

			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			LOGGER.logDebug("---->Ingresa a Synchronize_CM_TBUSINSF_SSU-0");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			int processNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER) == null ? 0 : originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
			int applicationNumber = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));
			String nameActivity = context.get(Context.APPLICATIONSUBJECT);

			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor del tramite:" + applicationNumber);
			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor de la activida:" + nameActivity);
			LOGGER.logDebug("---->Ingresa a Synchronize_CM_TBUSINSF_SSU-A");

			// Sincronización consulta
			SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
			SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
			synchronizationRequest.setApplicationNumber(applicationNumber);
			synchronizationRequest.setNameActivity(nameActivity);

			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor del tramite:" + applicationNumber);
			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor de la actividad:" + nameActivity);

			SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true));

			if (synchronizationResponse == null) {
				LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Ingresar registro ");
				if (synchronizationManagement.createSynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true))) {
					args.setSuccess(true);
					args.getMessageManager().showInfoMsg("BUSIN.MSG_BUSIN_SINCRONAC_26510");
				} else {
					args.getMessageManager().showErrorMsg("BUSIN.MSG_BUSIN_FALLOLAAS_63213");
					args.setSuccess(false);
				}
			}

			// Esta marca servirá para determinar si se habilita o no la pantalla del cuestionario de Verificación de Datos y
			// se permite o no continuar el proceso: Si la marca está en N, se deshabilita la
			// pantalla y no se permite continuar el proceso, si la marca está en S, podemos continuar el proceso.
			context.set(Context.ENABLE, "N");
			synchronizationRequest.setApplicationNumber(applicationNumber);
			synchronizationRequest.setNameActivity(nameActivity);
			Boolean ok = false;
			synchronizationRequest.setProcessNumber(processNumber);
			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor del processNumber:" + processNumber);
			if (synchronizationManagement.xMLQuestionnaire(synchronizationRequest, args, new BehaviorOption(true))) {
				ok = true;
			}
			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor del ok: " + ok);
			if (ok) {
				synchronizationRequest.setSynchronization("N");
				if (synchronizationManagement.updateSynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true))) {
					args.setSuccess(true);
					args.getMessageManager().showInfoMsg("BUSIN.MSG_BUSIN_SINCRONAC_26510");
				} else {
					args.getMessageManager().showErrorMsg("BUSIN.MSG_BUSIN_FALLOLAAS_63213");
					args.setSuccess(false);
				}
			} else {
				args.getMessageManager().showErrorMsg("BUSIN.MSG_BUSIN_FALLOLAAS_63213");
				args.setSuccess(false);
			}
			LOGGER.logDebug("---->Ingresa al Synchronize_CM_TBUSINSF_SSU - Valor del enable:" + context.get(Context.ENABLE));

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.SYNCHRONIZE_QUESTIONS, e, args, LOGGER);
		}
	}
}
