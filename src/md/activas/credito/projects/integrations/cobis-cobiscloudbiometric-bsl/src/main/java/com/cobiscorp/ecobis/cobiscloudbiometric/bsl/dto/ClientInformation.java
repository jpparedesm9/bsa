package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ClientInformation {
	
	String ocr;
	String cic;
	String nombre;
	String apellidoPaterno;
	String apellidoMaterno;
	String anioRegistro;
	String anioEmision;
	String numeroEmisionCredencial;
	String claveElector;
	String curp;
	String lugarNacimiento;
	String lugarNacimientoEquivalente;
	String fechaNacimiento;
	String idCanal;
	String buc;
	
	//Informacion Adicional
	String ipLocal;
	String idUsuario;
	String idSesionCliente;
	String idCliente;
	
	String sesionSN;
	String idAplicativo;
	
	PAdicional pAdicional;
	
	Integer officeId;
	
	
	public String getOcr() {
		return ocr;
	}
	public void setOcr(String ocr) {
		this.ocr = ocr;
	}
	public String getCic() {
		return cic;
	}
	public void setCic(String cic) {
		this.cic = cic;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getAnioRegistro() {
		return anioRegistro;
	}
	public void setAnioRegistro(String anioRegistro) {
		this.anioRegistro = anioRegistro;
	}
	public String getAnioEmision() {
		return anioEmision;
	}
	public void setAnioEmision(String anioEmision) {
		this.anioEmision = anioEmision;
	}
	public String getNumeroEmisionCredencial() {
		return numeroEmisionCredencial;
	}
	public void setNumeroEmisionCredencial(String numeroEmisionCredencial) {
		this.numeroEmisionCredencial = numeroEmisionCredencial;
	}
	public String getClaveElector() {
		return claveElector;
	}
	public void setClaveElector(String claveElector) {
		this.claveElector = claveElector;
	}
	public String getCurp() {
		return curp;
	}
	public void setCurp(String curp) {
		this.curp = curp;
	}
	public String getIpLocal() {
		return ipLocal;
	}
	public void setIpLocal(String ipLocal) {
		this.ipLocal = ipLocal;
	}
	public String getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(String idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getIdSesionCliente() {
		return idSesionCliente;
	}
	public void setIdSesionCliente(String idSesionCliente) {
		this.idSesionCliente = idSesionCliente;
	}
	public String getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}
	public String getLugarNacimiento() {
		return lugarNacimiento;
	}
	public void setLugarNacimiento(String lugarNacimiento) {
		this.lugarNacimiento = lugarNacimiento;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getIdCanal() {
		return idCanal;
	}
	public void setIdCanal(String idCanal) {
		this.idCanal = idCanal;
	}
	public String getBuc() {
		return buc;
	}
	public void setBuc(String buc) {
		this.buc = buc;
	}
	public String getLugarNacimientoEquivalente() {
		return lugarNacimientoEquivalente;
	}
	public void setLugarNacimientoEquivalente(String lugarNacimientoEquivalente) {
		this.lugarNacimientoEquivalente = lugarNacimientoEquivalente;
	}
	
	public String getSesionSN() {
		return sesionSN;
	}
	public void setSesionSN(String sesionSN) {
		this.sesionSN = sesionSN;
	}
	public String getIdAplicativo() {
		return idAplicativo;
	}
	public void setIdAplicativo(String idAplicativo) {
		this.idAplicativo = idAplicativo;
	}
	


	public PAdicional getpAdicional() {
		return pAdicional;
	}
	public void setpAdicional(PAdicional pAdicional) {
		this.pAdicional = pAdicional;
	}
	
	
	public Integer getOfficeId() {
		return officeId;
	}
	public void setOfficeId(Integer officeId) {
		this.officeId = officeId;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ClientInformation [ocr=");
		builder.append(ocr);
		builder.append(", cic=");
		builder.append(cic);
		builder.append(", nombre=");
		builder.append(nombre);
		builder.append(", apellidoPaterno=");
		builder.append(apellidoPaterno);
		builder.append(", apellidoMaterno=");
		builder.append(apellidoMaterno);
		builder.append(", anioRegistro=");
		builder.append(anioRegistro);
		builder.append(", anioEmision=");
		builder.append(anioEmision);
		builder.append(", numeroEmisionCredencial=");
		builder.append(numeroEmisionCredencial);
		builder.append(", claveElector=");
		builder.append(claveElector);
		builder.append(", curp=");
		builder.append(curp);
		builder.append(", lugarNacimiento=");
		builder.append(lugarNacimiento);
		builder.append(", lugarNacimientoEquivalente=");
		builder.append(lugarNacimientoEquivalente);
		builder.append(", fechaNacimiento=");
		builder.append(fechaNacimiento);
		builder.append(", idCanal=");
		builder.append(idCanal);
		builder.append(", buc=");
		builder.append(buc);
		builder.append(", ipLocal=");
		builder.append(ipLocal);
		builder.append(", idUsuario=");
		builder.append(idUsuario);
		builder.append(", idSesionCliente=");
		builder.append(idSesionCliente);
		builder.append(", idCliente=");
		builder.append(idCliente);		
		builder.append(", sesionSN=");
		builder.append(sesionSN);
		builder.append(", idAplicativo=");
		builder.append(idAplicativo);
		builder.append(", PAdicional=");
		builder.append(pAdicional);
		builder.append(", officeId=");
		builder.append(officeId);
		builder.append("]");
		return builder.toString();
	}
	
	
	
}
