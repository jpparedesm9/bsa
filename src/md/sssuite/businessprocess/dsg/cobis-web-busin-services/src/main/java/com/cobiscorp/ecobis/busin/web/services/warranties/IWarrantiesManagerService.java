package com.cobiscorp.ecobis.busin.web.services.warranties;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;


public interface IWarrantiesManagerService {

	
	public ServiceResponse getAllWarrantiesTypes(String warrantyType);
	public ServiceResponse getWarrantyType(String warrantyType);
}
