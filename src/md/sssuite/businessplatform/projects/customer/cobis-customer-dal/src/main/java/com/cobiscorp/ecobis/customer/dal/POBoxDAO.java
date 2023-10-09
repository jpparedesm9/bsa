package com.cobiscorp.ecobis.customer.dal;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;

public interface POBoxDAO {

	public List<POBoxDataResponse> getAllPOBox(CustomerDataRequest request);
	
}