package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.enrollment.EnrollmentMVP;
import com.cobis.tuiiob2c.presentation.enrollment.EnrollmentPresenter;
import com.cobis.tuiiob2c.repositories.EnrollmentRepository;
import com.cobis.tuiiob2c.services.modules.AuthApi;
import com.cobis.tuiiob2c.usecases.EnrollmentUseCase;
import com.cobis.tuiiob2c.usecases.source.EnrollmentSource;

import dagger.Module;
import dagger.Provides;

@Module
public class EnrollmentModule {

    @Provides
    public EnrollmentMVP.EnrollmentPresenter providerEnrollmentPresenter(EnrollmentMVP.EnrollmentModel enrollmentModel) {
        return new EnrollmentPresenter(enrollmentModel);
    }

    @Provides
    public EnrollmentMVP.EnrollmentModel providerEnrollmentModel(EnrollmentSource enrollmentSource) {
        return new EnrollmentUseCase(enrollmentSource);
    }

    @Provides
    public EnrollmentSource providerEnrollmentSource(AuthApi authApi) {
        return new EnrollmentRepository(authApi);
    }
}
