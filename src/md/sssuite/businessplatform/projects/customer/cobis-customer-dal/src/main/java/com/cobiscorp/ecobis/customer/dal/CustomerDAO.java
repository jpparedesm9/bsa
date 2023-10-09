package com.cobiscorp.ecobis.customer.dal;

import com.cobiscorp.ecobis.customer.dal.entities.Customer;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;


public interface CustomerDAO {

	public abstract void create();

	public abstract Customer read(int id);

	public abstract void update(Customer entity);
	
	public CustomerDataResponse getCustomerDataByID(Integer id);
	
	public CustomerDataResponse getCustomerAllDataByID(Integer id);
	
	public IdSearchResponse getIdSearchByID(String docId);
	
}