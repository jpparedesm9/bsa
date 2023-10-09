package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

public class Cuenta {
    private String fechaActualizacion;
    private String registroImpugnado;
    private String claveOtorgante;
    private String nombreOtorgante;
    private String numeroTelefonoOtorgante;
    private String identificadorSociedadCrediticia;
    private String numeroCuentaActual;
    private String indicadorTipoResponsabilidad;
    private String tipoCuenta;
    private String tipoContrato;
    private String claveUnidadMonetaria;
    private String valorActivoValuacion;
    private String numeroPagos;
    private String frecuenciaPagos;
    private String montoPagar;
    private String fechaAperturaCuenta;
    private String fechaUltimoPago;
    private String fechaUltimaCompra;
    private String fechaCierreCuenta;
    private String fechaReporte;
    private String modoReportar;
    private String ultimaFechaSaldoCero;
    private String garantia;
    private String creditoMaximo;
    private String saldoActual;
    private String limiteCredito;
    private String saldoVencido;
    private String numeroPagosVencidos;
    private String formaPagoActual;
    private String historicoPagos;
    private String fechaMasRecienteHistoricoPagos;
    private String fechaMasAntiguaHistoricoPagos;
    private String claveObservacion;
    private String totalPagosReportados;
    private String totalPagosCalificadosMOP2;
    private String totalPagosCalificadosMOP3;
    private String totalPagosCalificadosMOP4;
    private String totalPagosCalificadosMOP5;
    private String importeSaldoMorosidadHistMasGrave;
    private String fechaHistoricaMorosidadMasGrave;
    private String mopHistoricoMorosidadMasGrave;
    private String montoUltimoPago;
    private String fechaInicioReestructura;

    public String getFechaActualizacion() {
        return fechaActualizacion;
    }

    @XmlElement(name = "FechaActualizacion")
    public void setFechaActualizacion(String fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }

    public String getRegistroImpugnado() {
        return registroImpugnado;
    }

    @XmlElement(name = "RegistroImpugnado")
    public void setRegistroImpugnado(String registroImpugnado) {
        this.registroImpugnado = registroImpugnado;
    }

    public String getClaveOtorgante() {
        return claveOtorgante;
    }

    @XmlElement(name = "ClaveOtorgante")
    public void setClaveOtorgante(String claveOtorgante) {
        this.claveOtorgante = claveOtorgante;
    }

    public String getNombreOtorgante() {
        return nombreOtorgante;
    }

    @XmlElement(name = "NombreOtorgante")
    public void setNombreOtorgante(String nombreOtorgante) {
        this.nombreOtorgante = nombreOtorgante;
    }

    public String getNumeroTelefonoOtorgante() {
        return numeroTelefonoOtorgante;
    }

    @XmlElement(name = "NumeroTelefonoOtorgante")
    public void setNumeroTelefonoOtorgante(String numeroTelefonoOtorgante) {
        this.numeroTelefonoOtorgante = numeroTelefonoOtorgante;
    }

    public String getIdentificadorSociedadCrediticia() {
        return identificadorSociedadCrediticia;
    }

    @XmlElement(name = "IdentificadorSociedadCrediticia")
    public void setIdentificadorSociedadCrediticia(String identificadorSociedadCrediticia) {
        this.identificadorSociedadCrediticia = identificadorSociedadCrediticia;
    }

    public String getNumeroCuentaActual() {
        return numeroCuentaActual;
    }

    @XmlElement(name = "NumeroCuentaActual")
    public void setNumeroCuentaActual(String numeroCuentaActual) {
        this.numeroCuentaActual = numeroCuentaActual;
    }

    public String getIndicadorTipoResponsabilidad() {
        return indicadorTipoResponsabilidad;
    }

    @XmlElement(name = "IndicadorTipoResponsabilidad")
    public void setIndicadorTipoResponsabilidad(String indicadorTipoResponsabilidad) {
        this.indicadorTipoResponsabilidad = indicadorTipoResponsabilidad;
    }

    public String getTipoCuenta() {
        return tipoCuenta;
    }

    @XmlElement(name = "TipoCuenta")
    public void setTipoCuenta(String tipoCuenta) {
        this.tipoCuenta = tipoCuenta;
    }

    public String getTipoContrato() {
        return tipoContrato;
    }

    @XmlElement(name = "TipoContrato")
    public void setTipoContrato(String tipoContrato) {
        this.tipoContrato = tipoContrato;
    }

    public String getClaveUnidadMonetaria() {
        return claveUnidadMonetaria;
    }

    @XmlElement(name = "ClaveUnidadMonetaria")
    public void setClaveUnidadMonetaria(String claveUnidadMonetaria) {
        this.claveUnidadMonetaria = claveUnidadMonetaria;
    }

    public String getValorActivoValuacion() {
        return valorActivoValuacion;
    }

    @XmlElement(name = "ValorActivoValuacion")
    public void setValorActivoValuacion(String valorActivoValuacion) {
        this.valorActivoValuacion = valorActivoValuacion;
    }

    public String getNumeroPagos() {
        return numeroPagos;
    }

    @XmlElement(name = "NumeroPagos")
    public void setNumeroPagos(String numeroPagos) {
        this.numeroPagos = numeroPagos;
    }

    public String getFrecuenciaPagos() {
        return frecuenciaPagos;
    }

    @XmlElement(name = "FrecuenciaPagos")
    public void setFrecuenciaPagos(String frecuenciaPagos) {
        this.frecuenciaPagos = frecuenciaPagos;
    }

    public String getMontoPagar() {
        return montoPagar;
    }

    @XmlElement(name = "MontoPagar")
    public void setMontoPagar(String montoPagar) {
        this.montoPagar = montoPagar;
    }

    public String getFechaAperturaCuenta() {
        return fechaAperturaCuenta;
    }

    @XmlElement(name = "FechaAperturaCuenta")
    public void setFechaAperturaCuenta(String fechaAperturaCuenta) {
        this.fechaAperturaCuenta = fechaAperturaCuenta;
    }

    public String getFechaUltimoPago() {
        return fechaUltimoPago;
    }

    @XmlElement(name = "FechaUltimoPago")
    public void setFechaUltimoPago(String fechaUltimoPago) {
        this.fechaUltimoPago = fechaUltimoPago;
    }

    public String getFechaUltimaCompra() {
        return fechaUltimaCompra;
    }

    @XmlElement(name = "FechaUltimaCompra")
    public void setFechaUltimaCompra(String fechaUltimaCompra) {
        this.fechaUltimaCompra = fechaUltimaCompra;
    }

    public String getFechaCierreCuenta() {
        return fechaCierreCuenta;
    }

    @XmlElement(name = "FechaCierreCuenta")
    public void setFechaCierreCuenta(String fechaCierreCuenta) {
        this.fechaCierreCuenta = fechaCierreCuenta;
    }

    public String getFechaReporte() {
        return fechaReporte;
    }

    @XmlElement(name = "FechaReporte")
    public void setFechaReporte(String fechaReporte) {
        this.fechaReporte = fechaReporte;
    }

    public String getModoReportar() {
        return modoReportar;
    }

    @XmlElement(name = "ModoReportar")
    public void setModoReportar(String modoReportar) {
        this.modoReportar = modoReportar;
    }

    public String getUltimaFechaSaldoCero() {
        return ultimaFechaSaldoCero;
    }

    @XmlElement(name = "UltimaFechaSaldoCero")
    public void setUltimaFechaSaldoCero(String ultimaFechaSaldoCero) {
        this.ultimaFechaSaldoCero = ultimaFechaSaldoCero;
    }

    public String getGarantia() {
        return garantia;
    }

    @XmlElement(name = "Garantia")
    public void setGarantia(String garantia) {
        this.garantia = garantia;
    }

    public String getCreditoMaximo() {
        return creditoMaximo;
    }

    @XmlElement(name = "CreditoMaximo")
    public void setCreditoMaximo(String creditoMaximo) {
        this.creditoMaximo = creditoMaximo;
    }

    public String getSaldoActual() {
        return saldoActual;
    }

    @XmlElement(name = "SaldoActual")
    public void setSaldoActual(String saldoActual) {
        this.saldoActual = saldoActual;
    }

    public String getLimiteCredito() {
        return limiteCredito;
    }

    @XmlElement(name = "LimiteCredito")
    public void setLimiteCredito(String limiteCredito) {
        this.limiteCredito = limiteCredito;
    }

    public String getSaldoVencido() {
        return saldoVencido;
    }

    @XmlElement(name = "SaldoVencido")
    public void setSaldoVencido(String saldoVencido) {
        this.saldoVencido = saldoVencido;
    }

    public String getNumeroPagosVencidos() {
        return numeroPagosVencidos;
    }

    @XmlElement(name = "NumeroPagosVencidos")
    public void setNumeroPagosVencidos(String numeroPagosVencidos) {
        this.numeroPagosVencidos = numeroPagosVencidos;
    }

    public String getFormaPagoActual() {
        return formaPagoActual;
    }

    @XmlElement(name = "FormaPagoActual")
    public void setFormaPagoActual(String formaPagoActual) {
        this.formaPagoActual = formaPagoActual;
    }

    public String getHistoricoPagos() {
        return historicoPagos;
    }

    @XmlElement(name = "HistoricoPagos")
    public void setHistoricoPagos(String historicoPagos) {
        this.historicoPagos = historicoPagos;
    }

    public String getFechaMasRecienteHistoricoPagos() {
        return fechaMasRecienteHistoricoPagos;
    }

    @XmlElement(name = "FechaMasRecienteHistoricoPagos")
    public void setFechaMasRecienteHistoricoPagos(String fechaMasRecienteHistoricoPagos) {
        this.fechaMasRecienteHistoricoPagos = fechaMasRecienteHistoricoPagos;
    }

    public String getFechaMasAntiguaHistoricoPagos() {
        return fechaMasAntiguaHistoricoPagos;
    }

    @XmlElement(name = "FechaMasAntiguaHistoricoPagos")
    public void setFechaMasAntiguaHistoricoPagos(String fechaMasAntiguaHistoricoPagos) {
        this.fechaMasAntiguaHistoricoPagos = fechaMasAntiguaHistoricoPagos;
    }

    public String getClaveObservacion() {
        return claveObservacion;
    }

    @XmlElement(name = "ClaveObservacion")
    public void setClaveObservacion(String claveObservacion) {
        this.claveObservacion = claveObservacion;
    }

    public String getTotalPagosReportados() {
        return totalPagosReportados;
    }

    @XmlElement(name = "TotalPagosReportados")
    public void setTotalPagosReportados(String totalPagosReportados) {
        this.totalPagosReportados = totalPagosReportados;
    }

    public String getTotalPagosCalificadosMOP2() {
        return totalPagosCalificadosMOP2;
    }

    @XmlElement(name = "TotalPagosCalificadosMOP2")
    public void setTotalPagosCalificadosMOP2(String totalPagosCalificadosMOP2) {
        this.totalPagosCalificadosMOP2 = totalPagosCalificadosMOP2;
    }

    public String getTotalPagosCalificadosMOP3() {
        return totalPagosCalificadosMOP3;
    }

    @XmlElement(name = "TotalPagosCalificadosMOP3")
    public void setTotalPagosCalificadosMOP3(String totalPagosCalificadosMOP3) {
        this.totalPagosCalificadosMOP3 = totalPagosCalificadosMOP3;
    }

    public String getTotalPagosCalificadosMOP4() {
        return totalPagosCalificadosMOP4;
    }

    @XmlElement(name = "TotalPagosCalificadosMOP4")
    public void setTotalPagosCalificadosMOP4(String totalPagosCalificadosMOP4) {
        this.totalPagosCalificadosMOP4 = totalPagosCalificadosMOP4;
    }

    public String getTotalPagosCalificadosMOP5() {
        return totalPagosCalificadosMOP5;
    }

    @XmlElement(name = "TotalPagosCalificadosMOP5")
    public void setTotalPagosCalificadosMOP5(String totalPagosCalificadosMOP5) {
        this.totalPagosCalificadosMOP5 = totalPagosCalificadosMOP5;
    }

    public String getImporteSaldoMorosidadHistMasGrave() {
        return importeSaldoMorosidadHistMasGrave;
    }

    @XmlElement(name = "ImporteSaldoMorosidadHistMasGrave")
    public void setImporteSaldoMorosidadHistMasGrave(String importeSaldoMorosidadHistMasGrave) {
        this.importeSaldoMorosidadHistMasGrave = importeSaldoMorosidadHistMasGrave;
    }

    public String getFechaHistoricaMorosidadMasGrave() {
        return fechaHistoricaMorosidadMasGrave;
    }

    @XmlElement(name = "FechaHistoricaMorosidadMasGrave")
    public void setFechaHistoricaMorosidadMasGrave(String fechaHistoricaMorosidadMasGrave) {
        this.fechaHistoricaMorosidadMasGrave = fechaHistoricaMorosidadMasGrave;
    }

    public String getMopHistoricoMorosidadMasGrave() {
        return mopHistoricoMorosidadMasGrave;
    }

    @XmlElement(name = "MopHistoricoMorosidadMasGrave")
    public void setMopHistoricoMorosidadMasGrave(String mopHistoricoMorosidadMasGrave) {
        this.mopHistoricoMorosidadMasGrave = mopHistoricoMorosidadMasGrave;
    }

    public String getMontoUltimoPago() {
        return montoUltimoPago;
    }

    @XmlElement(name = "MontoUltimoPago")
    public void setMontoUltimoPago(String montoUltimoPago) {
        this.montoUltimoPago = montoUltimoPago;
    }

    public String getFechaInicioReestructura() {
        return fechaInicioReestructura;
    }

    @XmlElement(name = "FechaInicioReestructura")
    public void setFechaInicioReestructura(String fechaInicioReestructura) {
        this.fechaInicioReestructura = fechaInicioReestructura;
    }

    @Override
    public String toString() {
        return "Cuenta{" +
                "fechaActualizacion='" + fechaActualizacion + '\'' +
                ", registroImpugnado='" + registroImpugnado + '\'' +
                ", claveOtorgante='" + claveOtorgante + '\'' +
                ", nombreOtorgante='" + nombreOtorgante + '\'' +
                ", numeroTelefonoOtorgante='" + numeroTelefonoOtorgante + '\'' +
                ", identificadorSociedadCrediticia='" + identificadorSociedadCrediticia + '\'' +
                ", numeroCuentaActual='" + numeroCuentaActual + '\'' +
                ", indicadorTipoResponsabilidad='" + indicadorTipoResponsabilidad + '\'' +
                ", tipoCuenta='" + tipoCuenta + '\'' +
                ", tipoContrato='" + tipoContrato + '\'' +
                ", claveUnidadMonetaria='" + claveUnidadMonetaria + '\'' +
                ", valorActivoValuacion='" + valorActivoValuacion + '\'' +
                ", numeroPagos='" + numeroPagos + '\'' +
                ", frecuenciaPagos='" + frecuenciaPagos + '\'' +
                ", montoPagar='" + montoPagar + '\'' +
                ", fechaAperturaCuenta='" + fechaAperturaCuenta + '\'' +
                ", fechaUltimoPago='" + fechaUltimoPago + '\'' +
                ", fechaUltimaCompra='" + fechaUltimaCompra + '\'' +
                ", fechaCierreCuenta='" + fechaCierreCuenta + '\'' +
                ", fechaReporte='" + fechaReporte + '\'' +
                ", modoReportar='" + modoReportar + '\'' +
                ", ultimaFechaSaldoCero='" + ultimaFechaSaldoCero + '\'' +
                ", garantia='" + garantia + '\'' +
                ", creditoMaximo='" + creditoMaximo + '\'' +
                ", saldoActual='" + saldoActual + '\'' +
                ", limiteCredito='" + limiteCredito + '\'' +
                ", saldoVencido='" + saldoVencido + '\'' +
                ", numeroPagosVencidos='" + numeroPagosVencidos + '\'' +
                ", formaPagoActual='" + formaPagoActual + '\'' +
                ", historicoPagos='" + historicoPagos + '\'' +
                ", fechaMasRecienteHistoricoPagos='" + fechaMasRecienteHistoricoPagos + '\'' +
                ", fechaMasAntiguaHistoricoPagos='" + fechaMasAntiguaHistoricoPagos + '\'' +
                ", claveObservacion='" + claveObservacion + '\'' +
                ", totalPagosReportados='" + totalPagosReportados + '\'' +
                ", totalPagosCalificadosMOP2='" + totalPagosCalificadosMOP2 + '\'' +
                ", totalPagosCalificadosMOP3='" + totalPagosCalificadosMOP3 + '\'' +
                ", totalPagosCalificadosMOP4='" + totalPagosCalificadosMOP4 + '\'' +
                ", totalPagosCalificadosMOP5='" + totalPagosCalificadosMOP5 + '\'' +
                ", importeSaldoMorosidadHistMasGrave='" + importeSaldoMorosidadHistMasGrave + '\'' +
                ", fechaHistoricaMorosidadMasGrave='" + fechaHistoricaMorosidadMasGrave + '\'' +
                ", mopHistoricoMorosidadMasGrave='" + mopHistoricoMorosidadMasGrave + '\'' +
                ", montoUltimoPago='" + montoUltimoPago + '\'' +
                ", fechaInicioReestructura='" + fechaInicioReestructura + '\'' +
                '}';
    }
}
