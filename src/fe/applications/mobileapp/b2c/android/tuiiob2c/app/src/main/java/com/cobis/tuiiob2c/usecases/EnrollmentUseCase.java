package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.requests.EnrollmentRequest;
import com.cobis.tuiiob2c.data.models.responses.EnrollmentResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.enrollment.EnrollmentMVP;
import com.cobis.tuiiob2c.usecases.source.EnrollmentSource;

import io.reactivex.Observable;

public class EnrollmentUseCase implements EnrollmentMVP.EnrollmentModel {

    private EnrollmentSource enrollmentSource;

    public EnrollmentUseCase(EnrollmentSource enrollmentSource) {
        this.enrollmentSource = enrollmentSource;
    }

    @Override
    public Observable<EnrollmentResponse> validatePinEnrollment(String pin) {
        return Observable.fromCallable(() -> {
            EnrollmentResponse enrollmentResponse = enrollmentSource.validateEnrollment(new EnrollmentRequest(pin));
            if (enrollmentResponse.isResult()) {
                SessionManager sessionManager = SessionManager.getInstance();
                sessionManager.saveValuesEnrollment(enrollmentResponse.getData());
            }
            return enrollmentResponse;
        });
    }
}
