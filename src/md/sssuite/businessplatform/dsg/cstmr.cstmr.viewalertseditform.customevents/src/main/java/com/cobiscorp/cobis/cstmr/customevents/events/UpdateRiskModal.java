package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.WarningRisk;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.OperationInusualRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RiskRequest;

public class UpdateRiskModal extends BaseEvent implements IExecuteCommand{
	private static final ILogger LOGGER = LogFactory.getLogger(UpdateRiskModal.class);
	
	public UpdateRiskModal(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		// TODO Auto-generated method stub
		try {
		
		LOGGER.logDebug("Start executeCommand in modal");
		RiskRequest riskRequest = new RiskRequest();
		OperationInusualRequest operationRequest = new OperationInusualRequest();
		DataEntity requestEntity = entities.getEntity(WarningRisk.ENTITY_NAME);
		LOGGER.logDebug("requestEntity.get(WarningRisk.ALERTCODE)--->" +requestEntity.get(WarningRisk.ALERTCODE));
		LOGGER.logDebug("requestEntity.get(WarningRisk.OBSERVATIONS)" + requestEntity.get(WarningRisk.OBSERVATIONS));
		LOGGER.logDebug("requestEntity.get(WarningRisk.STATUSALERT)--->" +requestEntity.get(WarningRisk.STATUSALERT));
		
		riskRequest.setAlertCode(requestEntity.get(WarningRisk.ALERTCODE));
		riskRequest.setObservations(requestEntity.get(WarningRisk.OBSERVATIONS));
		riskRequest.setStatusAlert(requestEntity.get(WarningRisk.STATUSALERT));
		Date date = null;
		Calendar processDate = null;
		SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");

		if (ServerParamUtil.getProcessDate() != null) {
			date = formatDate.parse(ServerParamUtil.getProcessDate());
		}

		if (date != null) {
			processDate = GeneralFunction.convertDateToCalendar(date);
			riskRequest.setDictatesDate(processDate);
			/* Se asigna la nueva fecha */
			requestEntity.set(WarningRisk.DICTATESDATE, date);
		}

		LOGGER.logDebug("row.get(WarningRisk.GENERATEREPORTS)" + requestEntity.get(WarningRisk.GENERATEREPORTS));
		riskRequest.setGenerateReports(requestEntity.get(WarningRisk.GENERATEREPORTS));

		AlertManager alertManager = new AlertManager(getServiceIntegration());

		alertManager.updateAlert(riskRequest, arg1);

		if (riskRequest.getGenerateReports() != null) {
			LOGGER.logDebug("riskRequest.getGenerateReports().charAt(0)-->" + riskRequest.getGenerateReports().charAt(0));

			if (riskRequest.getGenerateReports().charAt(0) == 'S') {
				LOGGER.logDebug("Ingresa a Generar Reporte cuando es S");

				if (ServerParamUtil.getProcessDate() != null) {
					date = formatDate.parse(ServerParamUtil.getProcessDate());
				}
				operationRequest.setAlertId(requestEntity.get(WarningRisk.ALERTCODE));
				operationRequest.setDateProcess(null);
				operationRequest.setTypeReport(null);
				alertManager.createReportOpeInusual(operationRequest, arg1);
			}
		}

		arg1.setSuccess(true);
		} catch (Exception e) {
			arg1.setSuccess(false);
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_RISK, e, arg1, LOGGER);
		}
		
	}

}
