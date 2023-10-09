package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.CurrencyListRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.CatalogQuery;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class InitDataCurrency extends BaseEvent implements ILoadCatalog {
	private static final ILogger logger = LogFactory
			.getLogger(InitDataCurrency.class);

	public InitDataCurrency(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs catalogDataEventArgs) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("InitDataCurrency.executeDataEvent(..) Entro");
			logger.logDebug("InitDataCurrency.executeDataEvent(..) entities= "
					+ entities.getData());
		}
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		CurrencyListRequest currencyListRequest = new CurrencyListRequest();
		currencyListRequest.setOperacion(Parameter.OPERATIONH.charAt(0));
		currencyListRequest.setTipo(Parameter.QUERYTYPEA);
		currencyListRequest.setModo(Parameter.MODE0);

		CatalogQuery catalogQuery = new CatalogQuery(
				this.getServiceIntegration());
		try {
			return catalogQuery.queryCurrencyList(catalogDataEventArgs, currencyListRequest);
		} catch (Exception e) {
			logger.logDebug("InitDataCurrency error= " + e);
		}
		return lista;
	}

}
