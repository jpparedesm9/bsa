package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.CustomerReferencesRemote;

public class ReferenceResponse extends GenericResponse {

    private CustomerReferencesRemote.ReferenceInfo data;

    public CustomerReferencesRemote.ReferenceInfo getData() {
        return data;
    }

    public void setData(CustomerReferencesRemote.ReferenceInfo data) {
        this.data = data;
    }
}
