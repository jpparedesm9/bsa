package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 18/08/2017.
 */

public class VerificationResponse extends GenericResponse{
    private VerificationRemote data;

    public VerificationRemote getData() {
        return data;
    }

    public void setData(VerificationRemote data) {
        this.data = data;
    }
}
