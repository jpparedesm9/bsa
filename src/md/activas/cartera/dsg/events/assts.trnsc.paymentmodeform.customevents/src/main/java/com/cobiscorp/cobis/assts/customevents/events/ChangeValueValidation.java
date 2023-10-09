package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ChangeValueValidation extends BaseEvent implements IChangedEvent {
	private static final ILogger logger = LogFactory
			.getLogger(ChangeValueValidation.class);

	public ChangeValueValidation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities,
			IChangedEventArgs changedEventArgs) {
		DataEntity paymentForm = entities.getEntity(PaymentForm.ENTITY_NAME);
		String difference;
		if (paymentForm != null
				&& paymentForm.get(PaymentForm.PAYAMOUNT) != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ PaymentForm.PAYAMOUNT="
						+ paymentForm.get(PaymentForm.PAYAMOUNT));
				logger.logDebug("WATQ CustomParameters= "
						+ changedEventArgs.getParameters()
								.getCustomParameters().values());
				logger.logDebug("WATQ entities= " + entities.getData());
			}
			if (changedEventArgs.getParameters().getCustomParameters()
					.get("difference").toString() != "") {
				difference = changedEventArgs.getParameters()
						.getCustomParameters().get("difference").toString();
				if (paymentForm.get(PaymentForm.PAYAMOUNT).compareTo(
						new BigDecimal(difference)) == 1) {
					paymentForm.set(PaymentForm.PAYAMOUNT, new BigDecimal(
							difference));
				}
			}
			entities.setEntity(PaymentForm.ENTITY_NAME, paymentForm);
		}
	}
}
