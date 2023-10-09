package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.DisbursementReports;
import com.cobiscorp.cobis.assts.model.ProcessInstance;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoanGroup extends BaseEvent implements
com.cobiscorp.designer.api.customization.IExecuteCommand {
	private static final ILogger logger = LogFactory
			.getLogger(LoanGroup.class);

	public LoanGroup(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeCommand GroupTransaction");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		String idBank;

		DataEntity group = entities.getEntity(DisbursementReports.ENTITY_NAME);
		
		LoanRequest groupLoanGroupRequest = new LoanRequest();
		idBank = group.get(DisbursementReports.CODE);

		groupLoanGroupRequest.setCode(idBank);

		if (logger.isDebugEnabled()) {
			logger.logDebug("group.get(DisbursementReports.CODE) --> "
					+ group.get(DisbursementReports.CODE));
		}

		request.addValue("inLoanRequest", groupLoanGroupRequest);
		response = this.execute(getServiceIntegration(), logger,
				Parameter.PROCESSUPDATELOANGROUP, request);

		GeneralFunction.handleResponse(args, response, null);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();			
		}
	}
}
