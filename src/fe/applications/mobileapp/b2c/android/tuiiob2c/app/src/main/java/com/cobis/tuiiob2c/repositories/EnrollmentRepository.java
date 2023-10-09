package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.requests.EnrollmentRequest;
import com.cobis.tuiiob2c.data.models.responses.EnrollmentResponse;
import com.cobis.tuiiob2c.services.modules.AuthApi;
import com.cobis.tuiiob2c.usecases.source.EnrollmentSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class EnrollmentRepository implements EnrollmentSource {

    private AuthApi authApi;

    public EnrollmentRepository(AuthApi authApi) {
        this.authApi = authApi;
    }

    @Override
    public EnrollmentResponse validateEnrollment(EnrollmentRequest enrollmentRequest) {
        EnrollmentResponse enrollmentResponse = new EnrollmentResponse();
        enrollmentResponse.setResult(false);
        try {
            Response<EnrollmentResponse> enrollmentResponseResponse = authApi.validatePinEnrollment(enrollmentRequest).execute();
            int statusCode = enrollmentResponseResponse.code();
            if (statusCode == 200) {
                enrollmentResponse = enrollmentResponseResponse.body();
            } else {
                if (enrollmentResponseResponse.errorBody() != null) {
                    enrollmentResponse = new Gson().fromJson(enrollmentResponseResponse.errorBody().charStream(), EnrollmentResponse.class);
                }
            }
            if (enrollmentResponse != null) {
                enrollmentResponse.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            enrollmentResponse.setResult(false);
        }

        return enrollmentResponse;
    }
}
