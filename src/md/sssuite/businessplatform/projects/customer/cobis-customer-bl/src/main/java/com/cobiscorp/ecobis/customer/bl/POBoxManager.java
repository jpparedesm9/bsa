package com.cobiscorp.ecobis.customer.bl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;

public interface POBoxManager {
	
     List<POBoxDataResponse> getAllPOBOX(CustomerDataRequest request);
}
