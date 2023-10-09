package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.QuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import retrofit2.http.PUT;

public interface ForgotPasswordApi {

    @POST("security/challenge")
    Call<QuestionResponse> getQuestions(@Body QuestionRequest questionRequest);

    @PUT("security/challenge")
    Call<Void> answerQuestions(@Body AnswerRequest answerRequest);
}
