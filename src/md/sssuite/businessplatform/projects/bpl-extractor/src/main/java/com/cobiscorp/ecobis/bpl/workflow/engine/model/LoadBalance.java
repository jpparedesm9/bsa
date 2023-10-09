package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the wf_dist_carga database table.
 * 
 */
@Entity
@Table(name = "wf_dist_carga", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "LoadBalance.findByName", query = "SELECT lb FROM LoadBalance lb WHERE lb.name=:name") })
public class LoadBalance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_dist_carga", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName =
	// "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_dist_carga")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_dist_carga")
	@Column(name = "dc_cod_dist_car")
	private Integer idLoadBalance;

	@Column(name = "dc_desc_dist_car")
	private String description;

	@Column(name = "dc_nom_dist_car")
	private String name;

	@Column(name = "dc_nombre_sp")
	private String sp;

	public LoadBalance() {

	}

	/**
	 * @return the idLoadBalance
	 */
	public Integer getIdLoadBalance() {
		return idLoadBalance;
	}

	/**
	 * @param idLoadBalance
	 *            the idLoadBalance to set
	 */
	public void setIdLoadBalance(Integer idLoadBalance) {
		this.idLoadBalance = idLoadBalance;
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
	 * @return the sp
	 */
	public String getSp() {
		return sp;
	}

	/**
	 * @param sp
	 *            the sp to set
	 */
	public void setSp(String sp) {
		this.sp = sp;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdLoadBalance() == null ? super.hashCode() : this.getIdLoadBalance().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof LoadBalance)) {
			return false;
		}
		LoadBalance entity = (LoadBalance) object;
		if ((this.getIdLoadBalance() == null && entity.getIdLoadBalance() != null)
				|| (this.getIdLoadBalance() != null && !this.getIdLoadBalance().equals(entity.getIdLoadBalance()))) {
			return false;
		}
		return true;
	}

}