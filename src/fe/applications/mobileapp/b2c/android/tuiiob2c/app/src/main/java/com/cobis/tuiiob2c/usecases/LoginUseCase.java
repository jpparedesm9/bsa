package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.requests.AuthRequest;
import com.cobis.tuiiob2c.data.models.responses.AuthResponse;
import com.cobis.tuiiob2c.presentation.login.LoginMVP;
import com.cobis.tuiiob2c.usecases.source.LoginSource;
import com.cobis.tuiiob2c.utils.ConstantsHttp;

import io.reactivex.Observable;

public class LoginUseCase implements LoginMVP.LoginModel {

    private LoginSource loginSource;

    public LoginUseCase(LoginSource loginSource) {
        this.loginSource = loginSource;
    }

    @Override
    public Observable<AuthResponse> validatePin(String phoneNumber, String pin) {
        ConstantsHttp.TOKEN_BEARER = "";
        //TODO poner pin encriptado
        //return Observable.fromCallable(() -> loginSource.auth(new AuthRequest(phoneNumber, SecurityUtil.encryptWithPublicKey(App.getInstance().getPublicKey(), pin), ConstantsHttp.CULTURE)));
        return Observable.fromCallable(() -> loginSource.auth(new AuthRequest(phoneNumber, pin, ConstantsHttp.CULTURE)));
    }
}
