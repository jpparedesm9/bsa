package com.cobiscorp.ecobis.customer.commons.prospect.services;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.LegalProspectRequest;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class LegalProspectManager extends BaseEvent {

	public LegalProspectManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Integer insertLegalProspect(LegalProspectRequest legalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.LEGAL_PROSPECTREQUEST, legalProspectRequest, ServiceId.INSERT_LEGAL_PROSPECT, Outputs.PROSPECTID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}

	public Integer updateLegalProspectManager(LegalProspectRequest legalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		// TODO Auto-generated method stub
		return null;
	}

	public HashMap<String, String> createLegalProspect(LegalProspectRequest legalProspectRequest, ICommonEventArgs arg1) throws BusinessException {

		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.LEGAL_PROSPECTREQUEST, legalProspectRequest);
		return callService.callServiceWithInputMapAndOutputMap(requests, ServiceId.CREATE_LEGAL_PROSPECT, arg1);

	}

}
