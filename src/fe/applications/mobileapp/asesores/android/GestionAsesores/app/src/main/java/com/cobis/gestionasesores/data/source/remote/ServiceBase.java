package com.cobis.gestionasesores.data.source.remote;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v4.content.LocalBroadcastManager;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.infrastructure.SessionManager;

import java.io.IOException;
import java.net.ConnectException;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Response;

public class ServiceBase extends RestServiceHandler {

    public ServiceBase(String endpoint) {
        super(endpoint);
    }

    public static final String ACTION_AUTH_LOGOUT = "com.cobis.gestionasesores.auth.actions.LOGOUT";
    public static final String ACTION_AUTH_NEED_ONLINE = "com.cobis.gestionasesores.auth.actions.NEED_ONLINE";

    @Override
    protected OkHttpClient getOkHttpClient() {
        return BankAdvisorApp.getInstance().getOkHttpClient().newBuilder().addInterceptor(new Interceptor() {
            @NonNull
            @Override
            public Response intercept(@NonNull Chain chain) throws IOException {
                SessionManager sessionManager = SessionManager.getInstance();
                String token = StringUtils.nullToString(sessionManager.getSession().getToken());

                // check options
                if (sessionManager.isSessionActive() && StringUtils.isEmpty(token)) {
                    Intent needOnline = new Intent(ACTION_AUTH_NEED_ONLINE);
                    LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).sendBroadcast(needOnline);
                }

                Response response = null;
                try {
                    response = chain.proceed(chain.request().newBuilder().
                            addHeader("Authorization", "Bearer " + token).
                            addHeader("channel", String.valueOf(Constants.CHANNEL)).build());
                    if (response.code() == 401) {
                        Intent logout = new Intent(ACTION_AUTH_LOGOUT);
                        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).sendBroadcast(logout);
                    } else if (response.code() == 500 || response.code() == 502 || response.code() == 503) {
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
