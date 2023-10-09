package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class PartnerDataResponse {

    private PartnerInfoResponse spouse;
    private PartnerAdditionalInfoResponse additional;

    public PartnerInfoResponse getSpouse() {
        return spouse;
    }

    public void setSpouse(PartnerInfoResponse spouse) {
        this.spouse = spouse;
    }

    public PartnerAdditionalInfoResponse getAdditional() {
        return additional;
    }

    public void setAdditional(PartnerAdditionalInfoResponse additional) {
        this.additional = additional;
    }
}
