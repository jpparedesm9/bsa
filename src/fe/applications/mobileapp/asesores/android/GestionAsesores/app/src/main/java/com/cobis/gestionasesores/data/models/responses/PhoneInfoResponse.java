package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.PhoneInfo;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PhoneInfoResponse extends GenericResponse {

    private PhoneInfo data;

    public PhoneInfo getData() {
        return data;
    }

    public void setData(PhoneInfo data) {
        this.data = data;
    }
}
