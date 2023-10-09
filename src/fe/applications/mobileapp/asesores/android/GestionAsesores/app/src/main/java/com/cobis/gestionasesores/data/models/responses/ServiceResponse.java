package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 1/23/2018.
 */

public class ServiceResponse<T> extends GenericResponse {

    private T data;

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
