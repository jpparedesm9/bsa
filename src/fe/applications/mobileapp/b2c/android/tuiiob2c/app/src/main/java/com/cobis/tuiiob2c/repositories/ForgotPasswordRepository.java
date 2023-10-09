package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.QuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;
import com.cobis.tuiiob2c.services.modules.ForgotPasswordApi;
import com.cobis.tuiiob2c.usecases.source.ForgotPasswordSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class ForgotPasswordRepository implements ForgotPasswordSource {

    private ForgotPasswordApi forgotPasswordApi;

    public ForgotPasswordRepository(ForgotPasswordApi forgotPasswordApi) {
        this.forgotPasswordApi = forgotPasswordApi;
    }

    @Override
    public QuestionResponse getQuestions(QuestionRequest questionRequest) {
        QuestionResponse questionResponse = new QuestionResponse();
        questionResponse.setResult(false);
        try {
            Response<QuestionResponse> questionResponseResponse = forgotPasswordApi.getQuestions(questionRequest).execute();
            int statusCode = questionResponseResponse.code();
            if (statusCode == 200) {
                questionResponse = questionResponseResponse.body();
            } else {
                if (questionResponseResponse.errorBody() != null) {
                    questionResponse = new Gson().fromJson(questionResponseResponse.errorBody().charStream(), QuestionResponse.class);
                }
            }
            if (questionResponse != null) {
                questionResponse.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            questionResponse.setResult(false);
        }

        return questionResponse;
    }

    @Override
    public BaseModel answerQuestions(AnswerRequest answerRequest) {
        BaseModel baseModel = new BaseModel();
        baseModel.setResult(false);
        try {
            Response<Void> answerResponseResponse = forgotPasswordApi.answerQuestions(answerRequest).execute();
            int statusCode = answerResponseResponse.code();
            if (statusCode != 200) {
                if (answerResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(answerResponseResponse.errorBody().charStream(), BaseModel.class);
                }
            }
            if (baseModel != null) {
                baseModel.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            baseModel.setResult(false);
        }

        return baseModel;
    }
}
