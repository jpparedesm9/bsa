package com.cobis.tuiiob2c.data.models.requests;

public class UnlockQuestionRequest {

    private String idCliente;
    private String telefono;

    public UnlockQuestionRequest() {
    }

    public UnlockQuestionRequest(String idCliente, String telefono) {
        this.idCliente = idCliente;
        this.telefono = telefono;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
}
