package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

@Entity
@Table(name = "wf_aprobacion_excepcion", schema = "cob_workflow")
public class ApprovalException implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private ApprovalExceptionPK approvalExceptionPK;

	@Column(name = "ae_id_paso", insertable = false, updatable = false)
	private Integer idStep;

	@Column(name = "ae_id_politica_o_documento", insertable = false, updatable = false)
	private Integer idPolicyOrDocument;

	@Column(name = "ae_tipo_excepcion", insertable = false, updatable = false)
	private String exceptionType;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "ae_id_paso", insertable = false, updatable = false)
	private Step step;

	@Transient
	private Rule rule;

	@Transient
	private DocumentType docType;

	public Rule getRule() {
		return rule;
	}

	public void setRule(Rule rule) {
		this.rule = rule;
	}

	public DocumentType getDocType() {
		return docType;
	}

	public void setDocType(DocumentType docType) {
		this.docType = docType;
	}

	public Integer getIdStep() {
		return idStep;
	}

	public void setIdStep(Integer idStep) {
		this.idStep = idStep;
	}

	public Integer getIdPolicyOrDocument() {
		return idPolicyOrDocument;
	}

	public void setIdPolicyOrDocument(Integer idPolicyOrDocument) {
		this.idPolicyOrDocument = idPolicyOrDocument;
	}

	public String getExceptionType() {
		return exceptionType;
	}

	public void setExceptionType(String exceptionType) {
		this.exceptionType = exceptionType;
	}

	public Step getStep() {
		return step;
	}

	public void setStep(Step step) {
		this.step = step;
	}

	public ApprovalExceptionPK getApprovalExceptionPK() {
		return approvalExceptionPK;
	}

	public void setApprovalExceptionPK(ApprovalExceptionPK approvalExceptionPK) {
		this.approvalExceptionPK = approvalExceptionPK;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idStep == null) ? 0 : idStep.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ApprovalException other = (ApprovalException) obj;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep)) {
			return false;
		} else

		if (idPolicyOrDocument == null)
			if (other.idPolicyOrDocument != null) {
				return false;
			} else if (!idPolicyOrDocument.equals(other.idPolicyOrDocument)) {
				return false;
			} else

			if (exceptionType == null)
				if (other.exceptionType != null) {
					return false;
				} else if (!exceptionType.equals(other.exceptionType)) {
					return false;
				}

		return true;
	}

}