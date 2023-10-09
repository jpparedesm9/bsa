package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class CustomerBusinessRemote {

    private Business business;
    private GeoReference geoReference;
    private GeoReference officialGeoReference;
    private boolean online;
    private AddressInfo address;

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

    public AddressInfo getAddress() {
        return address;
    }

    public void setAddress(AddressInfo address) {
        this.address = address;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public GeoReference getOfficialGeoReference() {
        return officialGeoReference;
    }

    public CustomerBusinessRemote setOfficialGeoReference(GeoReference officialGeoReference) {
        this.officialGeoReference = officialGeoReference;
        return this;
    }
}
