package com.cobis.tuiiob2c.data.models.requests;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class PhoneValidationRequest {

    @SerializedName("numero")
    @Expose
    private String numero;

    /**
     * No args constructor for use in serialization
     *
     */
    public PhoneValidationRequest() {
    }

    /**
     *
     * @param numero
     */
    public PhoneValidationRequest(String numero) {
        super();
        this.numero = numero;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

}