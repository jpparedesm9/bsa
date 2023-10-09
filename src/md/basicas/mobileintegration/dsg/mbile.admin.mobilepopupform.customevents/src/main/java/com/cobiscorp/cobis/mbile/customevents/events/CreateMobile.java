package com.cobiscorp.cobis.mbile.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.MobileRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Mobile;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.mobile.commons.services.MobileManager;

public class CreateMobile extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(CreateMobile.class);

	public CreateMobile(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		try {

			LOGGER.logDebug("Inicio de CreateMobile executeCommand ");

			DataEntity requestEntity = entities.getEntity(Mobile.ENTITY_NAME);
			int codeMobile = requestEntity.get(Mobile.CODE);

			MobileRequest mobileRequest = new MobileRequest();

			mobileRequest.setCode(codeMobile);
			mobileRequest.setType(requestEntity.get(Mobile.TYPE));
			mobileRequest.setImei(requestEntity.get(Mobile.IMEI));
			mobileRequest.setMacAddress(requestEntity.get(Mobile.MACADDRESS));
			mobileRequest.setOfficial(requestEntity.get(Mobile.OFFICIAL));
			mobileRequest.setAlias(requestEntity.get(Mobile.ALIAS));
			mobileRequest.setDeviceStatus(requestEntity.get(Mobile.DEVICESTATUS));
			mobileRequest.setAllowUpdate(requestEntity.get(Mobile.ALLOWUPDATE)?"S":"N");

			MobileManager MobileManager = new MobileManager(getServiceIntegration());

			Integer actualMobileCode = requestEntity.get(Mobile.CODE);

			if (actualMobileCode == 0) {
				int MobileCode = MobileManager.createMobiles(mobileRequest, args);
				requestEntity.set(Mobile.CODE, MobileCode);
				LOGGER.logDebug("CODIGO MOBILE SETEADO " + requestEntity.get(Mobile.CODE));
			} else {
				mobileRequest.setCode(actualMobileCode);
				MobileManager.updateMobiles(mobileRequest, args);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.MovileIntegration.CREATE_MOVILE, e, args, LOGGER);
		}

	}

}
