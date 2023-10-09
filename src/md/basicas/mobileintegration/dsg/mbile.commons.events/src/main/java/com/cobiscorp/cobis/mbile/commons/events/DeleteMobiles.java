package com.cobiscorp.cobis.mbile.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.MobileRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Mobile;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.mobile.commons.services.MobileManager;

public class DeleteMobiles  extends BaseEvent implements IGridRowDeleting {

	private static final ILogger LOGGER = LogFactory.getLogger(DeleteMobiles.class);
	
	public DeleteMobiles(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		// TODO Auto-generated method stub
		try {
			MobileRequest mobileRequest = new MobileRequest();
			mobileRequest.setCode(row.get(Mobile.CODE));
			mobileRequest.setImei(row.get(Mobile.IMEI));

			MobileManager mobileManagement = new MobileManager(getServiceIntegration());

			mobileManagement.deleteMobiles(mobileRequest, args);
		}  catch (Exception ex) {
			 ExceptionUtils.showError(ExceptionMessage.MovileIntegration.DELETE_MOVILE, ex, args, LOGGER);
		}
	}

}
