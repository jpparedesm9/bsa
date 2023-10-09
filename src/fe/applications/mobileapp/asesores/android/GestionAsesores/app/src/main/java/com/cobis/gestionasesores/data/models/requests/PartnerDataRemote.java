package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class PartnerDataRemote {
    private PartnerInfo spouse;
    private PartnerAdditionalInfo additional;
    private String economicActivity;
    private boolean online;

    public String getEconomicActivity() {
        return economicActivity;
    }

    public void setEconomicActivity(String economicActivity) {
        this.economicActivity = economicActivity;
    }

    public PartnerInfo getSpouse() {
        return spouse;
    }

    public void setSpouse(PartnerInfo spouse) {
        this.spouse = spouse;
    }

    public PartnerAdditionalInfo getAdditional() {
        return additional;
    }

    public void setAdditional(PartnerAdditionalInfo additional) {
        this.additional = additional;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}