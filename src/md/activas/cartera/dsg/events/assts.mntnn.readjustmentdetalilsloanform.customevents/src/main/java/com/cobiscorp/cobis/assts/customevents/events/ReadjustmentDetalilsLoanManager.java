package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.parameter.GeneralFunctionReadjustmentDetails;
import com.cobiscorp.cobis.assts.model.ReadjustmentDetalilsLoan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentDetalilsLoanManager extends BaseEvent implements
		IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentDetalilsLoanManager.class);

	public ReadjustmentDetalilsLoanManager(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO EVENTO executeDataEvent (ReadjustmentDetalilsLoanManager)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		DataEntityList listado = new DataEntityList();

		try {
			GeneralFunctionReadjustmentDetails generador = new GeneralFunctionReadjustmentDetails(
					getServiceIntegration());

			result = generador.eventGenerator(entities,
					Parameter.TYPEEXECUTION.SEARCH);

			if (GeneralFunction.writeResult(result,
					Parameter.TYPEEXECUTION.SEARCH, args)) {
				listado = (DataEntityList) result.get(Parameter.RESULTLIST);
				entities.setEntityList(ReadjustmentDetalilsLoan.ENTITY_NAME,
						listado);
			}
		} catch (Exception ex) {
			logger.logError(ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("FIN EVENTO executeDataEvent (ReadjustmentDetalilsLoanManager)");
			}
		}
	}
}
