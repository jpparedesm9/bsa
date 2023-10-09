package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CountryQuery;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadNationalityList extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadNationalityList.class);
	private Parameter.TYPESEUDOCATALOG typeSeudoCatalog;

	public LoadNationalityList(ICTSServiceIntegration serviceIntegration, Parameter.TYPESEUDOCATALOG typeSeudoCatalog) {
		super(serviceIntegration);
		this.typeSeudoCatalog = typeSeudoCatalog;
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs eventArgs) {
		CountryQuery country = new CountryQuery(getServiceIntegration(), this.typeSeudoCatalog);
		try{		
		return country.loadCountry(entities, eventArgs);
		}
		catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_NATIONALITY, e, eventArgs, LOGGER);
		}
		return country.loadCountry(entities, eventArgs);
	}

}
