package com.cobiscorp.ecobis.cloud.service.dto.verification;

public class QuestionColective {

	private int id;
	private String description;
	private String requiered;
	private int codeDependent;
	private String valueDependent;
	private String answer;

	public QuestionColective() {
	}

	public QuestionColective(int id, String description, String requiered, int codeDependent, String valueDependent, String answer) {
		this.id = id;
		this.description = description;
		this.requiered = requiered;
		this.codeDependent = codeDependent;
		this.valueDependent = valueDependent;
		this.answer = answer;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRequiered() {
		return requiered;
	}

	public void setRequiered(String requiered) {
		this.requiered = requiered;
	}

	public int getCodeDependent() {
		return codeDependent;
	}

	public void setCodeDependent(int codeDependent) {
		this.codeDependent = codeDependent;
	}

	public String getValueDependent() {
		return valueDependent;
	}

	public void setValueDependent(String valueDependent) {
		this.valueDependent = valueDependent;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
}
