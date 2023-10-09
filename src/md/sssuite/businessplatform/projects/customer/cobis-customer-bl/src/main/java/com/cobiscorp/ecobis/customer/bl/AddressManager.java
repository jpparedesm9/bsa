package com.cobiscorp.ecobis.customer.bl;
import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
public interface AddressManager {
	public List<AddressDataResponse> getAddresses(Integer customer);
	public Boolean existAddressData(List<AddressDataResponse> addressDataResponses);
}
