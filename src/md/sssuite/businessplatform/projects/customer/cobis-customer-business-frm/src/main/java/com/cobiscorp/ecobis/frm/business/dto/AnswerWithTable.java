package com.cobiscorp.ecobis.frm.business.dto;

import java.util.List;

public class AnswerWithTable {
	private Integer idAnswer;
	private Integer idQuestion;
	private String answerDesc;	
	private String answerType;
	private List<RowAnswer> rowList;
	
	public Integer getIdAnswer() {
		return idAnswer;
	}
	public void setIdAnswer(Integer idAnswer) {
		this.idAnswer = idAnswer;
	}
	public String getAnswerDesc() {
		return answerDesc;
	}
	public void setAnswerDesc(String answerDesc) {
		this.answerDesc = answerDesc;
	}
	public String getAnswerType() {
		return answerType;
	}
	public void setAnswerType(String anwserType) {
		this.answerType = anwserType;
	}
	public List<RowAnswer> getRowList() {
		return rowList;
	}
	public void setRowList(List<RowAnswer> rowList) {
		this.rowList = rowList;
	}
	public Integer getIdQuestion() {
		return idQuestion;
	}
	public void setIdQuestion(Integer idQuestion) {
		this.idQuestion = idQuestion;
	}
	
	
}
