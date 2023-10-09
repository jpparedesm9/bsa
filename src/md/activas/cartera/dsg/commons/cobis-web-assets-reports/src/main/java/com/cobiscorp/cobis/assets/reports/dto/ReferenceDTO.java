package com.cobiscorp.cobis.assets.reports.dto;

import java.awt.image.BufferedImage;
import java.util.List;

public class ReferenceDTO {

	private List<Payment> referencias;
	private List<DetallePaymentGar> detallePagos;

	public ReferenceDTO(List<Payment> referencias) {
		this.referencias = referencias;
	}

	public ReferenceDTO(List<Payment> referencias, List<DetallePaymentGar> detallePagos) {
		this.referencias = referencias;
		this.detallePagos = detallePagos;
	}

	public List<Payment> getReferencias() {
		return referencias;
	}

	public void setReferencias(List<Payment> referencias) {
		this.referencias = referencias;
	}

	public List<DetallePaymentGar> getDetallePagos() {
		return detallePagos;
	}

	public void setDetallePagos(List<DetallePaymentGar> detallePagos) {
		this.detallePagos = detallePagos;
	}

	public static class Payment {
		private String institucion;
		private String referencia;
		private String nroConvenio;
		private BufferedImage barCode;

		public BufferedImage getBarCode() {
			return barCode;
		}

		public void setBarCode(BufferedImage barCode) {
			this.barCode = barCode;
		}

		public Payment(String institucion, String referencia, String nroConvenio) {
			this.institucion = institucion;
			this.referencia = referencia;
			this.nroConvenio = nroConvenio;

		}

		public Payment(String institucion, String referencia, String nroConvenio, BufferedImage barcode) {
			this.institucion = institucion;
			this.referencia = referencia;
			this.nroConvenio = nroConvenio;
			this.barCode = barcode;
		}

		public String getInstitucion() {
			return institucion;
		}

		public void setInstitucion(String institucion) {
			this.institucion = institucion;
		}

		public String getReferencia() {
			return referencia;
		}

		public void setReferencia(String referencia) {
			this.referencia = referencia;
		}

		public String getNroConvenio() {
			return nroConvenio;
		}

		public void setNroConvenio(String nroConvenio) {
			this.nroConvenio = nroConvenio;
		}

	}

	public static class DetallePaymentGar {
		private String nombreCliente;
		private Double seguroVida;
		private Double pagoAdelantado;
		private Double asistenciaMedica;

		public DetallePaymentGar() {

		}

		public DetallePaymentGar(String nombreCliente, Double seguroVida, Double pagoAdelantado, Double asistenciaMedica) {
			this.nombreCliente = nombreCliente;
			this.seguroVida = seguroVida;
			this.pagoAdelantado = pagoAdelantado;
			this.asistenciaMedica = asistenciaMedica;
		}

		public String getNombreCliente() {
			return nombreCliente;
		}

		public void setNombreCliente(String nombreCliente) {
			this.nombreCliente = nombreCliente;
		}

		public Double getSeguroVida() {
			return seguroVida;
		}

		public void setSeguroVida(Double seguroVida) {
			this.seguroVida = seguroVida;
		}

		public Double getPagoAdelantado() {
			return pagoAdelantado;
		}

		public void setPagoAdelantado(Double pagoAdelantado) {
			this.pagoAdelantado = pagoAdelantado;
		}

		public Double getAsistenciaMedica() {
			return asistenciaMedica;
		}

		public void setAsistenciaMedica(Double asistenciaMedica) {
			this.asistenciaMedica = asistenciaMedica;
		}

	}

}
