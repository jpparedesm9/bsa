package com.cobiscorp.ecobis.frm.business.dto;

import java.util.List;

public class Section {
	private Integer idSection;
	private String label;
	private List<Question> questions;
	private String enabled;

	public Integer getIdSection() {
		return idSection;
	}

	public void setIdSection(Integer idSection) {
		this.idSection = idSection;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}	

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Section [idSection=" + idSection + ", label=" + label + ", questions=" + questions + "]";
	}

}
