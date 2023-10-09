package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.requests.CreatePasswordRequest;
import com.cobis.tuiiob2c.data.models.requests.ResetPasswordRequest;
import com.cobis.tuiiob2c.data.models.requests.UpdatePasswordRequest;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import retrofit2.http.PUT;

public interface CreateUpdatePasswordApi {

    @POST("security/password")
    Call<Void> createPassword(@Body CreatePasswordRequest createPasswordRequest);

    @PUT("security/password")
    Call<Void> updatePassword(@Body UpdatePasswordRequest updatePasswordRequest);

    @POST("security/password/reset")
    Call<Void> resetPassword(@Body ResetPasswordRequest resetPasswordRequest);
}
