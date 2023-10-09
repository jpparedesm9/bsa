package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.parameter.GeneralFunctionReadjustmentDetails;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentDetalilsLoan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentDetalilsLoanGridRowEvents extends BaseEvent implements
		IGridRowUpdating, IGridRowDeleting {
	private Parameter.TYPEEXECUTION typeExecution;

	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentDetalilsLoanGridRowEvents.class);

	public ReadjustmentDetalilsLoanGridRowEvents(
			ICTSServiceIntegration serviceIntegration,
			Parameter.TYPEEXECUTION typeExecution) {
		super(serviceIntegration);
		this.typeExecution = typeExecution;

		if (logger.isDebugEnabled()) {
			logger.logInfo("ReadjustmentDetalilsLoanGridRowEvents ("
					+ this.typeExecution.toString() + ")");
		}
	}

	@Override
	public void rowAction(DataEntity entities, IGridRowActionEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO EVENTO rowAction ("
					+ this.typeExecution.toString()
					+ ") (ReadjustmentDetalilsLoanGridRowEvents)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		DataEntityList listado = new DataEntityList();
		Boolean resultado = false;

		try {
			GeneralFunctionReadjustmentDetails generador = new GeneralFunctionReadjustmentDetails(
					getServiceIntegration());

			result = generador.eventGenerator(
					entities,
					args.getDynamicRequest().getEntity(
							ReadjustmentLoanCab.ENTITY_NAME), args
							.getDynamicRequest().getEntity(Loan.ENTITY_NAME),
					this.typeExecution);

			listado = (DataEntityList) result.get(Parameter.RESULTLIST);
			resultado = GeneralFunction.writeResult(result, this.typeExecution,
					args);

			args.setCancel(!resultado);
			args.getDynamicRequest().setEntityList(
					ReadjustmentDetalilsLoan.ENTITY_NAME, listado);
		} catch (Exception ex) {
			logger.logError(ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("FIN EVENTO rowAction("
						+ this.typeExecution.toString()
						+ ") (ReadjustmentDetalilsLoanGridRowEvents)");
			}
		}
	}
}
