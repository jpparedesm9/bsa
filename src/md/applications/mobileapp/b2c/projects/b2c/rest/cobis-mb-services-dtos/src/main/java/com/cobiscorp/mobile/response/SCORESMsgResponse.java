package com.cobiscorp.mobile.response;

public class SCORESMsgResponse {

	private String idExpediente;
	private String idValidas;
	private Scores scores;

	private Integer triesNumber;

	public String getIdExpediente() {
		return idExpediente;
	}

	public void setIdExpediente(String idExpediente) {
		this.idExpediente = idExpediente;
	}

	public String getIdValidas() {
		return idValidas;
	}

	public void setIdValidas(String idValidas) {
		this.idValidas = idValidas;
	}

	public Scores getScores() {
		return scores;
	}

	public void setScores(Scores scores) {
		this.scores = scores;
	}

	public Integer getTriesNumber() {
		return triesNumber;
	}

	public void setTriesNumber(Integer triesNumber) {
		this.triesNumber = triesNumber;
	}

	@Override
	public String toString() {
		return "SCORESMsgResponse [idExpediente=" + idExpediente + ", idValidas=" + idValidas + ", scores=" + scores
				+ "]";
	}

}
