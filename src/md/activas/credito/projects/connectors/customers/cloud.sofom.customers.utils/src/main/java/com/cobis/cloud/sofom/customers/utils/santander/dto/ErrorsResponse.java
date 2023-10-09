package com.cobis.cloud.sofom.customers.utils.santander.dto;

import java.util.List;

/**
 * Created by pclavijo on 21/06/2017.
 */
public class ErrorsResponse {
    private List<Error> errors;

    public ErrorsResponse() {
    }

    public ErrorsResponse(List<Error> errors) {
        this.errors = errors;
    }

    public List<Error> getErrors() {
        return errors;
    }

    public void setErrors(List<Error> errors) {
        this.errors = errors;
    }
}
