package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.PartnerWorkAddress;

/**
 * Created by bqtdesa02 on 7/31/2017.
 */

public class PartnerWorkAddressResponse extends GenericResponse {

    private PartnerWorkAddress data;

    public PartnerWorkAddress getData() {
        return data;
    }

    public void setData(PartnerWorkAddress data) {
        this.data = data;
    }
}
