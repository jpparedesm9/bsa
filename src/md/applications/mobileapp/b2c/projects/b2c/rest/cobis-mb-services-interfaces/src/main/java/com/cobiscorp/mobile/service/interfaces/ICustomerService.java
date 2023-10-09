package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Address;
import com.cobiscorp.mobile.model.AddressResponse;
import com.cobiscorp.mobile.model.Customer;

public interface ICustomerService {

	void updateProspect(Customer customer, String cobisSessionId) throws MobileServiceException;

	AddressResponse createAddress(Address addressRequest, String cobisSessionId) throws MobileServiceException;

	String getCurpByCustomerId(Integer customerId, String cobisSessionId) throws MobileServiceException;

}
