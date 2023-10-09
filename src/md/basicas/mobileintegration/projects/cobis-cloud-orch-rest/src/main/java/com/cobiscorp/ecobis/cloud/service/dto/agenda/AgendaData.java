package com.cobiscorp.ecobis.cloud.service.dto.agenda;

import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;

/**
 * Created by farid on 8/1/2017.
 */
public class AgendaData {
    private Agenda agenda;
    private GeoReference geoReference;

    public AgendaData() {
    }

    public Agenda getAgenda() {
        return agenda;
    }

    public void setAgenda(Agenda agenda) {
        this.agenda = agenda;
    }

    public GeoReference getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReference geoReference) {
        this.geoReference = geoReference;
    }
}
