package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_receptor database table.
 * 
 */
@Embeddable
public class IdReceptor implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "re_id_paso")
	private Integer idPaso;

	@Column(name = "re_num_receptor")
	private Integer codigo;

	public IdReceptor() {

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

	/**
	 * @return the codigo
	 */
	public Integer getCodigo() {
		return codigo;
	}

	/**
	 * @param codigo
	 *            the codigo to set
	 */
	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
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
		result = prime * result + ((codigo == null) ? 0 : codigo.hashCode());
		result = prime * result + ((idPaso == null) ? 0 : idPaso.hashCode());
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
		IdReceptor other = (IdReceptor) obj;
		if (codigo == null) {
			if (other.codigo != null)
				return false;
		} else if (!codigo.equals(other.codigo))
			return false;
		if (idPaso == null) {
			if (other.idPaso != null)
				return false;
		} else if (!idPaso.equals(other.idPaso))
			return false;
		return true;
	}

}