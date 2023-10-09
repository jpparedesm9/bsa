package com.cobiscorp.ecobis.customer.services.dtos;

/**
* Class of request for search phones given customer and address  
* @author 
**/

public class PhoneDataRequest {
	
	public PhoneDataRequest(){
		
	}
	private Integer addressId;
	private Integer customerID;

	
	public Integer getAddressId() {
		return addressId;
	}
	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}
	      
		
	public Integer getCustomerID() {
		return customerID;
	}
	public void setCustomerID(Integer customerID) {
		this.customerID = customerID;
	}

}
