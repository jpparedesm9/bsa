package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.UnlockQuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;

public interface UnlockSource {

    QuestionResponse getQuestions(UnlockQuestionRequest unlockQuestionRequest);

    BaseModel unlock(AnswerRequest answerRequest);
}
