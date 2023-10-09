package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.ProspectReportResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.ProspectResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class ProspectManager extends BaseEvent {

	public ProspectManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public int searchByIdentificationAndIdentificationType(String identification, String identificationType, ICommonEventArgs arg1) throws BusinessException {
		ProspectRequest prospectRequest = new ProspectRequest();
		prospectRequest.setDocumentId(identification);
		prospectRequest.setDocumentType(identificationType);
		CallServices callService = new CallServices(getServiceIntegration());
		ProspectResponse prospectResponse = (ProspectResponse) callService.callServiceWithReturn(RequestName.PROSPECT_REQUEST, prospectRequest, ServiceId.SEARCH_BY_IDENTIFICATION,
				ReturnName.RETURNPROSPECTRESPONSE, arg1);
		return prospectResponse == null ? 1 : Integer.valueOf(String.valueOf(prospectResponse.getProspectExists()));

	}

	public ProspectReportResponse queryReportBureau(NaturalProspectRequest prospectRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		ProspectReportResponse queryReportResponse = (ProspectReportResponse) callService.callServiceWithReturn(RequestName.NATURAL_PROSPECTREQUEST, prospectRequest, ServiceId.QUERY_REPORT_BUREAU, ReturnName.REPORTBUREAU_RESPONSE, arg1);
		return queryReportResponse;
	}
}
