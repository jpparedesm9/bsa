package com.cobiscorp.ecobis.cloud.service.dto.client;

import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import com.cobiscorp.ecobis.cloud.service.dto.address.BasicAddress;

/**
 * @author Cesar Loadhamin
 */
public class CustomerAddress extends BasicAddress {

    public static final String ADDRESS_TYPE = "RE";
    
    private int numberOfResidents;

    public int getNumberOfResidents() {
        return numberOfResidents;
    }

    public void setNumberOfResidents(int numberOfResidents) {
        this.numberOfResidents = numberOfResidents;
    }

    @Override
    public AddressRequest toRequest(int customerId) {
        AddressRequest request = super.toRequest(customerId);
        request.setNumberOfResidents(numberOfResidents);
        request.setAddressType(ADDRESS_TYPE);
        return request;
    }

    @Override
    public void fillFromResponse(AddressResp address) {
        super.fillFromResponse(address);
        this.numberOfResidents = address.getNumberOfResidents();
    }

    public static CustomerAddress fromResponse(AddressResp address) {
        if (address == null) {
            return null;
        }
        CustomerAddress obj = new CustomerAddress();
        obj.fillFromResponse(address);
        return  obj;
    } 
}
