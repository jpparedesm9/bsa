package com.cobiscorp.ecobis.clientviewer;

import com.cobiscorp.ecobis.customer.commons.dto.CustomerInformationDTO;


public interface ICustomerService {

	public CustomerInformationDTO getCustomer(Integer customerCode);
	
	public CustomerInformationDTO getGroupDetail(Integer groupCode, String type);
}
