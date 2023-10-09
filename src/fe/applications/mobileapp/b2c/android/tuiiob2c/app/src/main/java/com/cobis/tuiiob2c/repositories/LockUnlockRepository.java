package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.UnlockQuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;
import com.cobis.tuiiob2c.services.modules.LockUnlockApi;
import com.cobis.tuiiob2c.usecases.source.LockSource;
import com.cobis.tuiiob2c.usecases.source.UnlockSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class LockUnlockRepository implements LockSource, UnlockSource {

    private LockUnlockApi lockUnlockApi;

    public LockUnlockRepository(LockUnlockApi lockUnlockApi) {
        this.lockUnlockApi = lockUnlockApi;
    }

    @Override
    public QuestionResponse getQuestions(UnlockQuestionRequest unlockQuestionRequest) {
        QuestionResponse questionResponse = new QuestionResponse();
        questionResponse.setResult(false);
        try {
            Response<QuestionResponse> questionResponseResponse = lockUnlockApi.getQuestions(unlockQuestionRequest).execute();
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
    public BaseModel lock() {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> createUpdatePasswordResponse = lockUnlockApi.lock().execute();
            int statusCode = createUpdatePasswordResponse.code();
            if (statusCode != 200) {
                if (createUpdatePasswordResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(createUpdatePasswordResponse.errorBody().charStream(), BaseModel.class);
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

    @Override
    public BaseModel unlock(AnswerRequest answerRequest) {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> createUpdatePasswordResponse = lockUnlockApi.unlock(answerRequest).execute();
            int statusCode = createUpdatePasswordResponse.code();
            if (statusCode != 200) {
                if (createUpdatePasswordResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(createUpdatePasswordResponse.errorBody().charStream(), BaseModel.class);
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
