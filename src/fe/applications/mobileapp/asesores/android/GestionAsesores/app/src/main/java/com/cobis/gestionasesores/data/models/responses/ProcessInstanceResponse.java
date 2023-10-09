package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 09/08/2017.
 */

public class ProcessInstanceResponse extends GenericResponse{
    private ProcessInstanceInfo data;

    public ProcessInstanceInfo getData() {
        return data;
    }

    public ProcessInstanceResponse setData(ProcessInstanceInfo data) {
        this.data = data;
        return this;
    }
}
