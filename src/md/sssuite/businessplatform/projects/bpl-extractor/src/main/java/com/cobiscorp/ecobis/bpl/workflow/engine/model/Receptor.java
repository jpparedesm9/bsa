package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

/**
 * The persistent class for the wf_receptor database table.
 * 
 */
@Entity
@Table(name = "wf_receptor", schema = "cob_workflow")
public class Receptor implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdReceptor idReceptor;

	@Column(name = "re_num_receptor")
	private Integer codigo;

	@Column(name = "re_codigo_proceso")
	private Integer idProcess;

	@Column(name = "re_id_destinatario")
	private Integer idAddressee;

	@Column(name = "re_tipo_receptor")
	private String type;

	@Column(name = "re_version_proceso")
	private Short versionProcess;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "re_id_paso")
	private Step step;

	/**
	 * @return the idReceptor
	 */
	public IdReceptor getIdReceptor() {
		return idReceptor;
	}

	/**
	 * @param idReceptor
	 *            the idReceptor to set
	 */
	public void setIdReceptor(IdReceptor idReceptor) {
		this.idReceptor = idReceptor;
	}

	/**
	 * @return the idProcess
	 */
	public Integer getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	/**
	 * @return the idAddressee
	 */
	public Integer getIdAddressee() {
		return idAddressee;
	}

	/**
	 * @param idAddressee
	 *            the idAddressee to set
	 */
	public void setIdAddressee(Integer idAddressee) {
		this.idAddressee = idAddressee;
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

	/**
	 * @return the versionProcess
	 */
	public Short getVersionProcess() {
		return versionProcess;
	}

	/**
	 * @param versionProcess
	 *            the versionProcess to set
	 */
	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
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
		result = prime * result + ((idReceptor == null) ? 0 : idReceptor.hashCode());
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
		Receptor other = (Receptor) obj;
		if (idReceptor == null) {
			if (other.idReceptor != null)
				return false;
		} else if (!idReceptor.equals(other.idReceptor))
			return false;
		return true;
	}

}
