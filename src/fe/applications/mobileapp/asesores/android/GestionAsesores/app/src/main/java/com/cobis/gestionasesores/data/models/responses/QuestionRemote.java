package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */
public class QuestionRemote {
    private String answer;
    private List<QuestionParametersRemote> parameters;

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public List<QuestionParametersRemote> getParameters() {
        return parameters;
    }

    public void setParameters(List<QuestionParametersRemote> parameters) {
        this.parameters = parameters;
    }
}