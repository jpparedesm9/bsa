package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.OperationInusualRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RiskRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.WarningRisk;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

public class UpdateRisk extends BaseEvent implements IGridRowUpdating {
	private static final ILogger LOGGER = LogFactory.getLogger(UpdateRisk.class);

	public UpdateRisk(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		args.setSuccess(true);
		try {
			LOGGER.logDebug("Start IGridRowActionEventArgs in UpdateRisk");
			RiskRequest riskRequest = new RiskRequest();
			OperationInusualRequest operationRequest = new OperationInusualRequest();

			riskRequest.setAlertCode(row.get(WarningRisk.ALERTCODE));
			riskRequest.setObservations(row.get(WarningRisk.OBSERVATIONS));
			riskRequest.setStatusAlert(row.get(WarningRisk.STATUSALERT));

			LOGGER.logDebug("row.get(WarningRisk.ALERTCODE)--->" + row.get(WarningRisk.ALERTCODE));
			LOGGER.logDebug("row.get(WarningRisk.OBSERVATIONS)--->" + row.get(WarningRisk.OBSERVATIONS));
			LOGGER.logDebug("row.get(WarningRisk.STATUSALERT)--->" + row.get(WarningRisk.STATUSALERT));
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
				row.set(WarningRisk.DICTATESDATE, date);
			}

			LOGGER.logDebug("row.get(WarningRisk.GENERATEREPORTS)" + row.get(WarningRisk.GENERATEREPORTS));
			riskRequest.setGenerateReports(row.get(WarningRisk.GENERATEREPORTS));

			AlertManager alertManager = new AlertManager(getServiceIntegration());

			alertManager.updateAlert(riskRequest, args);

			if (riskRequest.getGenerateReports() != null) {
				LOGGER.logDebug("riskRequest.getGenerateReports().charAt(0)-->" + riskRequest.getGenerateReports().charAt(0));

				if (riskRequest.getGenerateReports().charAt(0) == 'S') {
					LOGGER.logDebug("Ingresa a Generar Reporte cuando es S");

					if (ServerParamUtil.getProcessDate() != null) {
						date = formatDate.parse(ServerParamUtil.getProcessDate());
					}
					operationRequest.setAlertId(row.get(WarningRisk.ALERTCODE));
					operationRequest.setDateProcess(null);
					operationRequest.setTypeReport(null);
					alertManager.createReportOpeInusual(operationRequest, args);
				}
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_RISK, e, args, LOGGER);
		}

	}

}
