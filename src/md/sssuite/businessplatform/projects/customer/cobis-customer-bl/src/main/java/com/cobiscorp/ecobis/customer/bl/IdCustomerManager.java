package com.cobiscorp.ecobis.customer.bl;


import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;

public interface IdCustomerManager {
	List<IdCustomerDataResponse> getIdCustomer (IdCustomerDataResponse request);
	
}
