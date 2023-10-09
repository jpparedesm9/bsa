package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.parameter.GeneralFunctionReadjustment;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentLoanCommandEvents extends BaseEvent implements
		IExecuteCommand {
	private Parameter.TYPEEXECUTION typeExecution;

	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentLoanCommandEvents.class);

	public ReadjustmentLoanCommandEvents(
			ICTSServiceIntegration serviceIntegration,
			Parameter.TYPEEXECUTION typeExecution) {
		super(serviceIntegration);

		this.typeExecution = typeExecution;
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO EVENTO executeCommand (ReadjustmentLoanCommandEvents)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		DataEntityList listado = new DataEntityList();

		try {
			GeneralFunctionReadjustment generador = new GeneralFunctionReadjustment(
					getServiceIntegration());

			result = generador.eventGenerator(entities, this.typeExecution);

			if (GeneralFunction.writeResult(result, this.typeExecution, args)) {
				listado = (DataEntityList) result.get(Parameter.RESULTLIST);
				entities.setEntityList(ReadjustmentLoanCab.ENTITY_NAME, listado);
			}

		} catch (Exception ex) {
			logger.logError(ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("FIN EVENTO executeCommand (ReadjustmentLoanCommandEvents)");
			}
		}
	}

}
