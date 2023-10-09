package com.cobiscorp.cobis.mbile.commons.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.MobileFilterRequest;
import cobiscorp.ecobis.mobilemanagement.dto.MobileRequest;
import cobiscorp.ecobis.mobilemanagement.dto.MobileResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Mobile;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.mobile.commons.services.MobileManager;

public class MobilesByAll extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(MobilesByAll.class);

	public MobilesByAll(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void searchMobiles(DynamicRequest entities, ICommonEventArgs args) throws Exception {

		LOGGER.logDebug("Start searchMobileByCustomer in SearchMobileByCustomer");
		DataEntityList customerTmp = entities.getEntityList(Mobile.ENTITY_NAME);
		LOGGER.logDebug("customerTmp Mobile---" + customerTmp);
		MobileRequest request = new MobileRequest();
		MobileManager MobileManager = new MobileManager(getServiceIntegration());
		MobileResponse[] mobiles = MobileManager.searchMobiles(request, args);
		entities.setEntityList(Mobile.ENTITY_NAME, mapMobileResponse(mobiles));
		LOGGER.logDebug("Finish searchMobileByCustomer in SearchMobileByCustomer");
	}

	public DataEntityList searchMobilesByFilter(DynamicRequest entities, ICommonEventArgs args) throws Exception {
		LOGGER.logDebug("Start searchMobilesByFilter in SearchMobileByCustomer");

		Map<String, Object> mobileFilters = entities.getData();
		MobileFilterRequest mobileFilterRequest = new MobileFilterRequest();
		mobileFilterRequest
				.setImei(mobileFilters.get("imei") == null ? null : String.valueOf(mobileFilters.get("imei")));
		mobileFilterRequest.setOfficial(
				mobileFilters.get("official") == null ? null : String.valueOf(mobileFilters.get("official")));
		MobileManager MobileManager = new MobileManager(getServiceIntegration());
		MobileResponse[] mobiles = MobileManager.searchMobilesByFilter(mobileFilterRequest, args);
		LOGGER.logDebug("Finish searchMobilesByFilter in SearchMobileByCustomer");
		return mapMobileResponse(mobiles);

	}

	public DataEntityList mapMobileResponse(MobileResponse[] mobiles) throws Exception {
		LOGGER.logDebug("Start mapMobileResponse in SearchMobileByCustomer");
		DataEntityList mobilesList = new DataEntityList();
		try {
			for (MobileResponse mobile : mobiles) {
				DataEntity mobileEntity = new DataEntity();
				mobileEntity.set(Mobile.CODE, mobile.getCode());
				LOGGER.logDebug("MobileList PoupForm Code>>" + mobile.getCode());
				Date dateTmp = null;
				SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");

				mobileEntity.set(Mobile.TYPE, mobile.getType());
				mobileEntity.set(Mobile.TYPEDESCRIPTION, mobile.getTypeDescription());
				mobileEntity.set(Mobile.IMEI, mobile.getImei());
				mobileEntity.set(Mobile.MACADDRESS, mobile.getMacAddress());
				mobileEntity.set(Mobile.OFFICIAL, mobile.getOfficial());
				mobileEntity.set(Mobile.OFFICIALDESCRIPTION, mobile.getOfficialDescription());
				mobileEntity.set(Mobile.ALIAS, mobile.getAlias());

				if (mobile.getRegistrationDate() != null) {
					dateTmp = formatDate.parse(mobile.getRegistrationDate());
				}
				mobileEntity.set(Mobile.REGISTRATIONDATE, dateTmp);
				mobileEntity.set(Mobile.REGISTRATIONUSER, mobile.getRegistrationUser());
				mobileEntity.set(Mobile.DEVICESTATUS, mobile.getDeviceStatus());
				mobileEntity.set(Mobile.DEVICESTATUSDESCRIPTION, mobile.getDeviceStatusDescripcion());
				if (mobile.getAllowUpdate() != null) {
					mobileEntity.set(Mobile.ALLOWUPDATE, "S".equals(mobile.getAllowUpdate()));
				}

				mobilesList.add(mobileEntity);
			}
		} catch (Exception ex) {
			throw ex;
		} finally {
			LOGGER.logDebug("Finish mapMobileResponse in SearchMobileByCustomer");
		}
		return mobilesList;

	}

}
