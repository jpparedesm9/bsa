package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.Business;

/**
 * Created by bqtdesa02 on 7/31/2017.
 */

public class BusinessResponse extends GenericResponse {

    private Business data;

    public Business getData() {
        return data;
    }

    public void setData(Business data) {
        this.data = data;
    }
}
