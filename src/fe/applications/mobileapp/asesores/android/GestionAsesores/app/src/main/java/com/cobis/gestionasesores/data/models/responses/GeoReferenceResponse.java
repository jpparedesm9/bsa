package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.GeoReference;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class GeoReferenceResponse extends GenericResponse {

    private GeoReference data;

    public GeoReference getData() {
        return data;
    }

    public void setData(GeoReference data) {
        this.data = data;
    }
}
