package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification;

import java.util.List;

public class DownloadQuestion {

    private String answer;
    private List<DownloadParameter> parameters;

    public DownloadQuestion() {
    }

    public DownloadQuestion(String answer) {
        this.answer = answer;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }


    public List<DownloadParameter> getParameters() {
        return parameters;
    }

    public void setParameters(List<DownloadParameter> parameters) {
        this.parameters = parameters;
    }
}
