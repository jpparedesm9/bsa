package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.AmortizationTable;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ImplementsAmortizationTable extends BaseEvent implements
		IInitDataEvent {

	public ImplementsAmortizationTable(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		}

	private static final ILogger logger = LogFactory
			.getLogger(ImplementsAmortizationTable.class);

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
			if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al executeDataEvent>>>");
		}

		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

		DataEntity loanSession = (DataEntity) AssetsSessionManager
				.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));

		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}

		AmortizationTable amortizacion = new AmortizationTable(
				this.getServiceIntegration());
		amortizacion.amortizationQuery(entities);
		

		if (getServiceIntegration() == null && logger.isDebugEnabled()) {
			logger.logInfo("-->LoadQueries ServiceIntegration >>>>> ");
		}
	}

}
