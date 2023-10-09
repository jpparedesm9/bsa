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
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the wf_jerarquia database table.
 * 
 */
@Entity
@Table(name = "wf_jerarquia", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "Hierarchy.findByProcessVersionAndName", query = "select h from Hierarchy h where h.idProcess = :idProcess AND h.version = :version AND h.name=:name") })
public class Hierarchy implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_jerarquia", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla",
	// valueColumnName = "siguiente", pkColumnValue = "wf_jerarquia")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_jerarquia")
	@Column(name = "je_id_jerarquia")
	private Integer idHierarchy;

	@Column(name = "je_codigo_proceso")
	private Integer idProcess;

	@Column(name = "je_version_proceso")
	private Short version;

	@Column(name = "je_nombre_jerarquia")
	private String name;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "je_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "je_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "hierarchy", cascade = CascadeType.ALL)
	private List<HierarchyRol> hierarchyRolList = new ArrayList<HierarchyRol>();

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "hierarchy", cascade = CascadeType.ALL)
	private List<LinkRole> linkRoleList = new ArrayList<LinkRole>();

	/**
	 * @return the idHierarchy
	 */
	public Integer getIdHierarchy() {
		return idHierarchy;
	}

	/**
	 * @param idHierarchy
	 *            the idHierarchy to set
	 */
	public void setIdHierarchy(Integer idHierarchy) {
		this.idHierarchy = idHierarchy;
	}

	/**
	 * @return the idProcess
	 */
	public Integer getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
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
	 * @return the version
	 */
	public Short getVersion() {
		return version;
	}

	/**
	 * @param version
	 *            the version to set
	 */
	public void setVersion(Short version) {
		this.version = version;
	}

	/**
	 * @return the processVersion
	 */
	public ProcessVersion getProcessVersion() {
		return processVersion;
	}

	/**
	 * @param processVersion
	 *            the processVersion to set
	 */
	public void setProcessVersion(ProcessVersion processVersion) {
		this.processVersion = processVersion;
	}

	/**
	 * @return the hierarchyRolList
	 */
	public List<HierarchyRol> getHierarchyRolList() {
		return hierarchyRolList;
	}

	/**
	 * @param hierarchyRolList
	 *            the hierarchyRolList to set
	 */
	public void setHierarchyRolList(List<HierarchyRol> hierarchyRolList) {
		this.hierarchyRolList = hierarchyRolList;
	}

	/**
	 * @return the linkRoleList
	 */
	public List<LinkRole> getLinkRoleList() {
		return linkRoleList;
	}

	/**
	 * @param linkRoleList
	 *            the linkRoleList to set
	 */
	public void setLinkRoleList(List<LinkRole> linkRoleList) {
		this.linkRoleList = linkRoleList;
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
		result = prime * result + ((idHierarchy == null) ? 0 : idHierarchy.hashCode());
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
		Hierarchy other = (Hierarchy) obj;
		if (idHierarchy == null) {
			if (other.idHierarchy != null)
				return false;
		} else if (!idHierarchy.equals(other.idHierarchy))
			return false;
		return true;
	}

}