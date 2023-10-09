package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The persistent class for the wf_enlace_roles database table.
 * 
 */
@Entity
@Table(name = "wf_enlace_roles", schema = "cob_workflow")
public class LinkRole implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_enlace_roles", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName =
	// "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_enlace_roles")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_enlace_roles")
	@Column(name = "ej_enlace_rol")
	private Integer idLinkRole;

	@Column(name = "ej_codigo_proceso")
	private Integer idProcess;

	@Column(name = "ej_condicion")
	private String condition;

	@Column(name = "ej_inst_excep")
	private String instException;

	@Column(name = "ej_nombre_enlace")
	private String name;

	@Column(name = "ej_prioridad")
	private Short priority;

	@Column(name = "ej_puntos_enlace")
	private String linkPoints;

	@Column(name = "ej_version_proceso")
	private Short versionProcess;

	@Column(name = "ej_id_rol_fin")
	private Integer idFinalRol;

	@Column(name = "ej_id_rol_ini")
	private Integer idInitialRol;

	@ManyToOne(fetch = FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name = "ej_id_rol_fin", referencedColumnName = "ro_id_rol", insertable = false, updatable = false)
	private Role finalRol;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ej_id_rol_ini", referencedColumnName = "ro_id_rol", insertable = false, updatable = false)
	private Role initialRol;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ej_id_jerarquia")
	private Hierarchy hierarchy;

	public LinkRole() {

	}

	public Integer getIdLinkRole() {
		return idLinkRole;
	}

	public void setIdLinkRole(Integer idLinkRole) {
		this.idLinkRole = idLinkRole;
	}

	public Integer getIdProcess() {
		return idProcess;
	}

	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getInstException() {
		return instException;
	}

	public void setInstException(String instException) {
		this.instException = instException;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Short getPriority() {
		return priority;
	}

	public void setPriority(Short priority) {
		this.priority = priority;
	}

	public String getLinkPoints() {
		return linkPoints;
	}

	public void setLinkPoints(String linkPoints) {
		this.linkPoints = linkPoints;
	}

	public Short getVersionProcess() {
		return versionProcess;
	}

	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
	}

	public Integer getIdFinalRol() {
		return idFinalRol;
	}

	public void setIdFinalRol(Integer idFinalRol) {
		this.idFinalRol = idFinalRol;
	}

	public Integer getIdInitialRol() {
		return idInitialRol;
	}

	public void setIdInitialRol(Integer idInitialRol) {
		this.idInitialRol = idInitialRol;
	}

	public Role getFinalRol() {
		return finalRol;
	}

	public void setFinalRol(Role finalRol) {
		this.finalRol = finalRol;
	}

	public Role getInitialRol() {
		return initialRol;
	}

	public void setInitialRol(Role initialRol) {
		this.initialRol = initialRol;
	}

	public Hierarchy getHierarchy() {
		return hierarchy;
	}

	public void setHierarchy(Hierarchy hierarchy) {
		this.hierarchy = hierarchy;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idLinkRole == null) ? 0 : idLinkRole.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LinkRole other = (LinkRole) obj;
		if (idLinkRole == null) {
			if (other.idLinkRole != null)
				return false;
		} else if (!idLinkRole.equals(other.idLinkRole))
			return false;
		return true;
	}

}