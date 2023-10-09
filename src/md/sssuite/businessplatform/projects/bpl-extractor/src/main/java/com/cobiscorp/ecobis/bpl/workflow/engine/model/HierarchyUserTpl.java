package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * The persistent class for the wf_usuario_jerarquia_tpl database table.
 * 
 */
@Entity
@Table(name = "wf_usuario_jerarquia_tpl", schema = "cob_workflow")
public class HierarchyUserTpl implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
//	@TableGenerator(name = "wf_usuario_jerarquia_tpl", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_usuario_jerarquia_tpl")
//	@GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_usuario_jerarquia_tpl")
	@Column(name = "uj_id_usuario_jerarquia")
	private Integer idHierarchyUserTpl;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "uj_id_usuario_padre")
	private User userParent;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ij_id_item_jerarquia")
	private HierarchyItemTpl hierarchyItemTpl;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "us_id_usuario")
	private User user;

	public HierarchyUserTpl() {

	}

	/**
	 * @return the idHierarchyUserTpl
	 */
	public Integer getIdHierarchyUserTpl() {
		return idHierarchyUserTpl;
	}

	/**
	 * @param idHierarchyUserTpl
	 *            the idHierarchyUserTpl to set
	 */
	public void setIdHierarchyUserTpl(Integer idHierarchyUserTpl) {
		this.idHierarchyUserTpl = idHierarchyUserTpl;
	}

	/**
	 * @return the userParent
	 */
	public User getUserParent() {
		return userParent;
	}

	/**
	 * @param userParent
	 *            the userParent to set
	 */
	public void setUserParent(User userParent) {
		this.userParent = userParent;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdHierarchyUserTpl() == null ? super.hashCode() : this.getIdHierarchyUserTpl().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof HierarchyUserTpl)) {
			return false;
		}
		HierarchyUserTpl entity = (HierarchyUserTpl) object;
		if ((this.getIdHierarchyUserTpl() == null && entity.getIdHierarchyUserTpl() != null)
				|| (this.getIdHierarchyUserTpl() != null && !this.getIdHierarchyUserTpl().equals(entity.getIdHierarchyUserTpl()))) {
			return false;
		}
		return true;
	}

}