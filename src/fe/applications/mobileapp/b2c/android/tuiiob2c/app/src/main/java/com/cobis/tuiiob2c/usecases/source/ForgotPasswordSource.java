package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.QuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;

public interface ForgotPasswordSource {

    QuestionResponse getQuestions(QuestionRequest questionRequest);

    BaseModel answerQuestions(AnswerRequest answerRequest);
}
