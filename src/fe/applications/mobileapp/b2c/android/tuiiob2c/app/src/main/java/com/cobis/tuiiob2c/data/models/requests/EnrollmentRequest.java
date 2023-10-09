package com.cobis.tuiiob2c.data.models.requests;

public class EnrollmentRequest {

    private String codigo;

    public EnrollmentRequest(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
}
