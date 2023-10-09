package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.common.OutputData;


/**
 * @author Cesar Loachamin
 */
public class CustomerAddressDataResponse implements OutputData {

    private ServiceResponse address;
    private ServiceResponse email;
    private ServiceResponse phone;
    private ServiceResponse cellphone;
    private ServiceResponse geoReference;

    public CustomerAddressDataResponse() {
    }

    public ServiceResponse getAddress() {
        return address;
    }

    public void setAddress(ServiceResponse address) {
        this.address = address;
    }

    public ServiceResponse getEmail() {
        return email;
    }

    public void setEmail(ServiceResponse email) {
        this.email = email;
    }

    public ServiceResponse getPhone() {
        return phone;
    }

    public void setPhone(ServiceResponse phone) {
        this.phone = phone;
    }

    public ServiceResponse getCellphone() {
        return cellphone;
    }

    public void setCellphone(ServiceResponse cellphone) {
        this.cellphone = cellphone;
    }

    public ServiceResponse getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(ServiceResponse geoReference) {
        this.geoReference = geoReference;
    }

    @Override
    public ServiceResponse[] getResponses() {
        return new ServiceResponse[]{address, email, phone, cellphone, geoReference};
    }
}
