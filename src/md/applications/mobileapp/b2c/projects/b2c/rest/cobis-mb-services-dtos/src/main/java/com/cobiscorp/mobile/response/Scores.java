package com.cobiscorp.mobile.response;

import java.util.List;

public class Scores {
	private List<BiometryScore> biometryScores = null;
	private List<DocumentScore> documentScores = null;

	public List<BiometryScore> getBiometryScores() {
		return biometryScores;
	}

	public void setBiometryScores(List<BiometryScore> biometryScores) {
		this.biometryScores = biometryScores;
	}

	public List<DocumentScore> getDocumentScores() {
		return documentScores;
	}

	public void setDocumentScores(List<DocumentScore> documentScores) {
		this.documentScores = documentScores;
	}

}
