package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.PhoneValidationOtpRequest;
import com.cobis.tuiiob2c.data.models.requests.PhoneValidationRequest;
import com.cobis.tuiiob2c.services.modules.PhoneValidationApi;
import com.cobis.tuiiob2c.usecases.source.OtpVerificationSource;
import com.cobis.tuiiob2c.usecases.source.PhoneValidationSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class PhoneValidationRepository implements PhoneValidationSource, OtpVerificationSource {

    private PhoneValidationApi phoneValidationApi;

    public PhoneValidationRepository(PhoneValidationApi phoneValidationApi) {
        this.phoneValidationApi = phoneValidationApi;
    }

    @Override
    public BaseModel changePhone(PhoneValidationRequest phoneValidationRequest) {
        BaseModel baseModel = new BaseModel();
        baseModel.setResult(false);
        try {
            Response<Void> phoneValidationResponseResponse = phoneValidationApi.changePhone(phoneValidationRequest).execute();
            int statusCode = phoneValidationResponseResponse.code();
            if (statusCode != 200) {
                if (phoneValidationResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(phoneValidationResponseResponse.errorBody().charStream(), BaseModel.class);
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
    public BaseModel changePhoneOtp(PhoneValidationOtpRequest phoneValidationOtpRequest) {
        BaseModel baseModel = new BaseModel();
        baseModel.setResult(false);
        try {
            Response<Void> phoneValidationOtpResponseResponse = phoneValidationApi.changePhoneOtp(phoneValidationOtpRequest).execute();
            int statusCode = phoneValidationOtpResponseResponse.code();
            if (statusCode != 200) {
                if (phoneValidationOtpResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(phoneValidationOtpResponseResponse.errorBody().charStream(), BaseModel.class);
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
