package com.cobiscorp.ecobis.customer.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;

public interface PhoneTxService {
	// el
	public ServiceResponse getPhonebyCustomer(CustomerDataRequest request) throws ParseException;

	public ServiceResponse getPhonebyCustomerAndAddress(PhoneDataRequest request) throws ParseException;

}
