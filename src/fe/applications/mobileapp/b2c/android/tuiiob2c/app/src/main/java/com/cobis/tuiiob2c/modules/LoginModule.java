package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.login.LoginMVP;
import com.cobis.tuiiob2c.services.modules.AuthApi;
import com.cobis.tuiiob2c.usecases.LoginUseCase;
import com.cobis.tuiiob2c.presentation.login.LoginPresenter;
import com.cobis.tuiiob2c.repositories.LoginRepository;
import com.cobis.tuiiob2c.usecases.source.LoginSource;

import dagger.Module;
import dagger.Provides;

@Module
public class LoginModule {

    @Provides
    public LoginMVP.LoginPresenter providerLoginPresenter(LoginMVP.LoginModel loginModel) {
        return new LoginPresenter(loginModel);
    }

    @Provides
    public LoginMVP.LoginModel providerLoginModel(LoginSource loginSource) {
        return new LoginUseCase(loginSource);
    }

    @Provides
    public LoginSource providerLoginSource(AuthApi authApi) {
        return new LoginRepository(authApi);
    }
}
