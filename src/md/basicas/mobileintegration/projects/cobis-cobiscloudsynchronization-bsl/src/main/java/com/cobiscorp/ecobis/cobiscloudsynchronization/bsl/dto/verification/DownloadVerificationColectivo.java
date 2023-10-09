package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification;

import java.util.List;

public class DownloadVerificationColectivo {
	private Integer applicationId;
    private String date;
    private double result;
    private List<DownloadQuestionColective> questions;

    public Integer getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(Integer applicationId) {
        this.applicationId = applicationId;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public double getResult() {
        return result;
    }

    public void setResult(double result) {
        this.result = result;
    }
    
    public List<DownloadQuestionColective> getQuestions() {
        return questions;
    }

    public void setQuestions(List<DownloadQuestionColective> questions) {
        this.questions = questions;
    }

    
    
}
