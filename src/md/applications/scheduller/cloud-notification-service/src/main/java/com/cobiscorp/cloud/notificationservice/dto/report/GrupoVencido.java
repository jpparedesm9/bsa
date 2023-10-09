package com.cobiscorp.cloud.notificationservice.dto.report;

import java.math.BigDecimal;

public class GrupoVencido {

	public GrupoVencido(Integer coordId, String coordinador, Integer grupoId,
			String grupo, Integer asesorId, String asesor, Integer gerenteId, String gerente,
			Integer cuotasVencidas, BigDecimal valorVencido,
			BigDecimal cuotaActual) {

		this.coordId = coordId;
		this.coordinador = coordinador;
		this.grupoId = grupoId;
		this.grupo = grupo;
		this.asesorId = asesorId;
		this.asesor = asesor;
		this.cuotasVencidas = cuotasVencidas;
		this.valorVencido = valorVencido;
		this.cuotaActual = cuotaActual;
		this.gerenteId = gerenteId;
		this.gerente = gerente;

	}

	public Integer gerenteId;
	public String gerente;
	public Integer coordId;
	public String coordinador;
	public Integer grupoId;
	public String grupo;
	public Integer asesorId;
	public String asesor;
	public Integer cuotasVencidas;
	public BigDecimal valorVencido;
	public BigDecimal cuotaActual;

	public Integer getGerenteId() {
		return gerenteId;
	}
	
	public void setGerenteId(Integer gerenteId) {
		this.gerenteId = gerenteId;
	}
	
	public String getGerente() {
		return gerente;
	}
	
	public void setGerente(String gerente) {
		this.gerente = gerente;
	}
	
	public Integer getCoordId() {
		return coordId;
	}

	public void setCoordId(Integer coordId) {
		this.coordId = coordId;
	}

	public String getCoordinador() {
		return coordinador;
	}

	public void setCoordinador(String coordinador) {
		this.coordinador = coordinador;
	}

	public Integer getGrupoId() {
		return grupoId;
	}

	public void setGrupoId(Integer grupoId) {
		this.grupoId = grupoId;
	}

	public String getGrupo() {
		return grupo;
	}

	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}

	public Integer getAsesorId() {
		return asesorId;
	}

	public void setAsesorId(Integer asesorId) {
		this.asesorId = asesorId;
	}

	public String getAsesor() {
		return asesor;
	}

	public void setAsesor(String asesor) {
		this.asesor = asesor;
	}

	public Integer getCuotasVencidas() {
		return cuotasVencidas;
	}

	public void setCuotasVencidas(Integer cuotasVencidas) {
		this.cuotasVencidas = cuotasVencidas;
	}

	public BigDecimal getValorVencido() {
		return valorVencido;
	}

	public void setValorVencido(BigDecimal valorVencido) {
		this.valorVencido = valorVencido;
	}

	public BigDecimal getCuotaActual() {
		return cuotaActual;
	}

	public void setCuotaActual(BigDecimal cuotaActual) {
		this.cuotaActual = cuotaActual;
	}

}
