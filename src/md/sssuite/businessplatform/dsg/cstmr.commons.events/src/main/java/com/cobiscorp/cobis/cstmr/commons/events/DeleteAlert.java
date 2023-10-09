package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.UnusualOperationsView;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

public class DeleteAlert extends BaseEvent implements IGridRowDeleting {

	private static final ILogger LOGGER = LogFactory.getLogger(DeleteAlert.class);

	public DeleteAlert(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		// TODO Auto-generated method stub
		try {
			AlertRequest alertRequest = new AlertRequest();
			alertRequest.setCode(row.get(UnusualOperationsView.CODE));

			AlertManager alertManagement = new AlertManager(getServiceIntegration());

			alertManagement.deleteAlert(alertRequest, args);
		} catch (BusinessException bex) {
			LOGGER.logError("BusinessException: " + bex);
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		} catch (Exception ex) {
			LOGGER.logError("Exception: " + ex);
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		}
	}

}
