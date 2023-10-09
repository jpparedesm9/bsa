package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.UnlockQuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import retrofit2.http.PUT;

public interface LockUnlockApi {

    @POST("security/challenge")
    Call<QuestionResponse> getQuestions(@Body UnlockQuestionRequest unlockQuestionRequest);

    @PUT("security/client/block")
    Call<Void> lock();

    @PUT("security/client/unblock")
    Call<Void> unlock(@Body AnswerRequest answerRequest);
}
