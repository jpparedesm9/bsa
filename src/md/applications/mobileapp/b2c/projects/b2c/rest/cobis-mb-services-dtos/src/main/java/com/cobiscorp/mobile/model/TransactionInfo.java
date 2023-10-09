package com.cobiscorp.mobile.model;

public class TransactionInfo {
	private String institucion;
	private String tipoOperacion;
	private String fecha;
	private String hora;
	private String folio;
	private String estado;
	private String mensaje;
	private String monto;
	private String comision;
	private String numeroCuenta;
	private String referencia;
	private String nombreSocio;

	public String getInstitucion() {
		return institucion;
	}

	public void setInstitucion(String institucion) {
		this.institucion = institucion;
	}

	public String getTipoOperacion() {
		return tipoOperacion;
	}

	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public String getFolio() {
		return folio;
	}

	public void setFolio(String folio) {
		this.folio = folio;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public String getMonto() {
		return monto;
	}

	public void setMonto(String monto) {
		this.monto = monto;
	}

	public String getComision() {
		return comision;
	}

	public void setComision(String comision) {
		this.comision = comision;
	}

	public String getNumeroCuenta() {
		return numeroCuenta;
	}

	public void setNumeroCuenta(String numeroCuenta) {
		this.numeroCuenta = numeroCuenta;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}

	public String getNombreSocio() {
		return nombreSocio;
	}

	public void setNombreSocio(String nombreSocio) {
		this.nombreSocio = nombreSocio;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TransactionInfo [institucion=");
		builder.append(institucion);
		builder.append(", tipoOperacion=");
		builder.append(tipoOperacion);
		builder.append(", fecha=");
		builder.append(fecha);
		builder.append(", hora=");
		builder.append(hora);
		builder.append(", folio=");
		builder.append(folio);
		builder.append(", estado=");
		builder.append(estado);
		builder.append(", mensaje=");
		builder.append(mensaje);
		builder.append(", monto=");
		builder.append(monto);
		builder.append(", comision=");
		builder.append(comision);
		builder.append(", numeroCuenta=");
		builder.append(numeroCuenta);
		builder.append(", referencia=");
		builder.append(referencia);
		builder.append(", nombreSocio=");
		builder.append(nombreSocio);
		builder.append("]");
		return builder.toString();
	}
}
