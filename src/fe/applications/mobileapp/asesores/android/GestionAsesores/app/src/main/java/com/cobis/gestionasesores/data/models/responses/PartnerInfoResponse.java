package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.PartnerInfo;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PartnerInfoResponse extends GenericResponse {

    private PartnerInfo data;

    public PartnerInfo getData() {
        return data;
    }

    public void setData(PartnerInfo data) {
        this.data = data;
    }
}
