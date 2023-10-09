package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ResourceRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Fund;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CreateFunds extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory
			.getLogger(CreateFunds.class);

	public CreateFunds(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		
		String service;
		String fundStatus;
		
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity fund = entities.getEntity(Fund.ENTITY_NAME);

		ResourceRequest resourceRequest = new ResourceRequest();
		
		if (fund.get(Fund.FUNDID)!= null && fund.get(Fund.FUNDID)!=0){
			service = Parameter.SERVICE_FUND_UPDATE;
			resourceRequest.setFundId(fund.get(Fund.FUNDID));
			fundStatus=fund.get(Fund.STATUSCODE).toString();
		}else{
			service = Parameter.SERVICE_FUND_INSERT;
			fundStatus = Parameter.STRING_V;
		}
		
		if (logger.isDebugEnabled()){
			logger.logDebug("service: "+service);
		}
			

		resourceRequest.setFunder(fund.get(Fund.SPONSORID));
		resourceRequest.setStatus(fundStatus);
		resourceRequest.setFundName(fund.get(Fund.FUNDNAME));
		resourceRequest.setEffectiveDate(GeneralFunction.convertDateToCalendar(fund.get(Fund.VALIDITYDATE)));
		resourceRequest.setAmount(fund.get(Fund.AMOUNTSOURCE));

		request.addValue("inResourceRequest", resourceRequest);

		ServiceResponse response = this.execute(logger,
				service, request);
		
		GeneralFunction.handleResponse(args, response, null);

	}
}
