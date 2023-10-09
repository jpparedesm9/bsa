package com.cobiscorp.cobis.busin.customevents.change;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.AmortizationTableManagement;
import com.cobiscorp.cobis.busin.model.PaymentPlan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangePaymentFrecuencyAmortization extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangePaymentFrequency.class);

	public ChangePaymentFrecuencyAmortization(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {

		try {
			LOGGER.logDebug("---->Entra al ChangePaymentFrequency");

			DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);

			String paymentFrequency = args.getNewValue() == null ? "" : (String) args.getNewValue();
			Integer plazo = paymentPlan.get(PaymentPlan.TERM) == null ? 0 : paymentPlan.get(PaymentPlan.TERM);

			AmortizationTableManagement amortizationTableManagement = new AmortizationTableManagement(getServiceIntegration());
			amortizationTableManagement.validateTermAndPaymentFrecuency(paymentFrequency, plazo, paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE), entities, args);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_FRECUENCYAMORTIZATION, e, args, LOGGER);
		}

	}
}
