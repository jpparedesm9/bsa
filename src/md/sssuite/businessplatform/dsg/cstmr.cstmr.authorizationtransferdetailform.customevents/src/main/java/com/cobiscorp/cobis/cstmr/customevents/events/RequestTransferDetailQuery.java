package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.TransferRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.AuthorizationTransferDetail;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class RequestTransferDetailQuery extends BaseEvent implements IExecuteQuery {
	private static final ILogger LOGGER = LogFactory.getLogger(RequestTransferDetailQuery.class);

	public RequestTransferDetailQuery(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entity, IExecuteQueryEventArgs arg1) {
		LOGGER.logDebug("Ingreso executeDataEvent RequestTransferDetailQuery ");

		LOGGER.logDebug("args data: " + entity.getData().toString());
		LOGGER.logDebug("args Parameters: " + arg1.getParameters().getCustomParameters());

		DataEntityList lista = new DataEntityList();

		LOGGER.logDebug("args idRequest: " + arg1.getParameters().getCustomParameters().get("idRequest"));
		int idRequest = 0;
		if ((arg1.getParameters().getCustomParameters().get("idRequest") != null) && (arg1.getParameters().getCustomParameters().get("idRequest") != "")) {
			idRequest = Integer.valueOf(arg1.getParameters().getCustomParameters().get("idRequest").toString());
		}
		
		TransferRequest transferRequest = new TransferRequest();
		transferRequest.setIdRequest(idRequest);
		
		TransferManager transferManager = new TransferManager(this.getServiceIntegration());
		CustomerResponse[] customerResponse = transferManager.searchTransferDetailRequest(transferRequest, arg1);
		try {
			for (CustomerResponse resp : customerResponse) {
				DataEntity item = new DataEntity();
				item.set(AuthorizationTransferDetail.CODE, resp.getCustomerId());
				item.set(AuthorizationTransferDetail.NAMES, resp.getCustomerFullName());
				item.set(AuthorizationTransferDetail.TYPE, resp.getCustomerSubType());
				lista.add(item);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_TRANSFER_DETAIL, e, arg1, LOGGER);
		}
		return lista.getDataList();
	}
}
