package com.cobiscorp.cobis.assts.customevents.events;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.customevents.parameter.GeneralFunctionReadjustment;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentLoanManager extends BaseEvent implements
		IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentLoanManager.class);

	public ReadjustmentLoanManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO EVENTO executeDataEvent (ReadjustmentLoanManager)");
		}

		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

		DataEntity loanSession = (DataEntity) AssetsSessionManager
				.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));

		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("entidad>>>" + entities);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		DataEntityList listado = new DataEntityList();

		try {
			GeneralFunctionReadjustment generador = new GeneralFunctionReadjustment(
					getServiceIntegration());

			result = generador.eventGenerator(entities,
					Parameter.TYPEEXECUTION.SEARCH);

			if (GeneralFunction.writeResult(result,
					Parameter.TYPEEXECUTION.SEARCH, args)) {
				listado = (DataEntityList) result.get(Parameter.RESULTLIST);
				entities.setEntityList(ReadjustmentLoanCab.ENTITY_NAME, listado);
			}

		} catch (Exception ex) {
			logger.logError(ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("FIN EVENTO executeDataEvent (ReadjustmentLoanManager)");
			}
		}
	}
}
