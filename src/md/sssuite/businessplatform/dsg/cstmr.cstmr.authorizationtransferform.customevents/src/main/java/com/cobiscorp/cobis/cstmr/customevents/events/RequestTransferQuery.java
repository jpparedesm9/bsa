package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.TransferResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.AuthorizationTransferRequest;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class RequestTransferQuery extends BaseEvent implements IExecuteQuery {
	private static final ILogger LOGGER = LogFactory.getLogger(RequestTransferQuery.class);
	public RequestTransferQuery (ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		LOGGER.logDebug("Ingreso executeDataEvent RequestTransferQuery ");
		
		LOGGER.logDebug("data args: " + arg0.getData().toString());

		DataEntityList lista = new DataEntityList();
	    DataEntity item = new DataEntity();
	    int officeId = Integer.parseInt((String) arg0.getData().get("idOffice"));  

	    TransferManager transferManager = new TransferManager(this.getServiceIntegration());
	    try {
			LOGGER.logDebug("data: "+arg0.getData().toString());
			for ( TransferResponse transferResponse : transferManager.searchTransferRequest(officeId, arg1)) {
				
				item = new DataEntity();
				item.set(AuthorizationTransferRequest.IDREQUEST,transferResponse.getIdRequest());
				item.set(AuthorizationTransferRequest.NAMEOFFICIAL,transferResponse.getNameOfficial());
				item.set(AuthorizationTransferRequest.ROLOFFICIAL,transferResponse.getRolDescription());
				item.set(AuthorizationTransferRequest.TYPEREQUEST,transferResponse.getTypeCustumer());
				item.set(AuthorizationTransferRequest.DATEREQUEST,transferResponse.getDateRequest());
				item.set(AuthorizationTransferRequest.ENDDATEREQUEST,transferResponse.getEndDateRequest());
				item.set(AuthorizationTransferRequest.OFFICIALORG,transferResponse.getOfficialOrg());
				item.set(AuthorizationTransferRequest.OFFICIALDES,transferResponse.getOfficialDes());
				item.set(AuthorizationTransferRequest.TRANSFERREASON,transferResponse.getTransferReason());
				lista.add(item);			
			}
			
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_TRANSFER, e, arg1, LOGGER);
		}
		return lista.getDataList();
	}

}
