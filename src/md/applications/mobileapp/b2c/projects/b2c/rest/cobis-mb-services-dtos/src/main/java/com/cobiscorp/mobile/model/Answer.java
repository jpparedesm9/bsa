/*
 * Crédito en Línea
 * Servicios para aplicación de crédito en    
 *
 * OpenAPI spec version: 1.0.0
 * Contact: pablo.lopez@ndeveloper.com
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */


package com.cobiscorp.mobile.model;

import java.util.Objects;

/**
 * AnswersAnswers
 */
public class Answer   {
  private Integer questionId = null;

  private String answer = null;

  public Answer questionId(Integer questionId) {
    this.questionId = questionId;
    return this;
  }

  /**
   * Get questionId
   * @return questionId
   **/
  public Integer getQuestionId() {
    return questionId;
  }

  public void setQuestionId(Integer questionId) {
    this.questionId = questionId;
  }

  public Answer answer(String answer) {
    this.answer = answer;
    return this;
  }

  /**
   * Get answer
   * @return answer
   **/
  public String getAnswer() {
    return answer;
  }

  public void setAnswer(String answer) {
    this.answer = answer;
  }


  @Override
  public boolean equals(java.lang.Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    Answer answersAnswers = (Answer) o;
    return Objects.equals(this.questionId, answersAnswers.questionId) &&
        Objects.equals(this.answer, answersAnswers.answer);
  }

  @Override
  public int hashCode() {
    return Objects.hash(questionId, answer);
  }


  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class AnswersAnswers {\n");
    
    sb.append("    questionId: ").append(toIndentedString(questionId)).append("\n");
    sb.append("    answer: ").append(toIndentedString(answer)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(java.lang.Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}

