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
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentDetalilsLoanCommandEvents extends BaseEvent implements
		IExecuteCommand {
	private Parameter.TYPEEXECUTION typeExecution;

	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentDetalilsLoanCommandEvents.class);

	public ReadjustmentDetalilsLoanCommandEvents(
			ICTSServiceIntegration serviceIntegration,
			Parameter.TYPEEXECUTION typeExecution) {
		super(serviceIntegration);
		this.typeExecution = typeExecution;
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO EVENTO executeCommand (ReadjustmentDetalilsLoanCommandEvents)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		DataEntityList listado = new DataEntityList();

		try {
			GeneralFunctionReadjustmentDetails generador = new GeneralFunctionReadjustmentDetails(
					getServiceIntegration());

			result = generador.eventGenerator(entities, this.typeExecution);

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
				logger.logDebug("FIN EVENTO executeCommand (ReadjustmentDetalilsLoanCommandEvents)");
			}
		}
	}
}
