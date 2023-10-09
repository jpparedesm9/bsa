package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.UtilDisbursement;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoadPaymentFormCategory extends BaseEvent implements IChangedEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoadPaymentFormCategory.class);

	public LoadPaymentFormCategory(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		DataEntity paymentForm = null;
		DataEntity loanInf = null;
		String paymentFormCategory;
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ LoadPaymentFormCategory.changed :: entities= "
					+ entities.getData());
		}
		if (entities.getEntity(PaymentForm.ENTITY_NAME) != null) {
			paymentForm = entities.getEntity(PaymentForm.ENTITY_NAME);
		}
		if (entities.getEntity(Loan.ENTITY_NAME) != null) {
			loanInf = entities.getEntity(Loan.ENTITY_NAME);
		}

		UtilDisbursement utils = new UtilDisbursement(
				this.getServiceIntegration());
		paymentFormCategory = utils
				.getPaymentFormCategory(paymentForm, loanInf);

		if (paymentFormCategory != null && paymentForm != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ LoadPaymentFormCategory.changed :: paymentFormCategory= "
						+ paymentFormCategory);
				logger.logDebug("WATQ LoadPaymentFormCategory.changed :: productValidTypeA= "
						+ Parameter.getProductValidTypeA());
			}
			if (utils.useLoop(Parameter.getProductValidTypeA(), paymentFormCategory)) {
				paymentForm.set(PaymentForm.PAYFORMCATEGORY,
						paymentFormCategory);
			} else {
				paymentForm.set(PaymentForm.PAYFORMCATEGORY,
						Parameter.EMPTY_VALUE);
			}
			entities.setEntity(PaymentForm.ENTITY_NAME, paymentForm);
		}
	}
}
