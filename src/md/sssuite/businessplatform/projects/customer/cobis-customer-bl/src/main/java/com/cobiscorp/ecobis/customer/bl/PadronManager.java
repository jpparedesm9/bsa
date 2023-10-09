package com.cobiscorp.ecobis.customer.bl;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public interface PadronManager {
	public  CustomerDataResponse getPadronCustomer(CustomerQuickCreateRequest request);

}
