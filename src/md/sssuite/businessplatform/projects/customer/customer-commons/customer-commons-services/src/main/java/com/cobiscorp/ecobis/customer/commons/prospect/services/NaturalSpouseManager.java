package com.cobiscorp.ecobis.customer.commons.prospect.services;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class NaturalSpouseManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(NaturalSpouseManager.class);

	public NaturalSpouseManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public HashMap<String, String> createNaturalSpouse(SpouseProspectRequest spouseProspectRequest, ICommonEventArgs arg1)
			throws BusinessException {

		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.SPOUSE_REQUEST, spouseProspectRequest);
		return callService.callServiceWithInputMapAndOutputMap(requests,  ServiceId.INSERT_SPOUSE_PROSPECT, arg1);
		
	}
	
	public SpouseProspectResponse searchSpouse(SpouseProspectRequest spouseRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		SpouseProspectResponse spouse = (SpouseProspectResponse) callService.callServiceWithReturn(RequestName.SPOUSE_REQUEST, spouseRequest, ServiceId.SEARCH_SPOUSE_PROSPECT,
				ReturnName.SPOUSE_REQUEST, arg1);
		return (SpouseProspectResponse) spouse ;
	}
	
	/*public Integer updateNaturalSpouse(SpouseProspectRequest naturalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.SPOUSE_REQUEST, naturalProspectRequest, ServiceId.UPDATE_SPOUSE_PROSPECT, Outputs.PROSPECTID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));

	}*/

}
