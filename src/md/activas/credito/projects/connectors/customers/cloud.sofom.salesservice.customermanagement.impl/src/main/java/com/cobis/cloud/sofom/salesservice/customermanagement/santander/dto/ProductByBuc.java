package com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class ProductByBuc {
    private String buc;
    private String numeroContrato;
    private String oficinaComplemento;
    private String entidadComplemento;
    private String calidadParticipe;
    private String orderParticipe;
    private String codigoProducto;
    private String codigoSubproducto;
    private String fechaBaja;
    private String estadoRelacion;
    private String porcentajeResponsabilidad;
    private String marcaRetener;
    private String motivoBaja;
    private String fechaAlta;
    private String valorTimestamp;
    private String codigoMoneda;

    public ProductByBuc() {
    }

    public ProductByBuc(String buc, String numeroContrato, String oficinaComplemento, String entidadComplemento, String calidadParticipe, String orderParticipe, String codigoProducto, String codigoSubproducto, String fechaBaja, String estadoRelacion, String porcentajeResponsabilidad, String marcaRetener, String motivoBaja, String fechaAlta, String valorTimestamp, String codigoMoneda) {
        this.buc = buc;
        this.numeroContrato = numeroContrato;
        this.oficinaComplemento = oficinaComplemento;
        this.entidadComplemento = entidadComplemento;
        this.calidadParticipe = calidadParticipe;
        this.orderParticipe = orderParticipe;
        this.codigoProducto = codigoProducto;
        this.codigoSubproducto = codigoSubproducto;
        this.fechaBaja = fechaBaja;
        this.estadoRelacion = estadoRelacion;
        this.porcentajeResponsabilidad = porcentajeResponsabilidad;
        this.marcaRetener = marcaRetener;
        this.motivoBaja = motivoBaja;
        this.fechaAlta = fechaAlta;
        this.valorTimestamp = valorTimestamp;
        this.codigoMoneda = codigoMoneda;
    }

    public String getBuc() {
        return buc;
    }

    public void setBuc(String buc) {
        this.buc = buc;
    }

    public String getNumeroContrato() {
        return numeroContrato;
    }

    public void setNumeroContrato(String numeroContrato) {
        this.numeroContrato = numeroContrato;
    }

    public String getOficinaComplemento() {
        return oficinaComplemento;
    }

    public void setOficinaComplemento(String oficinaComplemento) {
        this.oficinaComplemento = oficinaComplemento;
    }

    public String getEntidadComplemento() {
        return entidadComplemento;
    }

    public void setEntidadComplemento(String entidadComplemento) {
        this.entidadComplemento = entidadComplemento;
    }

    public String getCalidadParticipe() {
        return calidadParticipe;
    }

    public void setCalidadParticipe(String calidadParticipe) {
        this.calidadParticipe = calidadParticipe;
    }

    public String getOrderParticipe() {
        return orderParticipe;
    }

    public void setOrderParticipe(String orderParticipe) {
        this.orderParticipe = orderParticipe;
    }

    public String getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(String codigoProducto) {
        this.codigoProducto = codigoProducto;
    }

    public String getCodigoSubproducto() {
        return codigoSubproducto;
    }

    public void setCodigoSubproducto(String codigoSubproducto) {
        this.codigoSubproducto = codigoSubproducto;
    }

    public String getFechaBaja() {
        return fechaBaja;
    }

    public void setFechaBaja(String fechaBaja) {
        this.fechaBaja = fechaBaja;
    }

    public String getEstadoRelacion() {
        return estadoRelacion;
    }

    public void setEstadoRelacion(String estadoRelacion) {
        this.estadoRelacion = estadoRelacion;
    }

    public String getPorcentajeResponsabilidad() {
        return porcentajeResponsabilidad;
    }

    public void setPorcentajeResponsabilidad(String porcentajeResponsabilidad) {
        this.porcentajeResponsabilidad = porcentajeResponsabilidad;
    }

    public String getMarcaRetener() {
        return marcaRetener;
    }

    public void setMarcaRetener(String marcaRetener) {
        this.marcaRetener = marcaRetener;
    }

    public String getMotivoBaja() {
        return motivoBaja;
    }

    public void setMotivoBaja(String motivoBaja) {
        this.motivoBaja = motivoBaja;
    }

    public String getFechaAlta() {
        return fechaAlta;
    }

    public void setFechaAlta(String fechaAlta) {
        this.fechaAlta = fechaAlta;
    }

    public String getValorTimestamp() {
        return valorTimestamp;
    }

    public void setValorTimestamp(String valorTimestamp) {
        this.valorTimestamp = valorTimestamp;
    }

    public String getCodigoMoneda() {
        return codigoMoneda;
    }

    public void setCodigoMoneda(String codigoMoneda) {
        this.codigoMoneda = codigoMoneda;
    }
}
