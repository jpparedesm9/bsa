package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ApprovalExceptionPK {

	@Column(name = "ae_id_paso")
	private Integer idStep;

	@Column(name = "ae_id_politica_o_documento")
	private Integer idPolicyOrDocument;

	@Column(name = "ae_tipo_excepcion")
	private String exceptionType;

	public ApprovalExceptionPK(Integer idStep, Integer idPolicyOrDocument, String exceptionType) {
		super();
		this.setIdStep(idStep);
		this.setIdPolicyOrDocument(idPolicyOrDocument);
		this.setExceptionType(exceptionType);
	}

	public ApprovalExceptionPK() {
	}

	public Integer getIdStep() {
		return idStep;
	}

	public void setIdStep(Integer idStep) {
		this.idStep = idStep;
	}

	public String getExceptionType() {
		return exceptionType;
	}

	public void setExceptionType(String exceptionType) {
		this.exceptionType = exceptionType;
	}

	public Integer getIdPolicyOrDocument() {
		return idPolicyOrDocument;
	}

	public void setIdPolicyOrDocument(Integer idPolicyOrDocument) {
		this.idPolicyOrDocument = idPolicyOrDocument;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof ApprovalExceptionPK)) {
			return false;
		}
		ApprovalExceptionPK castOther = (ApprovalExceptionPK) other;
		return (this.idStep == castOther.idStep && this.idPolicyOrDocument == castOther.idPolicyOrDocument && this.exceptionType
				.equals(castOther.exceptionType));
	}

	public int hashCode() {
		return idStep.hashCode();
	}

}
