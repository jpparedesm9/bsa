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

public class CatalogManager extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory
			.getLogger(CatalogManager.class);
	private Parameter.TYPESEUDOCATALOG typeSeudoCatalog;

	public CatalogManager(ICTSServiceIntegration serviceIntegration,
			Parameter.TYPESEUDOCATALOG typeSeudoCatalog) {
		super(serviceIntegration);
		this.typeSeudoCatalog = typeSeudoCatalog;
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO executeDataEvent (loadCountry)");
		}

		CountryQuery country = new CountryQuery(getServiceIntegration(),
				this.typeSeudoCatalog);

		return country.loadCountry(entities, args);
	}
}
