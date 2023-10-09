package com.cobiscorp.ecobis.customer.commons.prospect.services;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;

public class AddressManager extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(AddressManager.class);

	public AddressManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Integer createAddress(AddressRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		addressRequest.setChannel("CWC");
		Object object = callService.callServiceWithOutput(RequestName.ADDRESS_REQUEST, addressRequest, ServiceId.CREATE_ADDRESS, Outputs.ADDRESSID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}

	public void updateAddress(AddressRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		addressRequest.setChannel("CWC");
		callService.callService(RequestName.ADDRESS_REQUEST, addressRequest, ServiceId.UPDATEADDRESSSERVICE, arg1);

	}

	public Integer updateAddressResp(AddressRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		addressRequest.setChannel("CWC");
		Object object = callService.callServiceWithOutput(RequestName.ADDRESS_REQUEST, addressRequest, ServiceId.UPDATEADDRESSSERVICE, Outputs.ADDRESSID, arg1);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}

	public void deleteAddress(AddressRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		addressRequest.setChannel("CWC");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.ADDRESS_REQUEST, addressRequest, ServiceId.DELETE_ADDRESS, arg1);
	}

	public AddressResp[] searchAddresses(AddressRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		AddressResp[] addresses = callService.callServiceWithReturnArray(RequestName.ADDRESS_REQUEST, addressRequest, ServiceId.SEARCH_ADDRESS_PROSPECT,
				ReturnName.ADDRESS_RESPONSE, arg1);
		return addresses == null ? new AddressResp[0] : addresses;
	}

	public AddressResponse searchZipCode(AddressRequest zipcodeRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		return (AddressResponse) callService.callServiceWithReturn(RequestName.ADDRESS_REQUEST, zipcodeRequest, ServiceId.SEARCH_ZIP_POSTAL, ReturnName.ZIPCODE_RESPONSE, arg1);
	}

	public AddressResponse findZipCode(AddressRequest zipcodeRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		return (AddressResponse) callService.callServiceWithReturn(RequestName.ADDRESS_REQUEST, zipcodeRequest, ServiceId.FIND_ZIP_POSTAL, ReturnName.ZIPCODE_RESPONSE, arg1);
	}

	public void validateDuplicateAddress(AddressRequest addressRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.ADDRESS_REQUEST, addressRequest, ServiceId.VALIDATE_ADDRESS, arg1);

	}

	public void updateState(CustomerRequest customerRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.CUSTOMER_REQUEST, customerRequest, ServiceId.UPDATE_STATE, arg1);
	}

}
