package com.cobiscorp.ecobis.customer.services;

import java.util.List;



import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;

public interface PhoneTxService {
	
	/**
	* Method for search phones given Idcustomer  
	* @author 
	**/	
	
	public List<PhoneDataResponse> getPhonebyCustomer(CustomerDataRequest request);
	

	/**
	* Method for search phones given IdCustomer and IdAddress  
	* @author 
	**/
	public List<PhoneDataResponse> getPhonebyCustomerAndAddress(PhoneDataRequest request);
	
}
