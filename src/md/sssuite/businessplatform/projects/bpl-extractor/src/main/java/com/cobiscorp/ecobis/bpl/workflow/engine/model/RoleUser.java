package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The persistent class for the wf_usuario_rol database table.
 * 
 */
@Entity
@Table(name = "wf_usuario_rol", schema = "cob_workflow")
public class RoleUser implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdRoleUser idRoleUser;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ur_id_usuario", referencedColumnName = "us_id_usuario", insertable = false, updatable = false)
	private User user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ur_id_rol", referencedColumnName = "ro_id_rol", insertable = false, updatable = false)
	private Role role;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ur_id_usuario_sustituto")
	private User userSutitute;

	@Column(name = "ur_estado_login")
	private String status;

	public RoleUser() {

	}

	/**
	 * @return the idRoleUser
	 */
	public IdRoleUser getIdRoleUser() {
		return idRoleUser;
	}

	/**
	 * @param idRoleUser
	 *            the idRoleUser to set
	 */
	public void setIdRoleUser(IdRoleUser idRoleUser) {
		this.idRoleUser = idRoleUser;
	}

	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the role
	 */
	public Role getRole() {
		return role;
	}

	/**
	 * @param role
	 *            the role to set
	 */
	public void setRole(Role role) {
		this.role = role;
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
	 * @return the userSutitute
	 */
	public User getUserSutitute() {
		return userSutitute;
	}

	/**
	 * @param userSutitute
	 *            the userSutitute to set
	 */
	public void setUserSutitute(User userSutitute) {
		this.userSutitute = userSutitute;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idRoleUser == null) ? 0 : idRoleUser.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RoleUser other = (RoleUser) obj;
		if (idRoleUser == null) {
			if (other.idRoleUser != null)
				return false;
		} else if (!idRoleUser.equals(other.idRoleUser))
			return false;
		return true;
	}

}