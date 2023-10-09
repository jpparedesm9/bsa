package com.cobiscorp.cobis.assts.customevents.events;

import java.util.concurrent.ExecutionException;

import cobiscorp.ecobis.assets.cloud.dto.ResourceRequest;
import cobiscorp.ecobis.assets.cloud.dto.ResourceResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Fund;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class FundResourcesQuery extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(FundResourcesQuery.class);

	public FundResourcesQuery(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public DataEntityList searchFundResources(DynamicRequest entities) throws ExecutionException {

		ResourceResponse[] resourcesList=null;
		DataEntityList resourcesEntList = new DataEntityList();
	
		Integer fundId = 0; 
		Integer resourceListLength = 0;
	
		ServiceRequestTO requestTo = new ServiceRequestTO();
		ResourceRequest resourceRequest = new ResourceRequest();
		resourceRequest.setFundId(fundId);
		resourceRequest.setMode(fundId == 0 ? 0 : 1);

		requestTo.addValue("inResourceRequest", resourceRequest);

		if (logger.isDebugEnabled()) {
			logger.logDebug("FundResourcesQuery.searchFundResources(..) --> entities= "
					+ entities.getData());
		}

		do{
			ServiceResponse serviceResponse = this.execute(logger,
					Parameter.SERVICE_SEARCH_FUND_RESOURCES, requestTo);

			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
						.getData();
				resourcesList = (ResourceResponse[]) serviceResponseTO
						.getValue("returnResourceResponse");
				if (logger.isDebugEnabled()) {
					logger.logDebug("ServiceResponseTO --> "
							+ serviceResponseTO.toString());
				}
				for (ResourceResponse r : resourcesList) {
					DataEntity resourceEnt = new DataEntity();
					resourceEnt.set(Fund.FUNDID, r.getFundId());
					resourceEnt.set(Fund.FUNDNAME, r.getFundName());
					resourceEnt.set(Fund.SPONSORID, r.getResourceId());
					resourceEnt.set(Fund.AMOUNTSOURCE, r.getAmount());
					resourceEnt.set(Fund.AVAILABLEBALANCE, r.getAvailableBalance());
					resourceEnt.set(Fund.USEDVALUE, r.getUsed());
					resourceEnt.set(Fund.STATUSCODE,r.getStatus().charAt(0));
					resourceEnt.set(Fund.VALIDITYDATE,
							GeneralFunction.convertCalendarToDate(r.getEffectiveDate()));
					
					if (logger.isDebugEnabled()) {
						logger.logDebug("FundResourcesQuery.searchFundResources(..) --> FundId= "
								+ r.getFundId());
					}
					resourcesEntList.add(resourceEnt);
				}
				if (resourcesList!=null  && resourcesList.length>0 && resourcesList[resourcesList.length-1]!= null){
					resourceListLength = resourcesList.length;
					
					resourceRequest.setFundId(resourcesList[resourcesList.length-1].getFundId());
				}
			}
			
		}while(resourceListLength==Parameter.REGISTERS_FOR_PAGE);
		
		

		return resourcesEntList;
	}


}
