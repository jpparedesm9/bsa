package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CompanyRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CompanyResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.LegalPersonRequest;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class LegalPersonManager extends BaseEvent {

	public LegalPersonManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void updateLegalPerson(LegalPersonRequest legalPersonRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.LEGAL_PERSON_REQUEST, legalPersonRequest, ServiceId.UPDATE_LEGAL_PERSON, arg1);
	}

	public CompanyResponse findLegalPerson(CompanyRequest companyRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		CompanyResponse companyResponse = (CompanyResponse) callService.callServiceWithReturn(RequestName.COMPANY_REQUEST, companyRequest, ServiceId.FIND_LEGAL_PERSON,
				ReturnName.COMPANY_RESPONSE, arg1);
		return companyResponse;
	}

}
