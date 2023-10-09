package com.cobiscorp.ecobis.clientviewer.bl;

import com.cobiscorp.ecobis.customer.commons.dto.CustomerInformationDTO;

public interface CustomerManager {

	public CustomerInformationDTO getCustomer(Integer customerId);

	public CustomerInformationDTO getGroupDetail(Integer groupCode, String type);
}
