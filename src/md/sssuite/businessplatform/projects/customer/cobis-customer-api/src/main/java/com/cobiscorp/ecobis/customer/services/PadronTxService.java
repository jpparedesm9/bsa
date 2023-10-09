package com.cobiscorp.ecobis.customer.services;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public interface PadronTxService {

	public CustomerDataResponse executePadronSearch(
			CustomerQuickCreateRequest request);

}
