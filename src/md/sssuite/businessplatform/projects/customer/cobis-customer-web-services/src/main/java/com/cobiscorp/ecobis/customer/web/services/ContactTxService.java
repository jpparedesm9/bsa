package com.cobiscorp.ecobis.customer.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public interface ContactTxService {

	public ServiceResponse getContactsbyCustomer(CustomerDataRequest request) throws ParseException;;

}
