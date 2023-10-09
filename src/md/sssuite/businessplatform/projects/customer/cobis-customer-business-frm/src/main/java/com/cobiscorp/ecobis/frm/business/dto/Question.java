package com.cobiscorp.ecobis.frm.business.dto;

import java.util.List;

public class Question {
	private Integer idQuestion;
	private String label;
	private String description;
	private String type;
	private List<Item> values;
	private String answer;
	private List<ColumnQuestion> tableQuestion;
	private String required;
	private Integer rows;
	private String repeated;
	
	
	public Integer getIdQuestion() {
		return idQuestion;
	}
	public void setIdQuestion(Integer idQuestion) {
		this.idQuestion = idQuestion;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public List<Item> getValues() {
		return values;
	}
	public void setValues(List<Item> values) {
		this.values = values;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public List<ColumnQuestion> getTableQuestion() {
		return tableQuestion;
	}
	public void setTableQuestion(List<ColumnQuestion> tableQuestion) {
		this.tableQuestion = tableQuestion;
	}
	public String getRequired() {
		return required;
	}
	public void setRequired(String required) {
		this.required = required;
	}
	
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public String getRepeated() {
		return repeated;
	}
	public void setRepeated(String repeated) {
		this.repeated = repeated;
	}
	@Override
	public String toString() {
		return "Question [idQuestion=" + idQuestion + ", label=" + label + ", description=" + description + ", type="
				+ type + ", values=" + values + ", answer=" + answer + "]";
	}

	
}