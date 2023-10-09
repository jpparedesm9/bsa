package com.cobis.gestionasesores.data.models.responses;

public class ParameterResponse extends GenericResponse {

    private ParameterData data;

    public ParameterData getData() {
        return data;
    }

    public void setData(ParameterData data) {
        this.data = data;
    }
}
