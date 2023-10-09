package com.cobiscorp.ecobis.customer.services;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;
/**
* Class to return all the PO Box of a customer.
* @author
**/
public interface POBoxTxService {
	/**
	* Method to return all the PO Box of a customer given Customer id.
	* @author
	**/
	public List<POBoxDataResponse> getAllPOBOX(CustomerDataRequest request);
	
}
