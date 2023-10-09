package com.cobiscorp.ecobis.cloud.service.dto.business;

import com.cobiscorp.ecobis.cloud.service.dto.address.BasicAddress;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;

public class BusinessAddress extends BasicAddress {

    public static final String ADDRESS_TYPE = "AE";

    @Override
    public AddressRequest toRequest(int customerId) {
	AddressRequest request = super.toRequest(customerId);
	request.setAddressType(ADDRESS_TYPE);
	request.setPrincipal("N");
	return request;
    }

    public static BusinessAddress fromResponse(AddressResp address) {
        if (address == null) {
            return null;
        }
        BusinessAddress obj = new BusinessAddress();
        obj.fillFromResponse(address);
        return  obj;
    }
						     
}
