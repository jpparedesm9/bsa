package com.cobiscorp.ecobis.customer.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;

public interface ICustomerTxService {

	public ServiceResponse getCustomerDetails(CustomerDataRequest request) throws ParseException;

	public ServiceResponse getCustomerAllData(CustomerDataRequest request) throws ParseException;

	public ServiceResponse searchById(IdSearchRequest request) throws ParseException;

	public ServiceResponse createCustomer(CustomerDataResponse request) throws ParseException;;

	public ServiceResponse getCustomerNameById(CustomerDataRequest request) throws ParseException;
}