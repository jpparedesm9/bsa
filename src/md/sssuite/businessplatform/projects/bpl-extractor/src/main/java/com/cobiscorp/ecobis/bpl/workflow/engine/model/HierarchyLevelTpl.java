package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

/**
 * The persistent class for the wf_nivel_jerarquia_tpl database table.
 * 
 */
@Entity
@Table(name = "wf_nivel_jerarquia_tpl", schema = "cob_workflow")
public class HierarchyLevelTpl implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_nivel_jerarquia_tpl", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName
	// = "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_nivel_jerarquia_tpl")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_nivel_jerarquia_tpl")
	@Column(name = "ni_id_nivel_jerarquia")
	private Integer idHierarchyLevelTpl;

	@Column(name = "ni_descripcion_nivel")
	private String description;

	@Column(name = "ni_orden_nivel")
	private Integer order;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tj_id_jerarquia")
	private HierarchyTypeTpl hierarchyTypeTpl;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "vb_codigo_variable", insertable = false, updatable = false)
	private Variable variable;

	@Column(name = "vb_codigo_variable")
	private int idVariable;

	public HierarchyLevelTpl() {

	}

	/**
	 * @return the idHierarchyLevelTpl
	 */
	public Integer getIdHierarchyLevelTpl() {
		return idHierarchyLevelTpl;
	}

	/**
	 * @param idHierarchyLevelTpl
	 *            the idHierarchyLevelTpl to set
	 */
	public void setIdHierarchyLevelTpl(Integer idHierarchyLevelTpl) {
		this.idHierarchyLevelTpl = idHierarchyLevelTpl;
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
	 * @return the order
	 */
	public Integer getOrder() {
		return order;
	}

	/**
	 * @param order
	 *            the order to set
	 */
	public void setOrder(Integer order) {
		this.order = order;
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
	 * @return the variable
	 */
	public Variable getVariable() {
		return variable;
	}

	/**
	 * @param variable
	 *            the variable to set
	 */
	public void setVariable(Variable variable) {
		this.variable = variable;
	}

	/**
	 * @return the idVariable
	 */
	public int getIdVariable() {
		return idVariable;
	}

	/**
	 * @param idVariable
	 *            the idVariable to set
	 */
	public void setIdVariable(int idVariable) {
		this.idVariable = idVariable;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdHierarchyLevelTpl() == null ? super.hashCode() : this.getIdHierarchyLevelTpl().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof HierarchyLevelTpl)) {
			return false;
		}
		HierarchyLevelTpl entity = (HierarchyLevelTpl) object;
		if ((this.getIdHierarchyLevelTpl() == null && entity.getIdHierarchyLevelTpl() != null)
				|| (this.getIdHierarchyLevelTpl() != null && !this.getIdHierarchyLevelTpl().equals(entity.getIdHierarchyLevelTpl()))) {
			return false;
		}
		return true;
	}

}