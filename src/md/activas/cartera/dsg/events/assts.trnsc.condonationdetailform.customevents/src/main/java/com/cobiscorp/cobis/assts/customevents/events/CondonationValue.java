package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.CondonationDetail;
import com.cobiscorp.cobis.assts.model.ServerParameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CondonationValue extends BaseEvent implements IChangedEvent {
	private static final ILogger logger = LogFactory
			.getLogger(CondonationValue.class);

	public CondonationValue(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("INICIO CondonationValue->changed");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(ServerParameter.ENTITY_NAME);
		DataEntityList condonationList = entities
				.getEntityList(CondonationDetail.ENTITY_NAME);

		int selectedRow = loan.get(ServerParameter.SELECTEDROW);
		DataEntity condonation = condonationList.get(selectedRow);

		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setBank(loan.get(ServerParameter.LOANBANKID));
		loanRequest.setConcept(condonation.get(CondonationDetail.CONCEPT));
		loanRequest.setInterestPeriod(condonation
				.get(CondonationDetail.PERCENTAGE));

		request.addValue("inLoanRequest", loanRequest);
		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, "Loan.ProductListCredit.CalculateValueToCondone",
				request);

		if (response != null && response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();

			LoanResponse[] clResponseList = (LoanResponse[]) resultado
					.getValue("returnLoanResponse");

			for (LoanResponse r : clResponseList) {
				loan.set(ServerParameter.AMOUNT, r.getAmount());
			}
			entities.setEntity(ServerParameter.ENTITY_NAME, loan);
		}
		arg1.setSuccess(true);		
	}

}
