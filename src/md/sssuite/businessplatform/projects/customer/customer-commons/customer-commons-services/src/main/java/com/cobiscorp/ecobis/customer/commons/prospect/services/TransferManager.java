package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AccountPriorityRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AccountPriorityResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficeResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.TransferRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.TransferResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class TransferManager extends BaseEvent{

	public TransferManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CustomerResponse[] searchCustomerByOfficial(CustomerRequest customerRequest, OfficialRequest officialRequest,  ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		CustomerResponse customerResponse[] = (CustomerResponse[]) callService.callServiceWithReturnArray(RequestName.CUSTOMER_REQUEST, 
				customerRequest, RequestName.OFFICIAL_REQUEST, officialRequest, ServiceId.SEARCH_CUSTOMER, ReturnName.CUSTOMER_RESPONSE, arg1);
		return customerResponse;

	}
	
	public OfficialResponse[] searchOfficial(OfficialRequest officialRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		OfficialResponse officialResponse[] = (OfficialResponse[]) callService.callServiceWithReturnArray(RequestName.OFFICIAL_REQUEST, officialRequest, ServiceId.SEARCH_OFFICIAL,
				ReturnName.OFFICIAL_RESPONSE, arg1);
		return officialResponse;

	}
	
	public OfficeResponse[] searchOffice(String official, ICommonEventArgs arg1) throws BusinessException {
		OfficialRequest officialRequest = new OfficialRequest();
		officialRequest.setLogin(official);
		CallServices callService = new CallServices(getServiceIntegration());
		OfficeResponse officeResponse[] = (OfficeResponse[]) callService.callServiceWithReturnArray(RequestName.OFFICIAL_REQUEST, officialRequest, ServiceId.SEARCH_OFFICE,
				ReturnName.OFFICE_RESPONSE, arg1);
		return officeResponse;
	}
	
	public void createRequestTransfer(int officeOrg, String officialOrg, char isGroup,int officeDes, String  officialDes, int reason, String customers, String anotherReason,  ICommonEventArgs arg1) throws BusinessException {
		TransferRequest transferRequest = new TransferRequest();
		transferRequest.setOfficeOrg(officeOrg);
		transferRequest.setOfficialOrg(officialOrg);
		transferRequest.setIsGroup(isGroup);
		transferRequest.setOfficeDes(officeDes);
		transferRequest.setOfficialDes(officialDes);
		transferRequest.setCause(reason);
		transferRequest.setDesCause(anotherReason);
		transferRequest.setCustomers(customers);
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.TRANSFER_REQUEST, transferRequest, ServiceId.CREATE_REQUEST_TRANSFER, arg1);
	}
	
	public TransferResponse[] searchTransferRequest(int office, ICommonEventArgs arg1) throws BusinessException {
		TransferRequest transferRequest = new TransferRequest();
		transferRequest.setOfficeOrg(office);
		CallServices callService = new CallServices(getServiceIntegration());
		TransferResponse transferResponse[] = (TransferResponse[]) callService.callServiceWithReturnArray(RequestName.TRANSFER_REQUEST, transferRequest, ServiceId.SEARCH_REQUEST_TRANSFER,
				ReturnName.TRANSFER_RESPONSE, arg1);
		return transferResponse;
	}
	
	public CustomerResponse[] searchTransferDetailRequest(TransferRequest transferRequest, ICommonEventArgs arg1) throws BusinessException {
		
		CallServices callService = new CallServices(getServiceIntegration());
		CustomerResponse[] transferDetail = callService.callServiceWithReturnArray(RequestName.TRANSFER_REQUEST, transferRequest, ServiceId.AUTH_TRANSFER_DETAIL,
				ReturnName.CUSTOMER_RESPONSE, arg1);
		return transferDetail == null ? new CustomerResponse[0] : transferDetail;
	}
	
	public void authorizeRequestTransfer(TransferRequest transferRequest,  ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.TRANSFER_REQUEST, transferRequest, ServiceId.AUTH_REQUEST_TRANSFER, arg1);
	}
	public void refuseRequestTransfer(TransferRequest transferRequest,  ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.TRANSFER_REQUEST, transferRequest, ServiceId.REFU_REQUEST_TRANSFER, arg1);
	}
	
	public AccountPriorityResponse[] searchAccountPriority(AccountPriorityRequest accountRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		AccountPriorityResponse productResponse[] = (AccountPriorityResponse[]) callService.callServiceWithReturnArray(RequestName.ACCOUNT_PRIORITY_REQUEST, accountRequest, ServiceId.ACCOUNT_PRIORITY,
				ReturnName.ACCOUNT_PRIORITY_RESPONSE, arg1);
		return productResponse;

	}
}
