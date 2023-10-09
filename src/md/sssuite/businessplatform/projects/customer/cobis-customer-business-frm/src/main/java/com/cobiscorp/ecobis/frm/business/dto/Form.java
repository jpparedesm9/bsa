package com.cobiscorp.ecobis.frm.business.dto;

import java.util.List;

public class Form {
	private Integer idForm;
	private Integer version;
	private List<Section> section;
	private List<AnswerWithTable> answerWithTable;

	public Integer getIdForm() {
		return idForm;
	}

	public void setIdForm(Integer idForm) {
		this.idForm = idForm;
	}

	public List<Section> getSection() {
		return section;
	}

	public void setSection(List<Section> section) {
		this.section = section;
	}

	public List<AnswerWithTable> getAnswerWithTable() {
		return answerWithTable;
	}

	public void setAnswerWithTable(List<AnswerWithTable> answerWithTable) {
		this.answerWithTable = answerWithTable;
	}
	

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	@Override
	public String toString() {
		return "Form [idForm=" + idForm + ", section=" + section + "]";
	}

}
