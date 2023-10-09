package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * The persistent class for the wf_usuario database table.
 * 
 */
@Entity
@Table(name = "wf_usuario", schema = "cob_workflow")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_usuario", initialValue = 0, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla",
	// valueColumnName = "siguiente", pkColumnValue = "wf_usuario")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_usuario")
	@Column(name = "us_id_usuario")
	private Integer idUser;

	@Column(name = "us_codigo_empresa")
	private Short idCompany;

	@Column(name = "us_estado_usuario")
	private String status;

	@Column(name = "us_fecha_creacion_usr")
	private Calendar creationDate;

	@Column(name = "us_login")
	private String login;

	@Column(name = "us_num_act_asignadas")
	private Integer activitiesAssigned;

	@Column(name = "us_oficina")
	private Short office;

	@Column(name = "us_tiempo_asignado")
	private Integer assignedTime;

	@ManyToOne
	@JoinColumn(name = "us_id_usuario_sustituto")
	private User sutituteUser;

	public User() {

	}

	/**
	 * @return the idUser
	 */
	public Integer getIdUser() {
		return idUser;
	}

	/**
	 * @param idUser
	 *            the idUser to set
	 */
	public void setIdUser(Integer idUser) {
		this.idUser = idUser;
	}

	/**
	 * @return the idCompany
	 */
	public Short getIdCompany() {
		return idCompany;
	}

	/**
	 * @param idCompany
	 *            the idCompany to set
	 */
	public void setIdCompany(Short idCompany) {
		this.idCompany = idCompany;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the creationDate
	 */
	public Calendar getCreationDate() {
		return creationDate;
	}

	/**
	 * @param creationDate
	 *            the creationDate to set
	 */
	public void setCreationDate(Calendar creationDate) {
		this.creationDate = creationDate;
	}

	/**
	 * @return the login
	 */
	public String getLogin() {
		return login;
	}

	/**
	 * @param login
	 *            the login to set
	 */
	public void setLogin(String login) {
		this.login = login;
	}

	/**
	 * @return the activitiesAssigned
	 */
	public Integer getActivitiesAssigned() {
		return activitiesAssigned;
	}

	/**
	 * @param activitiesAssigned
	 *            the activitiesAssigned to set
	 */
	public void setActivitiesAssigned(Integer activitiesAssigned) {
		this.activitiesAssigned = activitiesAssigned;
	}

	/**
	 * @return the office
	 */
	public Short getOffice() {
		return office;
	}

	/**
	 * @param office
	 *            the office to set
	 */
	public void setOffice(Short office) {
		this.office = office;
	}

	/**
	 * @return the assignedTime
	 */
	public Integer getAssignedTime() {
		return assignedTime;
	}

	/**
	 * @param assignedTime
	 *            the assignedTime to set
	 */
	public void setAssignedTime(Integer assignedTime) {
		this.assignedTime = assignedTime;
	}

	/**
	 * @return the sutituteUser
	 */
	public User getSutituteUser() {
		return sutituteUser;
	}

	/**
	 * @param sutituteUser
	 *            the sutituteUser to set
	 */
	public void setSutituteUser(User sutituteUser) {
		this.sutituteUser = sutituteUser;
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
		result = prime * result + ((idUser == null) ? 0 : idUser.hashCode());
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
		User other = (User) obj;
		if (idUser == null) {
			if (other.idUser != null)
				return false;
		} else if (!idUser.equals(other.idUser))
			return false;
		return true;
	}

}