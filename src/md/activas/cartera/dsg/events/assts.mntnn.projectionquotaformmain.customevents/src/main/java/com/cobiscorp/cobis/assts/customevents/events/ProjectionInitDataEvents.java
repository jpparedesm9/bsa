package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

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

public class ProjectionInitDataEvents extends BaseEvent implements
		IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(ProjectionInitDataEvents.class);

	public ProjectionInitDataEvents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities,
			IDataEventArgs eventArgs) {
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

		DataEntity loanSession = (DataEntity) AssetsSessionManager
				.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));

		logger.logDebug("Header>>>>>>>-> "
				+ loanInstance.get(LoanInstancia.IDINSTANCIA));

		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}

	}

}
