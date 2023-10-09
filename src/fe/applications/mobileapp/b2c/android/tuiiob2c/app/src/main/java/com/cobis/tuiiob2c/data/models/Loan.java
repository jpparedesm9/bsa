package com.cobis.tuiiob2c.data.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

public class Loan implements Serializable {

    @SerializedName("lineaCredito")
    @Expose
    private double lineaCredito;
    @SerializedName("utilizado")
    @Expose
    private double utilizado;
    @SerializedName("pagoSinIntereses")
    @Expose
    private double pagoSinIntereses;
    @SerializedName("pagoMinimo")
    @Expose
    private double pagoMinimo;
    @SerializedName("referenciaDePago")
    @Expose
    private String referenciaDePago;
    @SerializedName("fechaPago")
    @Expose
    private String fechaPago;
    @SerializedName("ultimoAcceso")
    @Expose
    private String ultimoAcceso;
    @SerializedName("details")
    @Expose
    private List<LoanDetail> details = null;

    public Loan() {

    }

    /**
     *
     * @param pagoSinIntereses
     * @param details
     * @param lineaCredito
     * @param ultimoAcceso
     * @param pagoMinimo
     * @param fechaPago
     * @param referenciaDePago
     * @param utilizado
     */
    public Loan(double lineaCredito, double utilizado, double pagoSinIntereses, double pagoMinimo, String referenciaDePago, String fechaPago, String ultimoAcceso, List<LoanDetail> details) {
        super();
        this.lineaCredito = lineaCredito;
        this.utilizado = utilizado;
        this.pagoSinIntereses = pagoSinIntereses;
        this.pagoMinimo = pagoMinimo;
        this.referenciaDePago = referenciaDePago;
        this.fechaPago = fechaPago;
        this.ultimoAcceso = ultimoAcceso;
        this.details = details;
    }

    public double getLineaCredito() {
        return lineaCredito;
    }

    public void setLineaCredito(double lineaCredito) {
        this.lineaCredito = lineaCredito;
    }

    public double getUtilizado() {
        return utilizado;
    }

    public void setUtilizado(double utilizado) {
        this.utilizado = utilizado;
    }

    public double getPagoSinIntereses() {
        return pagoSinIntereses;
    }

    public void setPagoSinIntereses(double pagoSinIntereses) {
        this.pagoSinIntereses = pagoSinIntereses;
    }

    public double getPagoMinimo() {
        return pagoMinimo;
    }

    public void setPagoMinimo(double pagoMinimo) {
        this.pagoMinimo = pagoMinimo;
    }

    public String getReferenciaDePago() {
        return referenciaDePago;
    }

    public void setReferenciaDePago(String referenciaDePago) {
        this.referenciaDePago = referenciaDePago;
    }

    public String getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(String fechaPago) {
        this.fechaPago = fechaPago;
    }

    public String getUltimoAcceso() {
        return ultimoAcceso;
    }

    public void setUltimoAcceso(String ultimoAcceso) {
        this.ultimoAcceso = ultimoAcceso;
    }

    public List<LoanDetail> getDetails() {
        return details;
    }

    public void setDetails(List<LoanDetail> details) {
        this.details = details;
    }
}
