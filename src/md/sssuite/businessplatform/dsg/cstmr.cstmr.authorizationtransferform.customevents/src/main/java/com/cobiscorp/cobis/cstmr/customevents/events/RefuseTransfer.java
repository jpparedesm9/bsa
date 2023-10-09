package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.TransferRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.AuthorizationTransferRequest;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class RefuseTransfer extends BaseEvent implements IOnCloseModalEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(RefuseTransfer.class);
	public RefuseTransfer(ICTSServiceIntegration serviceIntegration) {
		super (serviceIntegration);
	}

	@Override
	public void onCloseModalEvent(DynamicRequest entity, ICloseModalEventArgs arg1) {
		DataEntityList lista = new DataEntityList();
		try {
			lista = entity.getEntityList(AuthorizationTransferRequest.ENTITY_NAME);
			
			for ( DataEntity authorizationTransfer : lista) {
				LOGGER.logDebug("RefuseTransfer Imprimir DataEntity 2: " + authorizationTransfer.get(AuthorizationTransferRequest.ISCHECKED));
				if(authorizationTransfer.get(AuthorizationTransferRequest.ISCHECKED)!=null){
					LOGGER.logDebug("RefuseTransfer Imprimir Ingresa");
					if (authorizationTransfer.get(AuthorizationTransferRequest.ISCHECKED)) {
						TransferManager transferManager = new TransferManager(this.getServiceIntegration());
						
						TransferRequest transferRequest = new TransferRequest();
						transferRequest.setOfficialOrg(authorizationTransfer.get(AuthorizationTransferRequest.OFFICIALORG));
						transferRequest.setOfficialDes(authorizationTransfer.get(AuthorizationTransferRequest.OFFICIALDES));
						transferRequest.setIdRequest(authorizationTransfer.get(AuthorizationTransferRequest.IDREQUEST));
						transferRequest.setLogin(authorizationTransfer.get(AuthorizationTransferRequest.LOGINOFFICIAL));
						transferRequest.setDesCause(authorizationTransfer.get(AuthorizationTransferRequest.REJECTIONREASON));
						
						transferManager.refuseRequestTransfer(transferRequest, arg1);
					}
				}				
			}
			
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.REF_TRANSFER, e, arg1, LOGGER);
		}
		
	}
}
