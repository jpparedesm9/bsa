package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.PreCancellationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.PreCancellation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchPrecancellation extends BaseEvent implements
		com.cobiscorp.designer.api.customization.IExecuteCommand {

	private static final ILogger LOGGER = LogFactory
			.getLogger(SearchPrecancellation.class);

	public SearchPrecancellation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia executeCommand SearchPrecancellation");
		}
		
		
		try {
			args.setSuccess(true);
			ServiceRequestTO request = new ServiceRequestTO();
			ServiceResponse response = null;
			DataEntity clientID = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity precancellation = entities.getEntity(PreCancellation.ENTITY_NAME);

			LoanRequest loanRequest = new LoanRequest();
			loanRequest.setClient(clientID.get(Loan.CLIENTID));

			request.addValue("inLoanRequest", loanRequest);
			response = this.execute(getServiceIntegration(), LOGGER,
					Parameter.SEARCH_PRECANCELLATION, request);

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (resultado.isSuccess()) {
					
					PreCancellationResponse precancellationResponse = (PreCancellationResponse) resultado.getValue("returnPreCancellationResponse");
					
					precancellation.set(PreCancellation.AMOUNTOP, new BigDecimal(precancellationResponse.getAmountOP()));
					precancellation.set(PreCancellation.AMOUNTPRE, new BigDecimal(precancellationResponse.getAmountPRE()));
					precancellation.set(PreCancellation.AMOUNTINSURENCE,new BigDecimal(precancellationResponse.getAmountInsurence()));				
					LOGGER.logDebug("precancellationResponse.getIsInsurenceChanged() >>>"+ precancellationResponse.getIsInsurenceChanged().toString());
					precancellation.set(PreCancellation.ISINSURENCECHANGED, ("S".equals(precancellationResponse.getIsInsurenceChanged()) ? true : false));
					
					//LOGGER.logDebug("precancellation.set(PreCancellation.ISINSURENCECHANGED >>>"	+ precancellation.get(PreCancellation.ISINSURENCECHANGED));
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Assets.SEARCH_PRECANCELATION, e, args, LOGGER);
		}
		

	}

}
