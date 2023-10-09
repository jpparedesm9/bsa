package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.requests.PhoneValidationOtpRequest;
import com.cobis.tuiiob2c.data.models.requests.PhoneValidationRequest;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import retrofit2.http.PUT;

public interface PhoneValidationApi {

    @PUT("security/client/changePhone")
    Call<Void> changePhone(@Body PhoneValidationRequest phoneValidationRequest);

    @POST("security/client/changePhone")
    Call<Void> changePhoneOtp(@Body PhoneValidationOtpRequest phoneValidationOtpRequest);
}
