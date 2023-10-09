package com.cobiscorp.ecobis.customer.services.dtos;
 
public class CustomerDataRequest {
 
     private Integer customerId;

 	/** 
	* returns  customerId
	*/	
     public Integer getCustomerId() {
       return this.customerId;
     }

     public void setCustomerId( Integer aCustomerId) {
       this.customerId = aCustomerId;
     }


   }
