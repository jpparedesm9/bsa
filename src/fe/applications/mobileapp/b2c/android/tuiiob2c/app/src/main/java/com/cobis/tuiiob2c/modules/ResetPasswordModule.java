package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.resetPassword.ResetPasswordMVP;
import com.cobis.tuiiob2c.presentation.resetPassword.ResetPasswordPresenter;
import com.cobis.tuiiob2c.repositories.CreateUpdatePasswordRepository;
import com.cobis.tuiiob2c.services.modules.CreateUpdatePasswordApi;
import com.cobis.tuiiob2c.usecases.CreatePasswordUseCase;
import com.cobis.tuiiob2c.usecases.source.ResetPasswordSource;

import dagger.Module;
import dagger.Provides;

@Module
public class ResetPasswordModule {

    @Provides
    public ResetPasswordMVP.ResetPasswordPresenter providerResetPasswordPresenter(ResetPasswordMVP.ResetPasswordModel resetPasswordModel) {
        return new ResetPasswordPresenter(resetPasswordModel);
    }

    @Provides
    public ResetPasswordMVP.ResetPasswordModel providerResetPasswordModel(ResetPasswordSource resetPasswordSource) {
        return new CreatePasswordUseCase(resetPasswordSource);
    }

    @Provides
    public ResetPasswordSource providerResetPasswordSource(CreateUpdatePasswordApi createUpdatePasswordApi) {
        return new CreateUpdatePasswordRepository(createUpdatePasswordApi);
    }
}
