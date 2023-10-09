package com.cobiscorp.ecobis.customer.services;


import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;

public interface IdCustomerTxService {
	
	List<IdCustomerDataResponse> executeIdCustomer (IdCustomerDataResponse request);

}
