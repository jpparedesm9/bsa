package com.cobiscorp.ecobis.business.commons.platform.services;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ReturnName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loansbusiness.dto.ClientInsuranceResponse;
import cobiscorp.ecobis.loansbusiness.dto.InsuranceRequest;
import cobiscorp.ecobis.loansbusiness.dto.InsuranceResponse;

public class InsuranceManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InsuranceManager.class);

	public InsuranceManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public InsuranceResponse[] queryInsurance(ICTSServiceIntegration serviceIntegration, ICommonEventArgs arg1,
			String product) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start queryInsurance in class InsuranceManager");
		InsuranceRequest insuranceRequest = new InsuranceRequest();
		insuranceRequest.setSeProducto(product);

		CallServices callServices = new CallServices(getServiceIntegration());
		return (InsuranceResponse[]) callServices.callServiceWithReturn(RequestName.IN_INSURANCE_REQUEST,
				insuranceRequest, ServiceId.QUERY_INSURANCE, ReturnName.RETURN_INSURANCE_RESPONSE, arg1);
	}

	public void maintainInsurance(ICTSServiceIntegration serviceIntegration, ICommonEventArgs arg1,
			InsuranceRequest insuranceRequest) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start maintainInsurance in class InsuranceManager");

		CallServices callServices = new CallServices(getServiceIntegration());
		callServices.callService(RequestName.IN_INSURANCE_REQUEST, insuranceRequest, ServiceId.MAINTAIN_INSURANCE,
				arg1);
	}
	
	public ClientInsuranceResponse getClientInsurance(ICTSServiceIntegration serviceIntegration, ICommonEventArgs arg1,
			InsuranceRequest insuranceRequest) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start getClientInsurance in class InsuranceManager");

		CallServices callServices = new CallServices(getServiceIntegration());
		return (ClientInsuranceResponse) callServices.callServiceWithReturn(RequestName.IN_INSURANCE_REQUEST,
				insuranceRequest, ServiceId.GET_CLIENT_INSURANCE, ReturnName.RETURN_CLIENT_INSURANCE_RESPONSE, arg1);
	}
}
