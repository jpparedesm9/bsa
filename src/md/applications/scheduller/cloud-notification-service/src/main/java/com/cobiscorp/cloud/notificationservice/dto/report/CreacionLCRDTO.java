package com.cobiscorp.cloud.notificationservice.dto.report;

public class CreacionLCRDTO {
	
	private Integer ncTramite;
	private String ncFechaReg;
	private Integer ncCliente;
	private String ncNombre;
	private String ncApellidoPaterno;
	private String ncApellidoMaterno;
    private String ncDigito;
	public CreacionLCRDTO(Integer ncTramite, String ncFechaReg, Integer ncCliente, String ncNombre,
			String ncApellidoPaterno, String ncApellidoMaterno, String ncDigito) {
		super();
		this.ncTramite = ncTramite;
		this.ncFechaReg = ncFechaReg;
		this.ncCliente = ncCliente;
		this.ncNombre = ncNombre;
		this.ncApellidoPaterno = ncApellidoPaterno;
		this.ncApellidoMaterno = ncApellidoMaterno;
        this.ncDigito = ncDigito;
	}
	public Integer getNcTramite() {
		return ncTramite;
	}
	public void setNcTramite(Integer ncTramite) {
		this.ncTramite = ncTramite;
	}
	public String getNcFechaReg() {
		return ncFechaReg;
	}
	public void setNcFechaReg(String ncFechaReg) {
		this.ncFechaReg = ncFechaReg;
	}
	public Integer getNcCliente() {
		return ncCliente;
	}
	public void setNcCliente(Integer ncCliente) {
		this.ncCliente = ncCliente;
	}
	public String getNcNombre() {
		return ncNombre;
	}
	public void setNcNombre(String ncNombre) {
		this.ncNombre = ncNombre;
	}
	public String getNcApellidoPaterno() {
		return ncApellidoPaterno;
	}
	public void setNcApellidoPaterno(String ncApellidoPaterno) {
		this.ncApellidoPaterno = ncApellidoPaterno;
	}
	public String getNcApellidoMaterno() {
		return ncApellidoMaterno;
	}
	public void setNcApellidoMaterno(String ncApellidoMaterno) {
		this.ncApellidoMaterno = ncApellidoMaterno;
	}
    public String getNcDigito() {
		return ncDigito;
	}
	public void setNcDigito(String ncDigito) {
		this.ncDigito = ncDigito;
	}
	
	
	
	
}
