package com.cobiscorp.ecobis.customer.services;

import com.cobiscorp.ecobis.customer.services.dtos.CompanyDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public interface CompanyTxService {
	
	public CompanyDataResponse executeCompanyCreate (CustomerDataRequest request);


}
