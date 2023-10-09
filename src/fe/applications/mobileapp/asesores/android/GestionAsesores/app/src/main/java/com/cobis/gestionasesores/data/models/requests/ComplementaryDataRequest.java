package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class ComplementaryDataRequest {

    private ComplementaryInfo complementary;
    private boolean online;

    public ComplementaryInfo getComplementary() {
        return complementary;
    }

    public void setComplementary(ComplementaryInfo complementary) {
        this.complementary = complementary;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
