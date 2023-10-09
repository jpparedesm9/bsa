package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.MessagePin;
import com.cobis.tuiiob2c.data.models.requests.MessageRequest;
import com.cobis.tuiiob2c.services.modules.MessageApi;
import com.cobis.tuiiob2c.usecases.source.NotificationsPinSource;
import com.cobis.tuiiob2c.usecases.source.NotificationsSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class NotificationsRepository implements NotificationsSource, NotificationsPinSource {

    private MessageApi messageApi;

    public NotificationsRepository(MessageApi messageApi) {
        this.messageApi = messageApi;
    }

    @Override
    public BaseModel responseMessage(MessageRequest messageRequest) {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> messageResponseResponse = messageApi.answerMessage(messageRequest).execute();
            int statusCode = messageResponseResponse.code();
            if (statusCode != 200) {
                if (messageResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(messageResponseResponse.errorBody().charStream(), BaseModel.class);
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
    public BaseModel responseMessagePin(MessagePin messagePin) {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> messageResponseResponse = messageApi.answerMessagePin(messagePin).execute();
            int statusCode = messageResponseResponse.code();
            if (statusCode != 200) {
                if (messageResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(messageResponseResponse.errorBody().charStream(), BaseModel.class);
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
