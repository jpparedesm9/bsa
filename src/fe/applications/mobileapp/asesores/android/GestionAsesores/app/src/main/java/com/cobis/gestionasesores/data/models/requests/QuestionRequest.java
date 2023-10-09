package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 18/08/2017.
 */

public class QuestionRequest {
    private String answer;

    public QuestionRequest(String answer) {
        this.answer = answer;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
