package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.common.OutputData;

public class SpouseAddressDataResponse implements OutputData {

    private ServiceResponse address;
    private ServiceResponse workphone;
    private ServiceResponse cellphone;

    public ServiceResponse getAddress() {
        return address;
    }

    public void setAddress(ServiceResponse address) {
        this.address = address;
    }

    public ServiceResponse getWorkphone() {
        return workphone;
    }

    public void setWorkphone(ServiceResponse workphone) {
        this.workphone = workphone;
    }

    public ServiceResponse getCellphone() {
        return cellphone;
    }

    public void setCellphone(ServiceResponse cellphone) {
        this.cellphone = cellphone;
    }

    @Override
    public ServiceResponse[] getResponses() {
        return new ServiceResponse[]{address, workphone, cellphone};
    }
}
