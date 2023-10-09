package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationMVP;
import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationPresenter;
import com.cobis.tuiiob2c.repositories.PhoneValidationRepository;
import com.cobis.tuiiob2c.services.modules.PhoneValidationApi;
import com.cobis.tuiiob2c.usecases.PhoneValidationUseCase;
import com.cobis.tuiiob2c.usecases.source.OtpVerificationSource;

import dagger.Module;
import dagger.Provides;

@Module
public class OtpVerificationModule {

    @Provides
    public OtpVerificationMVP.OtpVerificationPresenter providerOtpVerificationPresenter(OtpVerificationMVP.OtpVerificationModel otpVerificationModel) {
        return new OtpVerificationPresenter(otpVerificationModel);
    }

    @Provides
    public OtpVerificationMVP.OtpVerificationModel providerOtpVerificationModel(OtpVerificationSource otpVerificationSource) {
        return new PhoneValidationUseCase(otpVerificationSource);
    }

    @Provides
    public OtpVerificationSource providerOtpVerificationSource(PhoneValidationApi phoneValidationApi) {
        return new PhoneValidationRepository(phoneValidationApi);
    }
}
