package com.cobiscorp.cobis.mbile.commons.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.SyncFilterRequest;
import cobiscorp.ecobis.mobilemanagement.dto.SyncResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Sync;
import com.cobiscorp.cobis.mbile.model.SyncFilter;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.mobile.commons.services.SyncManager;

public class SyncDataByFilter extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(SyncDataByFilter.class);

	public SyncDataByFilter(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void searchDataSync(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start searchDataSync in SyncDataByFilter");
		
		DataEntity syncDataTmp = entities.getEntity(SyncFilter.ENTITY_NAME);
		LOGGER.logDebug("syncDataTmp Sincronizacion---" + syncDataTmp);
		
		SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
		String user = null;
		String state = null;
		String dateEntry = null;
		String dateSync = null;
		
		if (syncDataTmp.get(SyncFilter.USER) != null) {
			user = syncDataTmp.get(SyncFilter.USER);
		}
		if (syncDataTmp.get(SyncFilter.STATE) != null) {
			state = syncDataTmp.get(SyncFilter.STATE);
		}
		if (syncDataTmp.get(SyncFilter.DATEENTRY) != null) {
			dateEntry = formatDate.format(syncDataTmp.get(SyncFilter.DATEENTRY));
		}
		if (syncDataTmp.get(SyncFilter.DATESYNC) != null) {
			dateSync = formatDate.format(syncDataTmp.get(SyncFilter.DATESYNC));
		}
		
		
		LOGGER.logDebug("user Sincronizacion---" + user);
		LOGGER.logDebug("state Sincronizacion---" + state);
		LOGGER.logDebug("dateEntry Sincronizacion---" + dateEntry);
		LOGGER.logDebug("dateSync Sincronizacion---" + dateSync);
		
		SyncFilterRequest request = new SyncFilterRequest();
		request.setUser(user);
		request.setState(state);
		request.setDateEntry(dateEntry);
		request.setDateSync(dateSync);
		
		SyncManager syncManager = new SyncManager(getServiceIntegration());
		SyncResponse[] sync = syncManager.searchSyncData(request, args);
		
		DataEntityList syncDataList = new DataEntityList();
		
		LOGGER.logDebug("Syncss Imprimiendo ---" + sync);
		
		for (SyncResponse resp : sync) {
			DataEntity mobileEntity = new DataEntity();
			
			Date dateEntryTmp = null;
			Date dateSyncTmp = null;
			
			
			LOGGER.logDebug("SyncList Code>>" + resp.getCode());
			mobileEntity.set(Sync.CODE, resp.getCode());
			mobileEntity.set(Sync.ENTIY, resp.getEntity());
			mobileEntity.set(Sync.ENTITYDESCRIPTION, resp.getEntityDescription());
			mobileEntity.set(Sync.USER, resp.getUser());
			mobileEntity.set(Sync.STATE, resp.getState());
			
			if (resp.getDateEntry() != null) {
				dateEntryTmp = formatDate.parse(resp.getDateEntry());
			}
			mobileEntity.set(Sync.DATEENTRY, dateEntryTmp);
			
			if (resp.getDateSync() != null) {
				dateSyncTmp = formatDate.parse(resp.getDateSync());
			}
			mobileEntity.set(Sync.DATESYNC, dateSyncTmp);
			
			
			syncDataList.add(mobileEntity);
		}
		
		LOGGER.logDebug("syncList From Size>>" + syncDataList.size());

		entities.setEntityList(Sync.ENTITY_NAME, syncDataList);
	}

}
