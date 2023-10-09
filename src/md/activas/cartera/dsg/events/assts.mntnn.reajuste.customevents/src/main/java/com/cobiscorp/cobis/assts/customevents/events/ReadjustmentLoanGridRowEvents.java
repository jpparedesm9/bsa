package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.parameter.GeneralFunctionReadjustment;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentLoanGridRowEvents extends BaseEvent implements
		IGridRowUpdating, IGridRowDeleting {
	private Parameter.TYPEEXECUTION typeExecution;

	private static final ILogger LOGGER = LogFactory
			.getLogger(ReadjustmentLoanGridRowEvents.class);

	public ReadjustmentLoanGridRowEvents(
			ICTSServiceIntegration serviceIntegration,
			Parameter.TYPEEXECUTION typeExecution) {
		super(serviceIntegration);
		this.typeExecution = typeExecution;

		this.writeLog(
				"ReadjustmentLoanGridRowEvents ("
						+ this.typeExecution.toString() + ")",
				Parameter.LEVELDEBUG.INFO);
	}

	@Override
	public void rowAction(DataEntity entities, IGridRowActionEventArgs args) {
		this.writeLog("Inicio rowAction [" + this.typeExecution.toString()
				+ "] (ReadjustmentLoanGridRowEvents)",
				Parameter.LEVELDEBUG.DEBUG);

		Map<String, Object> result = new HashMap<String, Object>();
		DataEntityList listado = new DataEntityList();
		Boolean resultado = false;

		try {
			GeneralFunctionReadjustment generador = new GeneralFunctionReadjustment(
					getServiceIntegration());

			result = generador.eventGenerator(entities, args
					.getDynamicRequest().getEntity(Loan.ENTITY_NAME),
					this.typeExecution);

			resultado = GeneralFunction.writeResult(result, this.typeExecution,
					args);
			args.setCancel(!resultado);
			args.getDynamicRequest().setEntityList(
					ReadjustmentLoanCab.ENTITY_NAME, listado);
		} catch (Exception ex) {
			LOGGER.logError(ex);
		} finally {
			this.writeLog("FIN rowAction [" + this.typeExecution.toString()
					+ "] (ReadjustmentLoanGridRowEvents)",
					Parameter.LEVELDEBUG.DEBUG);
		}
	}

	private void writeLog(String message, Parameter.LEVELDEBUG level) {
		if (LOGGER.isDebugEnabled()) {
			switch (level) {
			case DEBUG:
				LOGGER.logDebug(message);
				break;
			case ERROR:
				LOGGER.logError(message);
				break;
			default:
				LOGGER.logInfo(message);
				break;
			}
		}
	}
}
