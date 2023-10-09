package com.cobis.tuiiob2c.data.models.requests;

import com.cobis.tuiiob2c.data.models.Answer;

import java.util.List;

public class AnswerRequest {

    private List<Answer> answers;

    public AnswerRequest() {
    }

    public AnswerRequest(List<Answer> answers) {
        this.answers = answers;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }
}
