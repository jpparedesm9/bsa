package com.cobiscorp.ecobis.cloud.service.dto.geolocation;

import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.customerdatamanagement.dto.GeoreferencingRequest;

/**
 * @author Cesar Loachamin
 */
public class GeoReference {

    private int addressId;
    private double latitude;
    private double longitude;

    public GeoReference() {
    }

    public int getAddressId() {
	return addressId;
    }

    public void setAddressId(int addressId) {
	this.addressId = addressId;
    }
    
    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public GeoreferencingRequest toRequest(int customerId, int addressId) {
        GeoreferencingRequest request = new GeoreferencingRequest();
        request.setCustomerId(customerId);
        request.setAddressId(addressId);
        request.setLatitudeSeg(getLatitude());
        request.setLongitudSeg(getLongitude());
       
        return request;
    }

  

	public static GeoReference fromResponse(AddressResp response) {
        if (response == null) {
            return null;
        }
        GeoReference reference = new GeoReference();
	    reference.setAddressId(response.getAddress());
        reference.setLatitude(response.getLatitude() == null ? 0 : response.getLatitude().doubleValue());
        reference.setLongitude(response.getLongitude() == null ? 0 : response.getLongitude().doubleValue());
        return reference;
    }
}
