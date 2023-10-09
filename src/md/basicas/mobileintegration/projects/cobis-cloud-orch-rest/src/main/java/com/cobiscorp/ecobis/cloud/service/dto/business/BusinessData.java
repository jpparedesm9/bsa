package com.cobiscorp.ecobis.cloud.service.dto.business;

import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;

public class BusinessData {

    private Business business;
    private BusinessAddress address;
    private GeoReference geoReference;
    private GeoReference officialGeoReference;
    

    public BusinessData(Business business) {
        this.business = business;
    }

    public BusinessData() {
    }

    public Business getBusiness() {
        return business;
    }

    public void setBusiness(Business business) {
        this.business = business;
    }

    public GeoReference getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReference geoReference) {
        this.geoReference = geoReference;
    }

    public BusinessAddress getAddress() {
        return address;
    }

    public void setAddress(BusinessAddress address) {
        this.address = address;
    }

	public GeoReference getOfficialGeoReference() {
		return officialGeoReference;
	}

	public void setOfficialGeoReference(GeoReference officialGeoReference) {
		this.officialGeoReference = officialGeoReference;
	}
    
    
}
