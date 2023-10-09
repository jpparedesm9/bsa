package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.requests.AuthRequest;
import com.cobis.tuiiob2c.data.models.responses.AuthResponse;
import com.cobis.tuiiob2c.services.modules.AuthApi;
import com.cobis.tuiiob2c.usecases.source.LoginSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class LoginRepository implements LoginSource {

    private AuthApi authApi;

    public LoginRepository(AuthApi authApi) {
        this.authApi = authApi;
    }

    @Override
    public AuthResponse auth(AuthRequest authRequest) {
        AuthResponse authResponse = new AuthResponse();
        try {
            Response<Void> authResponseResponse = authApi.login(authRequest).execute();
            int statusCode = authResponseResponse.code();
            if (statusCode != 200) {
                if (authResponseResponse.errorBody() != null) {
                    authResponse = new Gson().fromJson(authResponseResponse.errorBody().charStream(), AuthResponse.class);
                }
            }
            if (authResponse != null) {
                authResponse.setResponseCode(statusCode);
                authResponse.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            authResponse.setResponseCode(0);
            authResponse.setResult(false);
        }

        return authResponse;
    }
}
