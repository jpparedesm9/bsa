package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;


/**
 * @author Cesar Loachamin
 */
public class ProspectData {
    private Prospect prospect;
    private ProspectAddress address;
    private GeoReference geoReference;
    private GeoReference officialGeoReference;

    public ProspectData() {
    }

    public ProspectData(Prospect prospect, ProspectAddress address, GeoReference geoReference) {
        this.prospect = prospect;
        this.address = address;
        this.geoReference = geoReference;
    }

    public Prospect getProspect() {
        return prospect;
    }

    public void setProspect(Prospect prospect) {
        this.prospect = prospect;
    }

    public ProspectAddress getAddress() {
        return address;
    }

    public void setAddress(ProspectAddress address) {
        this.address = address;
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

	public void setOfficialGeoReference(GeoReference officialGeoReference) {
		this.officialGeoReference = officialGeoReference;
	}
    
}
