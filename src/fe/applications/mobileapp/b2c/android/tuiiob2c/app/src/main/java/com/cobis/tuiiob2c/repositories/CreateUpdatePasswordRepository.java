package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.CreatePasswordRequest;
import com.cobis.tuiiob2c.data.models.requests.ResetPasswordRequest;
import com.cobis.tuiiob2c.data.models.requests.UpdatePasswordRequest;
import com.cobis.tuiiob2c.services.modules.CreateUpdatePasswordApi;
import com.cobis.tuiiob2c.usecases.source.CreatePasswordSource;
import com.cobis.tuiiob2c.usecases.source.ResetPasswordSource;
import com.cobis.tuiiob2c.usecases.source.UpdatePasswordSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class CreateUpdatePasswordRepository implements CreatePasswordSource, UpdatePasswordSource, ResetPasswordSource {

    private CreateUpdatePasswordApi createUpdatePasswordApi;

    public CreateUpdatePasswordRepository(CreateUpdatePasswordApi createUpdatePasswordApi) {
        this.createUpdatePasswordApi = createUpdatePasswordApi;
    }

    @Override
    public BaseModel validatePasswords(CreatePasswordRequest createPasswordRequest) {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> createUpdatePasswordResponse = createUpdatePasswordApi.createPassword(createPasswordRequest).execute();
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
    public BaseModel validateChangePassword(UpdatePasswordRequest updatePasswordRequest) {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> createUpdatePasswordResponse = createUpdatePasswordApi.updatePassword(updatePasswordRequest).execute();
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
    public BaseModel resetPassword(ResetPasswordRequest resetPasswordRequest) {
        BaseModel baseModel = new BaseModel();
        try {
            Response<Void> resetPasswordResponseResponse = createUpdatePasswordApi.resetPassword(resetPasswordRequest).execute();
            int statusCode = resetPasswordResponseResponse.code();
            if (statusCode != 200) {
                if (resetPasswordResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(resetPasswordResponseResponse.errorBody().charStream(), BaseModel.class);
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
