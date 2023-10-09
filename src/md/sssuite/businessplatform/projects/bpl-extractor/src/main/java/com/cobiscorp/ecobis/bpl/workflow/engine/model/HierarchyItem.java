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
 * The persistent class for the wf_item_jerarquia database table.
 * 
 */
@Entity
@Table(name = "wf_item_jerarquia", schema = "cob_workflow")
public class HierarchyItem implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdHierarchyItem idHierarchyItem;

	@Column(name = "ij_condiciones")
	private String ijCondiciones;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ij_id_item_jerarquia")
	private HierarchyItemTpl hierarchyItemTpl;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pa_id_paso")
	private Step step;

	public HierarchyItem() {
	}

	/**
	 * @return the idHierarchyItem
	 */
	public IdHierarchyItem getIdHierarchyItem() {
		return idHierarchyItem;
	}

	/**
	 * @param idHierarchyItem
	 *            the idHierarchyItem to set
	 */
	public void setIdHierarchyItem(IdHierarchyItem idHierarchyItem) {
		this.idHierarchyItem = idHierarchyItem;
	}

	public String getIjCondiciones() {
		return this.ijCondiciones;
	}

	public void setIjCondiciones(String ijCondiciones) {
		this.ijCondiciones = ijCondiciones;
	}

	/**
	 * @return the hierarchyItemTpl
	 */
	public HierarchyItemTpl getHierarchyItemTpl() {
		return hierarchyItemTpl;
	}

	/**
	 * @param hierarchyItemTpl
	 *            the hierarchyItemTpl to set
	 */
	public void setHierarchyItemTpl(HierarchyItemTpl hierarchyItemTpl) {
		this.hierarchyItemTpl = hierarchyItemTpl;
	}

	/**
	 * @return the step
	 */
	public Step getStep() {
		return step;
	}

	/**
	 * @param step
	 *            the step to set
	 */
	public void setStep(Step step) {
		this.step = step;
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
		result = prime * result + ((hierarchyItemTpl == null) ? 0 : hierarchyItemTpl.hashCode());
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
		HierarchyItem other = (HierarchyItem) obj;
		if (hierarchyItemTpl == null) {
			if (other.hierarchyItemTpl != null)
				return false;
		} else if (!hierarchyItemTpl.equals(other.hierarchyItemTpl))
			return false;
		return true;
	}

}