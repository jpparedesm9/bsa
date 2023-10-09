package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.changePassword.ChangePasswordMVP;
import com.cobis.tuiiob2c.presentation.changePassword.ChangePasswordPresenter;
import com.cobis.tuiiob2c.repositories.CreateUpdatePasswordRepository;
import com.cobis.tuiiob2c.services.modules.CreateUpdatePasswordApi;
import com.cobis.tuiiob2c.usecases.CreatePasswordUseCase;
import com.cobis.tuiiob2c.usecases.source.UpdatePasswordSource;

import dagger.Module;
import dagger.Provides;

@Module
public class ChangePasswordModule {

    @Provides
    public ChangePasswordMVP.ChangePasswordPresenter providerChangePasswordPresenter(ChangePasswordMVP.ChangePasswordModel changePasswordModel) {
        return new ChangePasswordPresenter(changePasswordModel);
    }

    @Provides
    public ChangePasswordMVP.ChangePasswordModel providerChangePasswordModel(UpdatePasswordSource updatePasswordSource) {
        return new CreatePasswordUseCase(updatePasswordSource);
    }

    @Provides
    public UpdatePasswordSource providerCreatePasswordSource(CreateUpdatePasswordApi createUpdatePasswordApi) {
        return new CreateUpdatePasswordRepository(createUpdatePasswordApi);
    }
}
