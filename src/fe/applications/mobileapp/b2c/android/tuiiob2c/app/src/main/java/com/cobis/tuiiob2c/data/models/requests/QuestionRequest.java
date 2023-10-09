package com.cobis.tuiiob2c.data.models.requests;

public class QuestionRequest {

    private String idCliente;

    public QuestionRequest() {
    }

    public QuestionRequest(String idCliente) {
        this.idCliente = idCliente;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }
}
