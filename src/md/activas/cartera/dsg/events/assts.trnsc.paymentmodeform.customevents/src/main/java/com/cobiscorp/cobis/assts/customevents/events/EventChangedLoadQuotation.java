package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.HeaderLoanResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.UtilFunction;
import com.cobiscorp.cobis.assts.model.LoanAdditionalInformation;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class EventChangedLoadQuotation extends BaseEvent implements
		IChangedEvent {
	private static final ILogger logger = LogFactory
			.getLogger(EventChangedLoadQuotation.class);

	public EventChangedLoadQuotation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		HeaderLoanResponse detailLoanRequest = new HeaderLoanResponse();
		UtilFunction utilFunc = new UtilFunction(this.getServiceIntegration());

		DataEntity paymentForm = new DataEntity();

		if (logger.isDebugEnabled()) {
			logger.logDebug("entities= " + entities.getData());
		}

		if (entities.getEntity(PaymentForm.ENTITY_NAME) != null) {
			paymentForm = entities.getEntity(PaymentForm.ENTITY_NAME);
		}

		detailLoanRequest.setAmountOpt(paymentForm.get(PaymentForm.PAYAMOUNT)
				.doubleValue());
		detailLoanRequest.setCurrency(paymentForm.get(PaymentForm.CURRENCYID));

		DataEntity loanAddInf = utilFunc
				.getQuotationCurrency(detailLoanRequest);

		if (loanAddInf != null) {
			entities.setEntity(LoanAdditionalInformation.ENTITY_NAME,
					loanAddInf);

			logger.logDebug("WATQ paymentForm= " + paymentForm.getData());
			logger.logDebug("WATQ loanAddInf= " + loanAddInf.getData());
		}

	}

}
