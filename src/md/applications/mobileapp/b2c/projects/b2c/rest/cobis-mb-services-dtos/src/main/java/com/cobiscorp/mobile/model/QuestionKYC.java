package com.cobiscorp.mobile.model;

public class QuestionKYC {

	private String type;
	private String answer;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Override
	public String toString() {
		return "QuestionKYC [type=" + type + ", answer=" + answer + "]";
	}

}
