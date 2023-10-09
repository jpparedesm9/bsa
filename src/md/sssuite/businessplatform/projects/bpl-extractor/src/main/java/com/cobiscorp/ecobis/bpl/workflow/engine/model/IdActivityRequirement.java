package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_tipo_req_act database table.
 * 
 */
@Embeddable
public class IdActivityRequirement implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "tr_codigo_tipo_doc")
	private Integer idRequirement;

	@Column(name = "tr_id_paso")
	private Integer idPaso;

	public IdActivityRequirement() {

	}

	public IdActivityRequirement(Integer idRequirement, Integer idPaso) {
		super();
		this.idRequirement = idRequirement;
		this.idPaso = idPaso;
	}

	/**
	 * @return the idRequirement
	 */
	public Integer getIdRequirement() {
		return idRequirement;
	}

	/**
	 * @param idRequirement
	 *            the idRequirement to set
	 */
	public void setIdRequirement(Integer idRequirement) {
		this.idRequirement = idRequirement;
	}

	/**
	 * @return the idPaso
	 */
	public Integer getIdPaso() {
		return idPaso;
	}

	/**
	 * @param idPaso
	 *            the idPaso to set
	 */
	public void setIdPaso(Integer idPaso) {
		this.idPaso = idPaso;
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
		result = prime * result + ((idPaso == null) ? 0 : idPaso.hashCode());
		result = prime * result + ((idRequirement == null) ? 0 : idRequirement.hashCode());
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
		IdActivityRequirement other = (IdActivityRequirement) obj;
		if (idPaso == null) {
			if (other.idPaso != null)
				return false;
		} else if (!idPaso.equals(other.idPaso))
			return false;
		if (idRequirement == null) {
			if (other.idRequirement != null)
				return false;
		} else if (!idRequirement.equals(other.idRequirement))
			return false;
		return true;
	}

}