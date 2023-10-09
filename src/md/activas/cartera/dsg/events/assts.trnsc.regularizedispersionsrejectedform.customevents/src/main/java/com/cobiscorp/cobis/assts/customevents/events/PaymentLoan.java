package com.cobiscorp.cobis.assts.customevents.events;

import java.text.SimpleDateFormat;

import com.cobiscorp.cobis.assets.commons.services.RejectedDispersionManagement;
import com.cobiscorp.cobis.assts.model.DetailRejectedDispersions;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class PaymentLoan extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(PaymentLoan.class);

	public PaymentLoan(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {

		LOGGER.logDebug(">>>>>Inicia PaymentLoan");

		try {
			RejectedDispersionsRequest rejectedDispersionsRequest = new RejectedDispersionsRequest();
			DataEntityList rejectedDispersionsList = entities.getEntityList(DetailRejectedDispersions.ENTITY_NAME);

			LOGGER.logInfo(">>>>>entidad " + rejectedDispersionsList.toString());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			for (DataEntity row : rejectedDispersionsList) {

				LOGGER.logInfo(">>>>>for " + DetailRejectedDispersions.SELECTION);
				if (row.get(DetailRejectedDispersions.SELECTION) != null
						&& row.get(DetailRejectedDispersions.SELECTION)) {

					rejectedDispersionsRequest.setStartDate(sdf.format(row.get(DetailRejectedDispersions.DATE)));
					rejectedDispersionsRequest.setConsecutive(row.get(DetailRejectedDispersions.CONSECUTIVE));
					rejectedDispersionsRequest.setLine(row.get(DetailRejectedDispersions.LINE));
					rejectedDispersionsRequest.setAction(3);

					RejectedDispersionManagement dispersionManagement = new RejectedDispersionManagement(
							getServiceIntegration());

					rejectedDispersionsRequest.setOperation('P');

					dispersionManagement.dispersionActions(rejectedDispersionsRequest, arg1);
				}
			}

		} catch (Exception e) {
			ExceptionUtils.showError("Error al ejeutrar acción Cancelar Obligacion", e, arg1, LOGGER);
		}

	}

}
