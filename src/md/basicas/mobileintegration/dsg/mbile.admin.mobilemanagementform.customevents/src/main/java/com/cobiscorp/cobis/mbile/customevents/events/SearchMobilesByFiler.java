package com.cobiscorp.cobis.mbile.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.commons.events.MobilesByAll;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchMobilesByFiler extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchMobilesByFiler.class);

	public SearchMobilesByFiler(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {
		DataEntityList response = new DataEntityList();
		try {
			MobilesByAll businessByCustomer = new MobilesByAll(getServiceIntegration());
			response = businessByCustomer.searchMobilesByFilter(entities, args);
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.MovileIntegration.SEARCH_MOBILES_BY_FILTER, e, args, LOGGER);
		}
		return response.getDataList();

	}

}
