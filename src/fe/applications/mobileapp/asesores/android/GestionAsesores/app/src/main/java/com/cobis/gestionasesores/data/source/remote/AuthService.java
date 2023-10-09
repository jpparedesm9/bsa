package com.cobis.gestionasesores.data.source.remote;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.models.requests.AuthRequest;
import com.cobis.gestionasesores.data.models.responses.AuthResponse;
import com.cobis.gestionasesores.utils.GsonHelper;

import java.io.IOException;
import java.net.ConnectException;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Service to authenticate user with Cobis Core
 * Created by Miguel on 14/07/2017.
 */
public class AuthService extends RestServiceHandler {
    private static final String RESOURCE = "resources/cobis/web/security/";
    private static final String METHOD_AUTHENTICATE  = "authenticate";

    public AuthService() {
        super(BankAdvisorApp.getInstance().getConfig().getEnvironment().getEndPoint()+RESOURCE);
    }

    public AuthResponse login(AuthRequest authRequest) throws Exception{
        Response response = post(METHOD_AUTHENTICATE, GsonHelper.getGson().toJson(authRequest));
        return GsonHelper.getGson().fromJson(response.body().string() ,AuthResponse.class);
    }

    @Override
    protected OkHttpClient getOkHttpClient() {
        return BankAdvisorApp.getInstance().getOkHttpClient().newBuilder().addInterceptor(new Interceptor() {
            @Override
            public Response intercept(@NonNull Chain chain) throws IOException {
                Response response = null;
                try {
                    Request request = chain.request();
                    response = chain.proceed(request);
                    if (response.code() == 500 || response.code() == 502 || response.code() == 503) {
                        BankAdvisorApp.analizeError();
                    }
                    return response;
                } catch (ConnectException e) {
                    BankAdvisorApp.analizeError();
                }
                return response;
            }
        }).build();
    }
}