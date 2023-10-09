package com.cobiscorp.cobis.busin.view.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.bli.VW_ORIAHEADER86_BLI;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_ORIAHEADER8602_OQUE134 extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeVA_ORIAHEADER8602_OQUE134.class);

	public ChangeVA_ORIAHEADER8602_OQUE134(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso IChangedEvent -> ChangeVA_ORIAHEADER8602_OQUE134");

			VW_ORIAHEADER86_BLI.changeAmountRequested(entities, args, super.getServiceIntegration());

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida IChangedEvent -> ChangeVA_ORIAHEADER8602_OQUE134");
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CHANGE_MONTO_134, e, args, LOGGER);
		}
	}

}