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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * The persistent class for the wf_item_jerarquia_tpl database table.
 * 
 */
@Entity
@Table(name = "wf_item_jerarquia_tpl", schema = "cob_workflow")
public class HierarchyItemTpl implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
//	@TableGenerator(name = "wf_item_jerarquia_tpl", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_item_jerarquia_tpl")
//	@GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_nivel_jerarquia_tpl")
	@Column(name = "ij_id_item_jerarquia")
	private Integer idHierarchyItemTpl;

	@Column(name = "ij_descripcion_item_jer")
	private String description;

	@Column(name = "ij_id_catalogo_nivel_item")
	private String catalog;

	@Column(name = "ij_id_valor_nivel_item")
	private String levelValue;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ij_id_item_padre")
	private HierarchyItemTpl hierarchyItemTplParent;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ni_id_nivel_jerarquia")
	private HierarchyLevelTpl hierarchyLevelTpl;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tj_id_jerarquia")
	private HierarchyTypeTpl hierarchyTypeTpl;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hierarchyItemTplParent")
	private List<HierarchyItemTpl> hierarchyItemTplList = new ArrayList<HierarchyItemTpl>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hierarchyItemTpl")
	private List<HierarchyUserTpl> hierarchyUserTplList = new ArrayList<HierarchyUserTpl>();

	public HierarchyItemTpl() {

	}

	/**
	 * @return the idHierarchyItemTpl
	 */
	public Integer getIdHierarchyItemTpl() {
		return idHierarchyItemTpl;
	}

	/**
	 * @param idHierarchyItemTpl
	 *            the idHierarchyItemTpl to set
	 */
	public void setIdHierarchyItemTpl(Integer idHierarchyItemTpl) {
		this.idHierarchyItemTpl = idHierarchyItemTpl;
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
	 * @return the catalog
	 */
	public String getCatalog() {
		return catalog;
	}

	/**
	 * @param catalog
	 *            the catalog to set
	 */
	public void setCatalog(String catalog) {
		this.catalog = catalog;
	}

	/**
	 * @return the levelValue
	 */
	public String getLevelValue() {
		return levelValue;
	}

	/**
	 * @param levelValue
	 *            the levelValue to set
	 */
	public void setLevelValue(String levelValue) {
		this.levelValue = levelValue;
	}

	/**
	 * @return the hierarchyItemTplParent
	 */
	public HierarchyItemTpl getHierarchyItemTplParent() {
		return hierarchyItemTplParent;
	}

	/**
	 * @param hierarchyItemTplParent
	 *            the hierarchyItemTplParent to set
	 */
	public void setHierarchyItemTplParent(HierarchyItemTpl hierarchyItemTplParent) {
		this.hierarchyItemTplParent = hierarchyItemTplParent;
	}

	/**
	 * @return the hierarchyLevelTpl
	 */
	public HierarchyLevelTpl getHierarchyLevelTpl() {
		return hierarchyLevelTpl;
	}

	/**
	 * @param hierarchyLevelTpl
	 *            the hierarchyLevelTpl to set
	 */
	public void setHierarchyLevelTpl(HierarchyLevelTpl hierarchyLevelTpl) {
		this.hierarchyLevelTpl = hierarchyLevelTpl;
	}

	/**
	 * @return the hierarchyTypeTpl
	 */
	public HierarchyTypeTpl getHierarchyTypeTpl() {
		return hierarchyTypeTpl;
	}

	/**
	 * @param hierarchyTypeTpl
	 *            the hierarchyTypeTpl to set
	 */
	public void setHierarchyTypeTpl(HierarchyTypeTpl hierarchyTypeTpl) {
		this.hierarchyTypeTpl = hierarchyTypeTpl;
	}

	/**
	 * @return the hierarchyUserTplList
	 */
	public List<HierarchyUserTpl> getHierarchyUserTplList() {
		return hierarchyUserTplList;
	}

	/**
	 * @param hierarchyUserTplList
	 *            the hierarchyUserTplList to set
	 */
	public void setHierarchyUserTplList(List<HierarchyUserTpl> hierarchyUserTplList) {
		this.hierarchyUserTplList = hierarchyUserTplList;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdHierarchyItemTpl() == null ? super.hashCode() : this.getIdHierarchyItemTpl().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof HierarchyItemTpl)) {
			return false;
		}
		HierarchyItemTpl entity = (HierarchyItemTpl) object;
		if ((this.getIdHierarchyItemTpl() == null && entity.getIdHierarchyItemTpl() != null)
				|| (this.getIdHierarchyItemTpl() != null && !this.getIdHierarchyItemTpl().equals(entity.getIdHierarchyItemTpl()))) {
			return false;
		}
		return true;
	}

}