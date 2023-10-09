package com.cobiscorp.ecobis.customer.commons.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;

public interface ICustomerCommonsServices {
	public ServiceResponse getCustomer(Integer customerCode) throws ParseException;

	public ServiceResponse getCustomerType(Integer customerCode) throws ParseException;

	public ServiceResponse getCustomersByParameters(SearchCustomerDTO searchCustomer) throws ParseException;

	public ServiceResponse getCustomersByAutoCompleteText(SearchCustomerDTO searchCustomer) throws ParseException;

	public ServiceResponse getGroup(SearchGroupDTO searchGroup) throws ParseException;

	public ServiceResponse getGroupMembers(Integer groupCode) throws ParseException;

	public ServiceResponse getLegalCustomer(Integer customerCode) throws ParseException;

	public ServiceResponse getCustomerAddresses(Integer customerCode) throws ParseException;

	public ServiceResponse getCustomerRate(Integer customerCode) throws ParseException;

	public ServiceResponse getGroupDetail(Integer groupCode, String type) throws ParseException;

	public ServiceResponse checkColumnExist(String database, String table, String column) throws ParseException;

	public ServiceResponse getGroupsByParameters(SearchGroupDTO searchGroup) throws ParseException;
}
