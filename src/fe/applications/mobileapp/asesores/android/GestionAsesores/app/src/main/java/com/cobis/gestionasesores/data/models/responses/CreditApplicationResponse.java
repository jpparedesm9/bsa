package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 08/08/2017.
 */

public class CreditApplicationResponse extends GenericResponse {
    private ApplicationCode data;

    public ApplicationCode getData() {
        return data;
    }

    public void setData(ApplicationCode data) {
        this.data = data;
    }
}
