package com.cobis.gestionasesores.data.models.requests;

public class ReferenceRequest {

    private CustomerReferencesRemote.ReferenceInfo reference;
    private boolean online;

    public CustomerReferencesRemote.ReferenceInfo getReference() {
        return reference;
    }

    public void setReference(CustomerReferencesRemote.ReferenceInfo reference) {
        this.reference = reference;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
