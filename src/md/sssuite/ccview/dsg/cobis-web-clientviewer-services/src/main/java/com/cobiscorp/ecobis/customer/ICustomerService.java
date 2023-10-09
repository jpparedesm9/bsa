package com.cobiscorp.ecobis.customer;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public interface ICustomerService {

	public ServiceResponse getCustomer(Integer customerCode) throws ParseException;

	public ServiceResponse getGroupDetail(Integer groupCode, String type) throws ParseException;
}
