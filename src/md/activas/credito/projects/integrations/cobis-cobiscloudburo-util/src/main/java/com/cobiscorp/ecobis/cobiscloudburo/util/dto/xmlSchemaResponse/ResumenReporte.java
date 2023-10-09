package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

public class ResumenReporte {
    private String fechaIngresoBD;
    private String numeroMOP7;
    private String numeroMOP6;
    private String numeroMOP5;
    private String numeroMOP4;
    private String numeroMOP3;
    private String numeroMOP2;
    private String numeroMOP1;
    private String numeroMOP0;
    private String numeroMOPUR;
    private String numeroCuentas;
    private String cuentasPagosFijosHipotecas;
    private String cuentasRevolventesAbiertas;
    private String cuentasCerradas;
    private String cuentasNegativasActuales;
    private String cuentasClavesHistoriaNegativa;
    private String cuentasDisputa;
    private String numeroSolicitudesUltimos6Meses;
    private String nuevaDireccionReportadaUltimos60Dias;
    private String mensajesAlerta;
    private String existenciaDeclaracionesConsumidor;
    private String tipoMoneda;
    private String totalCreditosMaximosRevolventes;
    private String totalLimitesCreditoRevolventes;
    private String totalSaldosActualesRevolventes;
    private String totalSaldosVencidosRevolventes;
    private String totalPagosRevolventes;
    private String pctLimiteCreditoUtilizadoRevolventes;
    private String totalCreditosMaximosPagosFijos;
    private String totalSaldosActualesPagosFijos;
    private String totalSaldosVencidosPagosFijos;
    private String totalPagosPagosFijos;
    private String numeroMOP96;
    private String numeroMOP97;
    private String numeroMOP99;
    private String fechaAperturaCuentaMasAntigua;
    private String fechaAperturaCuentaMasReciente;
    private String totalSolicitudesReporte;
    private String fechaSolicitudReporteMasReciente;
    private String numeroTotalCuentasDespachoCobranza;
    private String fechaAperturaCuentaMasRecienteDespachoCobranza;
    private String numeroTotalSolicitudesDespachosCobranza;
    private String fechaSolicitudMasRecienteDespachoCobranza;

    public String getFechaIngresoBD() {
        return fechaIngresoBD;
    }

    @XmlElement(name = "FechaIngresoBD")
    public void setFechaIngresoBD(String fechaIngresoBD) {
        this.fechaIngresoBD = fechaIngresoBD;
    }

    public String getNumeroMOP7() {
        return numeroMOP7;
    }

    @XmlElement(name = "NumeroMOP7")
    public void setNumeroMOP7(String numeroMOP7) {
        this.numeroMOP7 = numeroMOP7;
    }

    public String getNumeroMOP6() {
        return numeroMOP6;
    }

    @XmlElement(name = "NumeroMOP6")
    public void setNumeroMOP6(String numeroMOP6) {
        this.numeroMOP6 = numeroMOP6;
    }

    public String getNumeroMOP5() {
        return numeroMOP5;
    }

    @XmlElement(name = "NumeroMOP5")
    public void setNumeroMOP5(String numeroMOP5) {
        this.numeroMOP5 = numeroMOP5;
    }

    public String getNumeroMOP4() {
        return numeroMOP4;
    }

    @XmlElement(name = "NumeroMOP4")
    public void setNumeroMOP4(String numeroMOP4) {
        this.numeroMOP4 = numeroMOP4;
    }

    public String getNumeroMOP3() {
        return numeroMOP3;
    }

    @XmlElement(name = "NumeroMOP3")
    public void setNumeroMOP3(String numeroMOP3) {
        this.numeroMOP3 = numeroMOP3;
    }

    public String getNumeroMOP2() {
        return numeroMOP2;
    }

    @XmlElement(name = "NumeroMOP2")
    public void setNumeroMOP2(String numeroMOP2) {
        this.numeroMOP2 = numeroMOP2;
    }

    public String getNumeroMOP1() {
        return numeroMOP1;
    }

    @XmlElement(name = "NumeroMOP1")
    public void setNumeroMOP1(String numeroMOP1) {
        this.numeroMOP1 = numeroMOP1;
    }

    public String getNumeroMOP0() {
        return numeroMOP0;
    }

    @XmlElement(name = "NumeroMOP0")
    public void setNumeroMOP0(String numeroMOP0) {
        this.numeroMOP0 = numeroMOP0;
    }

    public String getNumeroMOPUR() {
        return numeroMOPUR;
    }

    @XmlElement(name = "NumeroMOPUR")
    public void setNumeroMOPUR(String numeroMOPUR) {
        this.numeroMOPUR = numeroMOPUR;
    }

    public String getNumeroCuentas() {
        return numeroCuentas;
    }

    @XmlElement(name = "NumeroCuentas")
    public void setNumeroCuentas(String numeroCuentas) {
        this.numeroCuentas = numeroCuentas;
    }

    public String getCuentasPagosFijosHipotecas() {
        return cuentasPagosFijosHipotecas;
    }

    @XmlElement(name = "CuentasPagosFijosHipotecas")
    public void setCuentasPagosFijosHipotecas(String cuentasPagosFijosHipotecas) {
        this.cuentasPagosFijosHipotecas = cuentasPagosFijosHipotecas;
    }

    public String getCuentasRevolventesAbiertas() {
        return cuentasRevolventesAbiertas;
    }

    @XmlElement(name = "CuentasRevolventesAbiertas")
    public void setCuentasRevolventesAbiertas(String cuentasRevolventesAbiertas) {
        this.cuentasRevolventesAbiertas = cuentasRevolventesAbiertas;
    }

    public String getCuentasCerradas() {
        return cuentasCerradas;
    }

    @XmlElement(name = "CuentasCerradas")
    public void setCuentasCerradas(String cuentasCerradas) {
        this.cuentasCerradas = cuentasCerradas;
    }

    public String getCuentasNegativasActuales() {
        return cuentasNegativasActuales;
    }

    @XmlElement(name = "CuentasNegativasActuales")
    public void setCuentasNegativasActuales(String cuentasNegativasActuales) {
        this.cuentasNegativasActuales = cuentasNegativasActuales;
    }

    public String getCuentasClavesHistoriaNegativa() {
        return cuentasClavesHistoriaNegativa;
    }

    @XmlElement(name = "CuentasClavesHistoriaNegativa")
    public void setCuentasClavesHistoriaNegativa(String cuentasClavesHistoriaNegativa) {
        this.cuentasClavesHistoriaNegativa = cuentasClavesHistoriaNegativa;
    }

    public String getCuentasDisputa() {
        return cuentasDisputa;
    }

    @XmlElement(name = "CuentasDisputa")
    public void setCuentasDisputa(String cuentasDisputa) {
        this.cuentasDisputa = cuentasDisputa;
    }

    public String getNumeroSolicitudesUltimos6Meses() {
        return numeroSolicitudesUltimos6Meses;
    }

    @XmlElement(name = "NumeroSolicitudesUltimos6Meses")
    public void setNumeroSolicitudesUltimos6Meses(String numeroSolicitudesUltimos6Meses) {
        this.numeroSolicitudesUltimos6Meses = numeroSolicitudesUltimos6Meses;
    }

    public String getNuevaDireccionReportadaUltimos60Dias() {
        return nuevaDireccionReportadaUltimos60Dias;
    }

    @XmlElement(name = "NuevaDireccionReportadaUltimos60Dias")
    public void setNuevaDireccionReportadaUltimos60Dias(String nuevaDireccionReportadaUltimos60Dias) {
        this.nuevaDireccionReportadaUltimos60Dias = nuevaDireccionReportadaUltimos60Dias;
    }

    public String getMensajesAlerta() {
        return mensajesAlerta;
    }

    @XmlElement(name = "MensajesAlerta")
    public void setMensajesAlerta(String mensajesAlerta) {
        this.mensajesAlerta = mensajesAlerta;
    }

    public String getExistenciaDeclaracionesConsumidor() {
        return existenciaDeclaracionesConsumidor;
    }

    @XmlElement(name = "ExistenciaDeclaracionesConsumidor")
    public void setExistenciaDeclaracionesConsumidor(String existenciaDeclaracionesConsumidor) {
        this.existenciaDeclaracionesConsumidor = existenciaDeclaracionesConsumidor;
    }

    public String getTipoMoneda() {
        return tipoMoneda;
    }

    @XmlElement(name = "TipoMoneda")
    public void setTipoMoneda(String tipoMoneda) {
        this.tipoMoneda = tipoMoneda;
    }

    public String getTotalCreditosMaximosRevolventes() {
        return totalCreditosMaximosRevolventes;
    }

    @XmlElement(name = "TotalCreditosMaximosRevolventes")
    public void setTotalCreditosMaximosRevolventes(String totalCreditosMaximosRevolventes) {
        this.totalCreditosMaximosRevolventes = totalCreditosMaximosRevolventes;
    }

    public String getTotalLimitesCreditoRevolventes() {
        return totalLimitesCreditoRevolventes;
    }

    @XmlElement(name = "TotalLimitesCreditoRevolventes")
    public void setTotalLimitesCreditoRevolventes(String totalLimitesCreditoRevolventes) {
        this.totalLimitesCreditoRevolventes = totalLimitesCreditoRevolventes;
    }

    public String getTotalSaldosActualesRevolventes() {
        return totalSaldosActualesRevolventes;
    }

    @XmlElement(name = "TotalSaldosActualesRevolventes")
    public void setTotalSaldosActualesRevolventes(String totalSaldosActualesRevolventes) {
        this.totalSaldosActualesRevolventes = totalSaldosActualesRevolventes;
    }

    public String getTotalSaldosVencidosRevolventes() {
        return totalSaldosVencidosRevolventes;
    }

    @XmlElement(name = "TotalSaldosVencidosRevolventes")
    public void setTotalSaldosVencidosRevolventes(String totalSaldosVencidosRevolventes) {
        this.totalSaldosVencidosRevolventes = totalSaldosVencidosRevolventes;
    }

    public String getTotalPagosRevolventes() {
        return totalPagosRevolventes;
    }

    @XmlElement(name = "TotalPagosRevolventes")
    public void setTotalPagosRevolventes(String totalPagosRevolventes) {
        this.totalPagosRevolventes = totalPagosRevolventes;
    }

    public String getPctLimiteCreditoUtilizadoRevolventes() {
        return pctLimiteCreditoUtilizadoRevolventes;
    }

    @XmlElement(name = "PctLimiteCreditoUtilizadoRevolventes")
    public void setPctLimiteCreditoUtilizadoRevolventes(String pctLimiteCreditoUtilizadoRevolventes) {
        this.pctLimiteCreditoUtilizadoRevolventes = pctLimiteCreditoUtilizadoRevolventes;
    }

    public String getTotalCreditosMaximosPagosFijos() {
        return totalCreditosMaximosPagosFijos;
    }

    @XmlElement(name = "TotalCreditosMaximosPagosFijos")
    public void setTotalCreditosMaximosPagosFijos(String totalCreditosMaximosPagosFijos) {
        this.totalCreditosMaximosPagosFijos = totalCreditosMaximosPagosFijos;
    }

    public String getTotalSaldosActualesPagosFijos() {
        return totalSaldosActualesPagosFijos;
    }

    @XmlElement(name = "TotalSaldosActualesPagosFijos")
    public void setTotalSaldosActualesPagosFijos(String totalSaldosActualesPagosFijos) {
        this.totalSaldosActualesPagosFijos = totalSaldosActualesPagosFijos;
    }

    public String getTotalSaldosVencidosPagosFijos() {
        return totalSaldosVencidosPagosFijos;
    }

    @XmlElement(name = "TotalSaldosVencidosPagosFijos")
    public void setTotalSaldosVencidosPagosFijos(String totalSaldosVencidosPagosFijos) {
        this.totalSaldosVencidosPagosFijos = totalSaldosVencidosPagosFijos;
    }

    public String getTotalPagosPagosFijos() {
        return totalPagosPagosFijos;
    }

    @XmlElement(name = "TotalPagosPagosFijos")
    public void setTotalPagosPagosFijos(String totalPagosPagosFijos) {
        this.totalPagosPagosFijos = totalPagosPagosFijos;
    }

    public String getNumeroMOP96() {
        return numeroMOP96;
    }

    @XmlElement(name = "NumeroMOP96")
    public void setNumeroMOP96(String numeroMOP96) {
        this.numeroMOP96 = numeroMOP96;
    }

    public String getNumeroMOP97() {
        return numeroMOP97;
    }

    @XmlElement(name = "NumeroMOP97")
    public void setNumeroMOP97(String numeroMOP97) {
        this.numeroMOP97 = numeroMOP97;
    }

    public String getNumeroMOP99() {
        return numeroMOP99;
    }

    @XmlElement(name = "NumeroMOP99")
    public void setNumeroMOP99(String numeroMOP99) {
        this.numeroMOP99 = numeroMOP99;
    }

    public String getFechaAperturaCuentaMasAntigua() {
        return fechaAperturaCuentaMasAntigua;
    }

    @XmlElement(name = "FechaAperturaCuentaMasAntigua")
    public void setFechaAperturaCuentaMasAntigua(String fechaAperturaCuentaMasAntigua) {
        this.fechaAperturaCuentaMasAntigua = fechaAperturaCuentaMasAntigua;
    }

    public String getFechaAperturaCuentaMasReciente() {
        return fechaAperturaCuentaMasReciente;
    }

    @XmlElement(name = "FechaAperturaCuentaMasReciente")
    public void setFechaAperturaCuentaMasReciente(String fechaAperturaCuentaMasReciente) {
        this.fechaAperturaCuentaMasReciente = fechaAperturaCuentaMasReciente;
    }

    public String getTotalSolicitudesReporte() {
        return totalSolicitudesReporte;
    }

    @XmlElement(name = "TotalSolicitudesReporte")
    public void setTotalSolicitudesReporte(String totalSolicitudesReporte) {
        this.totalSolicitudesReporte = totalSolicitudesReporte;
    }

    public String getFechaSolicitudReporteMasReciente() {
        return fechaSolicitudReporteMasReciente;
    }

    @XmlElement(name = "FechaSolicitudReporteMasReciente")
    public void setFechaSolicitudReporteMasReciente(String fechaSolicitudReporteMasReciente) {
        this.fechaSolicitudReporteMasReciente = fechaSolicitudReporteMasReciente;
    }

    public String getNumeroTotalCuentasDespachoCobranza() {
        return numeroTotalCuentasDespachoCobranza;
    }

    @XmlElement(name = "NumeroTotalCuentasDespachoCobranza")
    public void setNumeroTotalCuentasDespachoCobranza(String numeroTotalCuentasDespachoCobranza) {
        this.numeroTotalCuentasDespachoCobranza = numeroTotalCuentasDespachoCobranza;
    }

    public String getFechaAperturaCuentaMasRecienteDespachoCobranza() {
        return fechaAperturaCuentaMasRecienteDespachoCobranza;
    }

    @XmlElement(name = "FechaAperturaCuentaMasRecienteDespachoCobranza")
    public void setFechaAperturaCuentaMasRecienteDespachoCobranza(String fechaAperturaCuentaMasRecienteDespachoCobranza) {
        this.fechaAperturaCuentaMasRecienteDespachoCobranza = fechaAperturaCuentaMasRecienteDespachoCobranza;
    }

    public String getNumeroTotalSolicitudesDespachosCobranza() {
        return numeroTotalSolicitudesDespachosCobranza;
    }

    @XmlElement(name = "NumeroTotalSolicitudesDespachosCobranza")
    public void setNumeroTotalSolicitudesDespachosCobranza(String numeroTotalSolicitudesDespachosCobranza) {
        this.numeroTotalSolicitudesDespachosCobranza = numeroTotalSolicitudesDespachosCobranza;
    }

    public String getFechaSolicitudMasRecienteDespachoCobranza() {
        return fechaSolicitudMasRecienteDespachoCobranza;
    }

    @XmlElement(name = "FechaSolicitudMasRecienteDespachoCobranza")
    public void setFechaSolicitudMasRecienteDespachoCobranza(String fechaSolicitudMasRecienteDespachoCobranza) {
        this.fechaSolicitudMasRecienteDespachoCobranza = fechaSolicitudMasRecienteDespachoCobranza;
    }

    @Override
    public String toString() {
        return "ResumenReporte{" +
                "fechaIngresoBD='" + fechaIngresoBD + '\'' +
                ", numeroMOP7='" + numeroMOP7 + '\'' +
                ", numeroMOP6='" + numeroMOP6 + '\'' +
                ", numeroMOP5='" + numeroMOP5 + '\'' +
                ", numeroMOP4='" + numeroMOP4 + '\'' +
                ", numeroMOP3='" + numeroMOP3 + '\'' +
                ", numeroMOP2='" + numeroMOP2 + '\'' +
                ", numeroMOP1='" + numeroMOP1 + '\'' +
                ", numeroMOP0='" + numeroMOP0 + '\'' +
                ", numeroMOPUR='" + numeroMOPUR + '\'' +
                ", numeroCuentas='" + numeroCuentas + '\'' +
                ", cuentasPagosFijosHipotecas='" + cuentasPagosFijosHipotecas + '\'' +
                ", cuentasRevolventesAbiertas='" + cuentasRevolventesAbiertas + '\'' +
                ", cuentasCerradas='" + cuentasCerradas + '\'' +
                ", cuentasNegativasActuales='" + cuentasNegativasActuales + '\'' +
                ", cuentasClavesHistoriaNegativa='" + cuentasClavesHistoriaNegativa + '\'' +
                ", cuentasDisputa='" + cuentasDisputa + '\'' +
                ", numeroSolicitudesUltimos6Meses='" + numeroSolicitudesUltimos6Meses + '\'' +
                ", nuevaDireccionReportadaUltimos60Dias='" + nuevaDireccionReportadaUltimos60Dias + '\'' +
                ", mensajesAlerta='" + mensajesAlerta + '\'' +
                ", existenciaDeclaracionesConsumidor='" + existenciaDeclaracionesConsumidor + '\'' +
                ", tipoMoneda='" + tipoMoneda + '\'' +
                ", totalCreditosMaximosRevolventes='" + totalCreditosMaximosRevolventes + '\'' +
                ", totalLimitesCreditoRevolventes='" + totalLimitesCreditoRevolventes + '\'' +
                ", totalSaldosActualesRevolventes='" + totalSaldosActualesRevolventes + '\'' +
                ", totalSaldosVencidosRevolventes='" + totalSaldosVencidosRevolventes + '\'' +
                ", totalPagosRevolventes='" + totalPagosRevolventes + '\'' +
                ", pctLimiteCreditoUtilizadoRevolventes='" + pctLimiteCreditoUtilizadoRevolventes + '\'' +
                ", totalCreditosMaximosPagosFijos='" + totalCreditosMaximosPagosFijos + '\'' +
                ", totalSaldosActualesPagosFijos='" + totalSaldosActualesPagosFijos + '\'' +
                ", totalSaldosVencidosPagosFijos='" + totalSaldosVencidosPagosFijos + '\'' +
                ", totalPagosPagosFijos='" + totalPagosPagosFijos + '\'' +
                ", numeroMOP96='" + numeroMOP96 + '\'' +
                ", numeroMOP97='" + numeroMOP97 + '\'' +
                ", numeroMOP99='" + numeroMOP99 + '\'' +
                ", fechaAperturaCuentaMasAntigua='" + fechaAperturaCuentaMasAntigua + '\'' +
                ", fechaAperturaCuentaMasReciente='" + fechaAperturaCuentaMasReciente + '\'' +
                ", totalSolicitudesReporte='" + totalSolicitudesReporte + '\'' +
                ", fechaSolicitudReporteMasReciente='" + fechaSolicitudReporteMasReciente + '\'' +
                ", numeroTotalCuentasDespachoCobranza='" + numeroTotalCuentasDespachoCobranza + '\'' +
                ", fechaAperturaCuentaMasRecienteDespachoCobranza='" + fechaAperturaCuentaMasRecienteDespachoCobranza + '\'' +
                ", numeroTotalSolicitudesDespachosCobranza='" + numeroTotalSolicitudesDespachosCobranza + '\'' +
                ", fechaSolicitudMasRecienteDespachoCobranza='" + fechaSolicitudMasRecienteDespachoCobranza + '\'' +
                '}';
    }
}
