package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.References;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.ReferencesManager;

public class DeleteReferences  extends BaseEvent implements IGridRowDeleting {

	private static final ILogger LOGGER = LogFactory.getLogger(DeleteReferences.class);
	
	public DeleteReferences(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		// TODO Auto-generated method stub
		try {
			CustomerReferenceRequest referencesRequest = new CustomerReferenceRequest();
			referencesRequest.setReferences(row.get(References.REFERENCES));
			referencesRequest.setCustomerCode(row.get(References.CUSTOMERCODE));

			ReferencesManager referencesManagement = new ReferencesManager(getServiceIntegration());

			referencesManagement.deleteReferences(referencesRequest, args);
		} catch (BusinessException bex) {
			LOGGER.logError("BusinessException: " + bex);
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		} catch (Exception ex) {
			LOGGER.logError("Exception: " + ex);
			args.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		}
	}

}
