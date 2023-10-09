package com.cobiscorp.ecobis.customer.services.impl;



import com.cobiscorp.ecobis.customer.bl.CreationCustomerManager;
import com.cobiscorp.ecobis.customer.bl.CustomerManager;
import com.cobiscorp.ecobis.customer.services.CustomerTxService;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;


public class CustomerTxServiceImpl implements CustomerTxService {
	
private CustomerManager customerManager;
private CreationCustomerManager creationCustomerManager; 	

	public CustomerManager getCustomerManager() {
	return customerManager;
}


	public void setCustomerManager(CustomerManager customerManager) {
	this.customerManager = customerManager;
}

	public CreationCustomerManager getCreationCustomerManager() {
	return creationCustomerManager;
}

	public void setCreationCustomerManager(
		CreationCustomerManager creationCustomerManager) {
	this.creationCustomerManager = creationCustomerManager;
}


	@Override
	public CustomerDataResponse getCustomerDetails(CustomerDataRequest request) {
		return customerManager.getCustomerDataById(request.getCustomerId());
	}
	@Override
	public CustomerDataResponse getCustomerAllData(CustomerDataRequest request){
		return customerManager.searchCustomerDataById(request.getCustomerId());
	}


	@Override
	public IdSearchResponse searchById(IdSearchRequest idSearchRequest) {
		
		return customerManager.getIdSearchByID(idSearchRequest.getIdentification());
	}


	@Override
	public CustomerDataRequest createCustomer(CustomerDataResponse request) {
		return creationCustomerManager.normalCreationCustomer(request);
	}
	
	@Override
	public CustomerDataResponse getCustomerNameById(CustomerDataRequest request){
		return customerManager.searchCustomerNameById(request.getCustomerId());
	}
		
}
