package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The persistent class for the wf_item_jerarquia database table.
 * 
 */
@Embeddable
public class IdHierarchyItem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "ij_id_item_jerarquia")
	private Integer idHierarchyItemTpl;

	@Column(name = "pa_id_paso")
	private Integer idStep;

	public IdHierarchyItem() {
	}

	public IdHierarchyItem(Integer idHierarchyItemTpl, Integer idStep) {
		super();
		this.idHierarchyItemTpl = idHierarchyItemTpl;
		this.idStep = idStep;
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
	 * @return the idStep
	 */
	public Integer getIdStep() {
		return idStep;
	}

	/**
	 * @param idStep
	 *            the idStep to set
	 */
	public void setIdStep(Integer idStep) {
		this.idStep = idStep;
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
		result = prime * result + ((idHierarchyItemTpl == null) ? 0 : idHierarchyItemTpl.hashCode());
		result = prime * result + ((idStep == null) ? 0 : idStep.hashCode());
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
		IdHierarchyItem other = (IdHierarchyItem) obj;
		if (idHierarchyItemTpl == null) {
			if (other.idHierarchyItemTpl != null)
				return false;
		} else if (!idHierarchyItemTpl.equals(other.idHierarchyItemTpl))
			return false;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep))
			return false;
		return true;
	}

}