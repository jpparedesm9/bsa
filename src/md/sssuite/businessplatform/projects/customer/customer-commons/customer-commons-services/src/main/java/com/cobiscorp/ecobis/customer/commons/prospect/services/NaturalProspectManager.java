package com.cobiscorp.ecobis.customer.commons.prospect.services;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class NaturalProspectManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(NaturalProspectManager.class);

	public NaturalProspectManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Integer insertNaturalProspect(NaturalProspectRequest naturalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		LOGGER.logDebug("Start insertNaturalProspectManager");

		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.NATURAL_PROSPECTREQUEST, naturalProspectRequest, ServiceId.INSERT_NATURAL_PROSPECT, Outputs.PROSPECTID, arg1);
		LOGGER.logDebug("Finish insertNaturalProspectManager");
		return object == null ? null : Integer.valueOf(String.valueOf(object));

	}

	public Integer updateNaturalProspect(NaturalProspectRequest naturalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.NATURAL_PROSPECTREQUEST, naturalProspectRequest, ServiceId.UPDATE_NATURAL_PROSPECT, Outputs.PROSPECTID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));

	}

	public HashMap<String, String> createNaturalProspectAndSpouse(NaturalProspectRequest naturalProspectRequest, SpouseProspectRequest spouseProspectRequest, ICommonEventArgs arg1)
			throws BusinessException {

		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.NATURAL_PROSPECTREQUEST, naturalProspectRequest);
		requests.put(RequestName.SPOUSE_REQUEST, spouseProspectRequest);
		return callService.callServiceWithInputMapAndOutputMap(requests, ServiceId.CREATE_NATURAL_PROSPECT, arg1);

	}



	public HashMap<String, String> queryActivations(NaturalProspectRequest naturalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.NATURAL_PROSPECTREQUEST, naturalProspectRequest);
		return callService.callServiceWithInputMapAndOutputMap(requests, ServiceId.QUERY_ACTIVATION, arg1);
	}

	public void updateAltairAccount(NaturalProspectRequest naturalProspectRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.NATURAL_PROSPECTREQUEST, naturalProspectRequest, ServiceId.UPDATE_ALTAIR, arg1);

	}
}
