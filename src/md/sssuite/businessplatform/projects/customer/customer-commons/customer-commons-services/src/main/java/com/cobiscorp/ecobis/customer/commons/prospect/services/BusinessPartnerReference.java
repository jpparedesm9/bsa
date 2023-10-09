package com.cobiscorp.ecobis.customer.commons.prospect.services;

import java.util.HashMap;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;

public class BusinessPartnerReference extends BaseEvent{
    private static final ILogger LOGGER = LogFactory.getLogger(BusinessPartnerReference.class);

	public BusinessPartnerReference(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

    public PurchaseReferenceResponse queryReferenceStatus(PurchaseReferenceRequest aPurchaseReferenceReq, ICommonEventArgs arg1) throws BusinessException{
		CallServices callService = new CallServices(getServiceIntegration());
		PurchaseReferenceResponse[] purchRefResp = callService.callServiceWithReturnArray(
				RequestName.PURCH_REF_REQUEST, aPurchaseReferenceReq, ServiceId.QUERY_PURCHASE_REFERENCE,
				ReturnName.PURCH_REF_RESPONSE, arg1);
		return purchRefResp == null ? new PurchaseReferenceResponse() : purchRefResp[0];
    }

    public HashMap<String, String> validateReference(PurchaseReferenceRequest aPurchaseReferenceReq, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.PURCH_REF_REQUEST, aPurchaseReferenceReq);
		return callService.callServiceWithInputMapAndOutputMap(requests, ServiceId.VALIDATE_REFERENCE, arg1);
	}

    public HashMap<String, String> purchaseConfirmation(PurchaseReferenceRequest aPurchaseReferenceReq, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.PURCH_REF_REQUEST, aPurchaseReferenceReq);
		return callService.callServiceWithInputMapAndOutputMap(requests, ServiceId.EXECUTE_PURCHASE_CONFIRMATION, arg1);
	}
    

}