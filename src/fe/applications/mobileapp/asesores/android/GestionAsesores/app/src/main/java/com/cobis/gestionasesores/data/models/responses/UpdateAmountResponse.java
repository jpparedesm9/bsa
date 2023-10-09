package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 27/09/2017.
 */

public class UpdateAmountResponse extends GenericResponse {
    private String data;

    public String getData() {
        return data;
    }

    public UpdateAmountResponse setData(String data) {
        this.data = data;
        return this;
    }
}
