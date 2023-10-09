package com.cobiscorp.ecobis.customer.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;

public interface IdCustomerTxService {
	ServiceResponse executeIdCustomer(IdCustomerDataResponse request) throws ParseException;

}
