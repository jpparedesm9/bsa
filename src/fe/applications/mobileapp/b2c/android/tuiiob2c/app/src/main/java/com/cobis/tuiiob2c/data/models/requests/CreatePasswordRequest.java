package com.cobis.tuiiob2c.data.models.requests;

public class CreatePasswordRequest {

    private String value;

    public CreatePasswordRequest() {
    }

    public CreatePasswordRequest(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
