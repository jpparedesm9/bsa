package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * The persistent class for the wf_rol database table.
 * 
 */
@Entity
@Table(name = "wf_rol", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "Role.findByName", query = "SELECT new Role(r.idRole, r.idCompany, r.name, r.comite, r.intervenes, r.order)  FROM Role r WHERE  r.name = :name") })
public class Role implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_rol", initialValue = 0, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla",
	// valueColumnName = "siguiente", pkColumnValue = "wf_rol")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_rol")
	@Column(name = "ro_id_rol")
	private Integer idRole;

	@Column(name = "ro_codigo_empresa")
	private Short idCompany;

	@Column(name = "ro_nombre_rol")
	private String name;

	@Column(name = "ro_es_comite")
	private byte comite;

	@Column(name = "ro_interviene")
	private byte intervenes;

	@Column(name = "ro_orden")
	private Short order;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ro_id_usuario_cabecera")
	private User user;

	// OneToOne
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "role", cascade = CascadeType.ALL)
	private List<RoleType> roleTypeList = new ArrayList<RoleType>();

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "role", cascade = CascadeType.ALL)
	private List<RoleUser> roleUserList = new ArrayList<RoleUser>();


	public Role(Integer idRole, Short idCompany, String name, byte comite, byte intervenes, Short order) {
		this.idRole = idRole;
		this.idCompany = idCompany;
		this.name = name;
		this.comite = comite;
		this.intervenes = intervenes;
		this.order = order;
	}

	public Role() {

	}

	/**
	 * @return the idRole
	 */
	public Integer getIdRole() {
		return idRole;
	}

	/**
	 * @param idRole
	 *            the idRole to set
	 */
	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
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
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the comite
	 */
	public byte getComite() {
		return comite;
	}

	/**
	 * @param comite
	 *            the comite to set
	 */
	public void setComite(byte comite) {
		this.comite = comite;
	}

	/**
	 * @return the intervenes
	 */
	public byte getIntervenes() {
		return intervenes;
	}

	/**
	 * @param intervenes
	 *            the intervenes to set
	 */
	public void setIntervenes(byte intervenes) {
		this.intervenes = intervenes;
	}

	/**
	 * @return the order
	 */
	public Short getOrder() {
		return order;
	}

	/**
	 * @param order
	 *            the order to set
	 */
	public void setOrder(Short order) {
		this.order = order;
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
	 * @return the roleUserList
	 */
	public List<RoleUser> getRoleUserList() {
		return roleUserList;
	}

	/**
	 * @param roleUserList
	 *            the roleUserList to set
	 */
	public void setRoleUserList(List<RoleUser> roleUserList) {
		this.roleUserList = roleUserList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	/**
	 * @return the roleTypeList
	 */
	public List<RoleType> getRoleTypeList() {
		return roleTypeList;
	}

	/**
	 * @param roleTypeList
	 *            the roleTypeList to set
	 */
	public void setRoleTypeList(List<RoleType> roleTypeList) {
		this.roleTypeList = roleTypeList;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
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
		Role other = (Role) obj;
		if (idRole == null) {
			if (other.idRole != null)
				return false;
		} else if (!idRole.equals(other.idRole))
			return false;
		return true;
	}

}