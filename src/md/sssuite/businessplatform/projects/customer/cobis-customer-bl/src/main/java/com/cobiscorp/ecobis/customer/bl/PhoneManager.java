package com.cobiscorp.ecobis.customer.bl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;



public interface PhoneManager {
	
	public List<PhoneDataResponse> getPhonebyCustomer(CustomerDataRequest request);
	public List<PhoneDataResponse> getPhonebyCustomerAndAddress(PhoneDataRequest request);

}
