package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.GeoReference;

public class ProspectResponse {
    private PersonalInformationData prospect;
    private AddressDataResponse address;
    private GeoReference geoReference;

    public PersonalInformationData getProspect() {
        return prospect;
    }

    public void setProspect(PersonalInformationData prospect) {
        this.prospect = prospect;
    }

    public AddressDataResponse getAddress() {
        return address;
    }

    public void setAddress(AddressDataResponse address) {
        this.address = address;
    }

    public GeoReference getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReference geoReference) {
        this.geoReference = geoReference;
    }
}
