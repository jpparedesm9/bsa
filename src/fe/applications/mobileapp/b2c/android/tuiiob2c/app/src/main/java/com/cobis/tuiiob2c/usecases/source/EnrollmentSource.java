package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.responses.EnrollmentResponse;
import com.cobis.tuiiob2c.data.models.requests.EnrollmentRequest;

public interface EnrollmentSource {

    EnrollmentResponse validateEnrollment(EnrollmentRequest enrollmentRequest);
}
