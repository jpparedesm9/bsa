
package com.cobis.gestionasesores.data.models.requests;

public class ProspectRequest {
    private PersonalInformation prospect;
    private AddressRequest address;
    private GeoReference geoReference;
    private GeoReference officialGeoReference;
    private boolean online;

    public PersonalInformation getProspect() {
        return prospect;
    }

    public void setProspect(PersonalInformation prospect) {
        this.prospect = prospect;
    }

    public AddressRequest getAddress() {
        return address;
    }

    public void setAddress(AddressRequest address) {
        this.address = address;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public GeoReference getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReference geoReference) {
        this.geoReference = geoReference;
    }

    public GeoReference getOfficialGeoReference() {
        return officialGeoReference;
    }

    public ProspectRequest setOfficialGeoReference(GeoReference officialGeoReference) {
        this.officialGeoReference = officialGeoReference;
        return this;
    }
}
