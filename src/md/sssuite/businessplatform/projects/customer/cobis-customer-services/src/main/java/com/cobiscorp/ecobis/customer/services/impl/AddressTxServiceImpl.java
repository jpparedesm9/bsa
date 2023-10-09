package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.AddressTxService;
import com.cobiscorp.ecobis.customer.services.dtos.*;
import com.cobiscorp.ecobis.customer.bl.AddressManager;

public class AddressTxServiceImpl implements AddressTxService{
	
	private AddressManager addressManager;
	public List<AddressDataResponse> getAddressesbyCustomer(CustomerDataRequest customer){
		return addressManager.getAddresses(customer.getCustomerId());
	}
	public AddressManager getAddressManager() {
		return addressManager;
	}
	public void setAddressManager(AddressManager addressManager) {
		this.addressManager = addressManager;
	}
}
