package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the wf_info_programa database table.
 * 
 */
@Entity
@Table(name = "wf_info_programa", schema = "cob_workflow")
@NamedQuery(name = "Programa.findByNombrePrograma", query = "SELECT new com.cobiscorp.ecobis.bpl.rules.engine.model.Programa(u.idPrograma, u.descPrograma, u.nombreBdd, u.nombrePrograma, u.nombreServidor, u.tipoPrograma, u.ubicacionPrograma) FROM Programa u WHERE u.nombrePrograma = :nombrePrograma ")
public class Programa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ip_id_programa")
	private int idPrograma;

	@Column(name = "ip_desc_programa")
	private String descPrograma;

	@Column(name = "ip_nombre_bdd")
	private String nombreBdd;

	@Column(name = "ip_nombre_programa")
	private String nombrePrograma;

	@Column(name = "ip_nombre_servidor")
	private String nombreServidor;

	@Column(name = "ip_tipo_programa")
	private String tipoPrograma;

	@Column(name = "ip_ubicacion_programa")
	private String ubicacionPrograma;

	@Column(name = "ip_id_servicio")
	private String idServicio;

	// bi-directional many-to-one association to Variable
	@OneToMany(mappedBy = "programa")
	private List<Variable> variables;

	// bi-directional many-to-one association to Variable
	@OneToMany(mappedBy = "seudoCatalogo")
	private List<Variable> variablesCatalogos;

	public Programa() {
	}

	public Programa(int idPrograma, String descPrograma, String nombreBdd, String nombrePrograma, String nombreServidor, String tipoPrograma,
			String ubicacionPrograma) {
		super();
		this.idPrograma = idPrograma;
		this.descPrograma = descPrograma;
		this.nombreBdd = nombreBdd;
		this.nombrePrograma = nombrePrograma;
		this.nombreServidor = nombreServidor;
		this.tipoPrograma = tipoPrograma;
		this.ubicacionPrograma = ubicacionPrograma;
	}

	public int getIdPrograma() {
		return this.idPrograma;
	}

	public void setIdPrograma(int idPrograma) {
		this.idPrograma = idPrograma;
	}

	public String getDescPrograma() {
		return this.descPrograma;
	}

	public void setDescPrograma(String descPrograma) {
		this.descPrograma = descPrograma;
	}

	public String getNombreBdd() {
		return this.nombreBdd;
	}

	public void setNombreBdd(String nombreBdd) {
		this.nombreBdd = nombreBdd;
	}

	public String getNombrePrograma() {
		return this.nombrePrograma;
	}

	public void setNombrePrograma(String nombrePrograma) {
		this.nombrePrograma = nombrePrograma;
	}

	public String getNombreServidor() {
		return this.nombreServidor;
	}

	public void setNombreServidor(String nombreServidor) {
		this.nombreServidor = nombreServidor;
	}

	public String getTipoPrograma() {
		return this.tipoPrograma;
	}

	public void setTipoPrograma(String tipoPrograma) {
		this.tipoPrograma = tipoPrograma;
	}

	public String getUbicacionPrograma() {
		return this.ubicacionPrograma;
	}

	public void setUbicacionPrograma(String ubicacionPrograma) {
		this.ubicacionPrograma = ubicacionPrograma;
	}

	public List<Variable> getVariables() {
		return this.variables;
	}

	public void setVariables(List<Variable> variables) {
		this.variables = variables;
	}

	public List<Variable> getVariablesCatalogos() {
		return this.variablesCatalogos;
	}

	public void setVariablesCatalogos(List<Variable> variablesCatalogos) {
		this.variablesCatalogos = variablesCatalogos;
	}

	public String getIdServicio() {
		return idServicio;
	}

	public void setIdServicio(String idServicio) {
		this.idServicio = idServicio;
	}

}