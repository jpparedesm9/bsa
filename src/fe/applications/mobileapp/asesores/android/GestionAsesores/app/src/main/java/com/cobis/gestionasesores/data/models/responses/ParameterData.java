package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.Parameter;

import java.util.List;

public class ParameterData extends GenericResponse {

    private List<Parameter> data;

    public List<Parameter> getData() {
        return data;
    }

    public void setData(List<Parameter> data) {
        this.data = data;
    }
}
