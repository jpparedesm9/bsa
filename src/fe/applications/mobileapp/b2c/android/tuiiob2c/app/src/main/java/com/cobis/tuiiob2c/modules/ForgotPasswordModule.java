package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.forgotPassword.ForgotPasswordMVP;
import com.cobis.tuiiob2c.presentation.forgotPassword.ForgotPasswordPresenter;
import com.cobis.tuiiob2c.repositories.ForgotPasswordRepository;
import com.cobis.tuiiob2c.services.modules.ForgotPasswordApi;
import com.cobis.tuiiob2c.usecases.ForgotPasswordUseCase;
import com.cobis.tuiiob2c.usecases.source.ForgotPasswordSource;

import dagger.Module;
import dagger.Provides;

@Module
public class ForgotPasswordModule {

    @Provides
    public ForgotPasswordMVP.ForgotPasswordPresenter providerForgotPasswordPresenter(ForgotPasswordMVP.ForgotPasswordModel forgotPasswordModel) {
        return new ForgotPasswordPresenter(forgotPasswordModel);
    }

    @Provides
    public ForgotPasswordMVP.ForgotPasswordModel providerForgotPasswordModel(ForgotPasswordSource forgotPasswordSource) {
        return new ForgotPasswordUseCase(forgotPasswordSource);
    }

    @Provides
    public ForgotPasswordSource providerForgotPasswordSource(ForgotPasswordApi forgotPasswordApi) {
        return new ForgotPasswordRepository(forgotPasswordApi);
    }
}
