package com.cobiscorp.ecobis.cloud.service.dto.geolocation;

import cobiscorp.ecobis.customerdatamanagement.dto.GeoreferencingRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoResponse;

/**
 * @author Paul Ortiz
 */
public class OfficeGeoReference {

	private int officeId;
	private double latitude;
	private double longitude;

	public OfficeGeoReference() {
	}

	public int getOfficeId() {
		return officeId;
	}

	public void setOfficeId(int officeId) {
		this.officeId = officeId;
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

	public static OfficeGeoReference fromResponse(OfficeGeoResponse response) {
		if (response == null) {
			return null;
		}
		OfficeGeoReference reference = new OfficeGeoReference();
		reference.setOfficeId(response.getOfficeId());
		reference.setLatitude(response.getLatitude() == null ? 0 : response.getLatitude().doubleValue());
		reference.setLongitude(response.getLongitude() == null ? 0 : response.getLongitude().doubleValue());
		return reference;
	}
}
