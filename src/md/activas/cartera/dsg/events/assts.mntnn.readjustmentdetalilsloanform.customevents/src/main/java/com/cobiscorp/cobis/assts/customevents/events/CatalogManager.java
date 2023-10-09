package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.parameter.GeneralEvents;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CatalogManager extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory
			.getLogger(CatalogManager.class);

	public CatalogManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO EVENTO executeDataEvent (CatalogManager)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		List<ItemDTO> listado = new ArrayList<ItemDTO>();
		String mensaje = "";

		try {
			GeneralEvents generador = new GeneralEvents(getServiceIntegration());

			result = generador.loadCatalog();

			mensaje = GeneralFunction.getMessageError(
					(List<Message>) result.get(Parameter.MESSAGESERVERLIST),
					(List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));

			if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
				args.getMessageManager().showErrorMsg(mensaje);
			} else {
				listado = (List<ItemDTO>) result
						.get(Parameter.RESULTLISTCATALOG);
			}
		} catch (Exception ex) {
			logger.logError(ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("FIN EVENTO executeDataEvent (CatalogManager)");
			}
		}

		return listado;
	}
}
