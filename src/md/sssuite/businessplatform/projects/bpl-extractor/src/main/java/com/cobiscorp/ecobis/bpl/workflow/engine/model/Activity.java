package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Entity
@Table(name = "wf_actividad", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "Activity.findByName", query = "select ac from Activity ac where ac.name=:name") })
public class Activity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_actividad", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla",
	// valueColumnName = "siguiente", pkColumnValue = "wf_actividad")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_actividad")
	@Column(name = "ac_codigo_actividad")
	private Integer idActivity;

	@Column(name = "ac_codigo_empresa")
	private Short idCompany;

	@Column(name = "ac_color_fondo")
	private Integer backgroundColor;

	@Column(name = "ac_color_texto")
	private Integer textColor;

	@Column(name = "ac_desc_actividad")
	private String description;

	@Column(name = "ac_estado")
	private String status;

	@Column(name = "ac_nombre_actividad")
	private String name;

	@Column(name = "ac_tipo_actividad")
	private String type;

	public Activity() {
	}

	/**
	 * @return the idActivity
	 */
	public Integer getIdActivity() {
		return idActivity;
	}

	/**
	 * @param idActivity
	 *            the idActivity to set
	 */
	public void setIdActivity(Integer idActivity) {
		this.idActivity = idActivity;
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
	 * @return the backgroundColor
	 */
	public Integer getBackgroundColor() {
		return backgroundColor;
	}

	/**
	 * @param backgroundColor
	 *            the backgroundColor to set
	 */
	public void setBackgroundColor(Integer backgroundColor) {
		this.backgroundColor = backgroundColor;
	}

	/**
	 * @return the textColor
	 */
	public Integer getTextColor() {
		return textColor;
	}

	/**
	 * @param textColor
	 *            the textColor to set
	 */
	public void setTextColor(Integer textColor) {
		this.textColor = textColor;
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
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
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
		result = prime * result + ((idActivity == null) ? 0 : idActivity.hashCode());
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
		Activity other = (Activity) obj;
		if (idActivity == null) {
			if (other.idActivity != null)
				return false;
		} else if (!idActivity.equals(other.idActivity))
			return false;
		return true;
	}

}