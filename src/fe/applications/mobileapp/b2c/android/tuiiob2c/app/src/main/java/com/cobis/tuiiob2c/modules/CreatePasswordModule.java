package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.createPassword.CreatePasswordMVP;
import com.cobis.tuiiob2c.presentation.createPassword.CreatePasswordPresenter;
import com.cobis.tuiiob2c.repositories.CreateUpdatePasswordRepository;
import com.cobis.tuiiob2c.services.modules.CreateUpdatePasswordApi;
import com.cobis.tuiiob2c.usecases.source.CreatePasswordSource;
import com.cobis.tuiiob2c.usecases.CreatePasswordUseCase;

import dagger.Module;
import dagger.Provides;

@Module
public class CreatePasswordModule {

    @Provides
    public CreatePasswordMVP.CreatePasswordPresenter providerCreatePasswordPresenter(CreatePasswordMVP.CreatePasswordModel createPasswordModel) {
        return new CreatePasswordPresenter(createPasswordModel);
    }

    @Provides
    public CreatePasswordMVP.CreatePasswordModel providerCreatePasswordModel(CreatePasswordSource createPasswordSource) {
        return new CreatePasswordUseCase(createPasswordSource);
    }

    @Provides
    public CreatePasswordSource providerCreatePasswordSource(CreateUpdatePasswordApi createUpdatePasswordApi) {
        return new CreateUpdatePasswordRepository(createUpdatePasswordApi);
    }
}
