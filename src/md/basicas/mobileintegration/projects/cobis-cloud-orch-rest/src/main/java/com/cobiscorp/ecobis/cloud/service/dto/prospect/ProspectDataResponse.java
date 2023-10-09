package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.address.AddressResult;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerResult;
import com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil;
import com.cobiscorp.ecobis.cloud.service.dto.common.OutputData;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;

/**
 * @author Cesar Loachamin
 */
public class ProspectDataResponse implements OutputData {

    private ServiceResponse prospect;
    private ServiceResponse address;
    private ServiceResponse geoReference;

    public ServiceResponse getProspect() {
        return prospect;
    }

    public void setProspect(ServiceResponse prospect) {
        this.prospect = prospect;
    }

    public void setProspectResult(CustomerResult clientResult) {
        this.prospect = ServiceResponseUtil.createServiceResponse(clientResult);
    }

    public ServiceResponse getAddress() {
        return address;
    }

    public void setAddress(ServiceResponse address) {
        this.address = address;
    }

    public void setAddressResult(AddressResult addressResult) {
        this.address = ServiceResponseUtil.createServiceResponse(addressResult);
    }

    public ServiceResponse getGeoReference() {
	return geoReference;
    }

    public void setGeoReference(ServiceResponse geoReference) {
	this.geoReference = geoReference;
    }

    @Override
    public ServiceResponse[] getResponses() {
	return new ServiceResponse[] { prospect, address, geoReference};
    }
}
