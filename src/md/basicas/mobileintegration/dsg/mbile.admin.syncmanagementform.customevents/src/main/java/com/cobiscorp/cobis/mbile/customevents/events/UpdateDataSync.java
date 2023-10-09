package com.cobiscorp.cobis.mbile.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.SyncRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Sync;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.mobile.commons.services.SyncManager;

public class UpdateDataSync extends BaseEvent implements IGridRowUpdating {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateDataSync.class);

	public UpdateDataSync(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs arg1) {
		Integer syncId = row.get(Sync.CODE);
		try {

			if (row.get(Sync.STATE) != null) {
				SyncRequest syncRequest = new SyncRequest();
				if (syncId == null) {
					arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_ELPROSPGA_21497");
				} else {
					syncRequest.setCode(syncId);
					syncRequest.setState(row.get(Sync.STATE));
					
					SyncManager syncManager = new SyncManager(getServiceIntegration());
					syncManager.updateSyncs(syncRequest, arg1);
					if(row.get(Sync.STATE).equals("P") ){
						row.set(Sync.DATESYNC, null);
					}
				}
			}
		} catch (Exception ex) {
			 ExceptionUtils.showError(ExceptionMessage.MovileIntegration.DELETE_MOVILE, ex, arg1, LOGGER);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---> Finish rowAction State Sync");
			}
		}

	}

}
