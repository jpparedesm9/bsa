package com.cobiscorp.cobis.mbile.customevents.events;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.mbile.model.Mobile;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowCommand;
import com.cobiscorp.designer.api.customization.arguments.IGridRowCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.mobile.commons.services.SyncManager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.DeviceSyncBatchRequest;

public class SyncUp extends BaseEvent implements IGridRowCommand {

	public SyncUp(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	private static final ILogger LOGGER = LogFactory.getLogger(SyncUp.class);

	@Override
	public void executeRowCommad(DataEntity entities, IGridRowCommandEventArgs arg1) {
		
		try {
			LOGGER.logDebug("executeCommand SyncMobile Customer");
			
			// TODO Auto-generated method stub
			LOGGER.logDebug("------>> VA_GRIDROWCOMMMNAN_851846 - Inicio SyncUp");		
			//officialSyncUp 
			
			arg1.setSuccess(true);
			
			String oficialString = entities.get(Mobile.OFFICIAL);
			Character estado = entities.get(Mobile.DEVICESTATUS);
			String imei = entities.get(Mobile.IMEI);
			
			int oficial = Integer.parseInt(oficialString);  
			SyncManager syncManager = new SyncManager(getServiceIntegration());
			
			/* Sincroniza Clientes */
			/*CustomerSyncRequest customerRequest = new CustomerSyncRequest();
			customerRequest.setOfficialId(oficial);
			syncManager.syncCustomerByOfficial(customerRequest, arg1);*/
			
			/* Sincroniza Grupos */
			/*GroupSyncRequest groupRequest = new GroupSyncRequest();
			groupRequest.setOfficialId(oficial);
			syncManager.syncGroupByOfficial(groupRequest, arg1);*/
			
			Map<String, Object> session = SessionManager.getSession();
			String loggedUser = (String) session.get("user-context-user");
			
			if (loggedUser == null) {
				Exception e = new Exception();
				ExceptionUtils.showError(ExceptionMessage.MovileIntegration.SYN_DATA_BY_OFICIAL.concat(". No se pudo obtener el usuario de la sesi\u00F3n"), e, arg1, LOGGER);
			} else {				
				DeviceSyncBatchRequest deviceSyncRequest = new DeviceSyncBatchRequest();
				deviceSyncRequest.setOficial(oficial);
				deviceSyncRequest.setUsuario(loggedUser);
				deviceSyncRequest.setEstado(String.valueOf(estado));
				deviceSyncRequest.setImei(imei);
				
				LOGGER.logDebug("------>> VA_GRIDROWCOMMMNAN_851846 - Inicio SyncUp - Oficial:"+oficial);
				LOGGER.logDebug("------>> VA_GRIDROWCOMMMNAN_851846 - Inicio SyncUp - Estado:"+estado);
				LOGGER.logDebug("------>> VA_GRIDROWCOMMMNAN_851846 - Inicio SyncUp - Imei:"+imei);
				
				syncManager.addBatchSyncDevice(deviceSyncRequest, arg1);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.MovileIntegration.SYN_DATA_BY_OFICIAL, e, arg1, LOGGER);
		}
		
	}
}