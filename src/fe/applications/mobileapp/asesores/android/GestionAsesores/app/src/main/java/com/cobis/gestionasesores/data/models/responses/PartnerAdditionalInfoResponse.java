package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.PartnerAdditionalInfo;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PartnerAdditionalInfoResponse extends GenericResponse {

    private PartnerAdditionalInfo data;

    public PartnerAdditionalInfo getData() {
        return data;
    }

    public void setData(PartnerAdditionalInfo data) {
        this.data = data;
    }
}
