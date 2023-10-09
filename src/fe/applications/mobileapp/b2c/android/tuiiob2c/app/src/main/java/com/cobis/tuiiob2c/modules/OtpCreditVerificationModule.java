package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.otpCreditVerification.OtpCreditVerificationMVP;
import com.cobis.tuiiob2c.presentation.otpCreditVerification.OtpCreditVerificationPresenter;
import com.cobis.tuiiob2c.repositories.LoanRepository;
import com.cobis.tuiiob2c.services.modules.LoanApi;
import com.cobis.tuiiob2c.usecases.OtpCreditVerificationUseCase;
import com.cobis.tuiiob2c.usecases.source.OtpCreditVerificationSource;

import dagger.Module;
import dagger.Provides;

@Module
public class OtpCreditVerificationModule {

    @Provides
    public OtpCreditVerificationMVP.OtpCreditVerificationPresenter providerOtpCreditVerificationPresenter(OtpCreditVerificationMVP.OtpCreditVerificationModel otpCreditVerificationModel) {
        return new OtpCreditVerificationPresenter(otpCreditVerificationModel);
    }

    @Provides
    public OtpCreditVerificationMVP.OtpCreditVerificationModel providerOtpCreditVerificationModel(OtpCreditVerificationSource otpCreditVerificationSource) {
        return new OtpCreditVerificationUseCase(otpCreditVerificationSource);
    }

    @Provides
    public OtpCreditVerificationSource providerOtpCreditVerificationSource(LoanApi loanApi) {
        return new LoanRepository(loanApi);
    }
}
