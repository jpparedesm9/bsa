package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.requests.AuthRequest;
import com.cobis.tuiiob2c.data.models.requests.EnrollmentRequest;
import com.cobis.tuiiob2c.data.models.responses.EnrollmentResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface AuthApi {

    @POST("security/login")
    Call<Void> login(@Body AuthRequest authRequest);

    @POST("security/onboard")
    Call<EnrollmentResponse> validatePinEnrollment(@Body EnrollmentRequest enrollmentRequest);
}
