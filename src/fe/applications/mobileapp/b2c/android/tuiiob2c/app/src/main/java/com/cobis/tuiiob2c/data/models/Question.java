package com.cobis.tuiiob2c.data.models;

import com.cobis.tuiiob2c.data.enums.QuestionType;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Question {

    @SerializedName("questionId")
    @Expose
    private int questionId;
    @SerializedName("question")
    @Expose
    private String question;
    @SerializedName("responseType")
    @Expose
    @QuestionType
    private String responseType;
    @SerializedName("allowEmptyAnswer")
    @Expose
    private boolean allowEmptyAnswer;

    /**
     * No args constructor for use in serialization
     *
     */
    public Question() {
    }

    /**
     *
     * @param allowEmptyAnswer
     * @param questionId
     * @param responseType
     * @param question
     */
    public Question(int questionId, String question, String responseType, boolean allowEmptyAnswer) {
        super();
        this.questionId = questionId;
        this.question = question;
        this.responseType = responseType;
        this.allowEmptyAnswer = allowEmptyAnswer;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getResponseType() {
        return responseType;
    }

    public void setResponseType(String responseType) {
        this.responseType = responseType;
    }

    public boolean getAllowEmptyAnswer() {
        return allowEmptyAnswer;
    }

    public void setAllowEmptyAnswer(boolean allowEmptyAnswer) {
        this.allowEmptyAnswer = allowEmptyAnswer;
    }

}