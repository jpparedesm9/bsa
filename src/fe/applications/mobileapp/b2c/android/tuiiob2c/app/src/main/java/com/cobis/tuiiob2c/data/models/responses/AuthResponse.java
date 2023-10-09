package com.cobis.tuiiob2c.data.models.responses;

import com.cobis.tuiiob2c.data.models.BaseModel;

public class AuthResponse extends BaseModel {

    private int responseCode;

    public AuthResponse() {
    }

    public AuthResponse(int responseCode) {
        this.responseCode = responseCode;
    }

    public int getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(int responseCode) {
        this.responseCode = responseCode;
    }
}
