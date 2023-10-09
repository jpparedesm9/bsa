package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * The persistent class for the wf_tipo_jerarquia_tpl database table.
 * 
 */
@Entity
@Table(name = "wf_tipo_jerarquia_tpl", schema = "cob_workflow")
public class HierarchyTypeTpl implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
//	@TableGenerator(name = "wf_tipo_jerarquia_tpl", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_tipo_jerarquia_tpl")
//	@GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_tipo_jerarquia_tpl")
	@Column(name = "tj_id_jerarquia")
	private Integer idHierarchyTypeTpl;

	@Column(name = "tj_nombre_jerarquia")
	private String name;

	@Column(name = "tj_descripcion")
	private String description;

	@Column(name = "tj_jerarquia_inbox")
	private String inbox;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hierarchyTypeTpl")
	private List<HierarchyItemTpl> hierarchyItemTplList = new ArrayList<HierarchyItemTpl>();

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "hierarchyTypeTpl")
	private List<HierarchyLevelTpl> hierarchyLevelTplList = new ArrayList<HierarchyLevelTpl>();

	public HierarchyTypeTpl() {

	}

	/**
	 * @return the idHierarchyTypeTpl
	 */
	public Integer getIdHierarchyTypeTpl() {
		return idHierarchyTypeTpl;
	}

	/**
	 * @param idHierarchyTypeTpl
	 *            the idHierarchyTypeTpl to set
	 */
	public void setIdHierarchyTypeTpl(Integer idHierarchyTypeTpl) {
		this.idHierarchyTypeTpl = idHierarchyTypeTpl;
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
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the inbox
	 */
	public String getInbox() {
		return inbox;
	}

	/**
	 * @param inbox
	 *            the inbox to set
	 */
	public void setInbox(String inbox) {
		this.inbox = inbox;
	}

	/**
	 * @return the hierarchyItemTplList
	 */
	public List<HierarchyItemTpl> getHierarchyItemTplList() {
		return hierarchyItemTplList;
	}

	/**
	 * @param hierarchyItemTplList
	 *            the hierarchyItemTplList to set
	 */
	public void setHierarchyItemTplList(List<HierarchyItemTpl> hierarchyItemTplList) {
		this.hierarchyItemTplList = hierarchyItemTplList;
	}

	/**
	 * @return the hierarchyLevelTplList
	 */
	public List<HierarchyLevelTpl> getHierarchyLevelTplList() {
		return hierarchyLevelTplList;
	}

	/**
	 * @param hierarchyLevelTplList
	 *            the hierarchyLevelTplList to set
	 */
	public void setHierarchyLevelTplList(List<HierarchyLevelTpl> hierarchyLevelTplList) {
		this.hierarchyLevelTplList = hierarchyLevelTplList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdHierarchyTypeTpl() == null ? super.hashCode() : this.getIdHierarchyTypeTpl().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof HierarchyTypeTpl)) {
			return false;
		}
		HierarchyTypeTpl entity = (HierarchyTypeTpl) object;
		if ((this.getIdHierarchyTypeTpl() == null && entity.getIdHierarchyTypeTpl() != null)
				|| (this.getIdHierarchyTypeTpl() != null && !this.getIdHierarchyTypeTpl().equals(entity.getIdHierarchyTypeTpl()))) {
			return false;
		}
		return true;
	}

}