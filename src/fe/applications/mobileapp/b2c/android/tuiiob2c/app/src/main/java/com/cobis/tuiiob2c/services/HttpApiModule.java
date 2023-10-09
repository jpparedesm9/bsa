package com.cobis.tuiiob2c.services;

import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.cobis.tuiiob2c.AppConfig;
import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.infraestructure.KManager;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.services.modules.CreateUpdatePasswordApi;
import com.cobis.tuiiob2c.services.modules.ForgotPasswordApi;
import com.cobis.tuiiob2c.services.modules.LoanApi;
import com.cobis.tuiiob2c.services.modules.LockUnlockApi;
import com.cobis.tuiiob2c.services.modules.MessageApi;
import com.cobis.tuiiob2c.services.modules.PhoneValidationApi;
import com.cobis.tuiiob2c.utils.ConstantsHttp;
import com.cobis.tuiiob2c.utils.SslKeyStoreUtils;

import java.net.ConnectException;
import java.security.KeyStore;
import java.util.Collections;
import java.util.concurrent.TimeUnit;

import javax.inject.Singleton;

import dagger.Module;
import dagger.Provides;
import okhttp3.CertificatePinner;
import okhttp3.ConnectionSpec;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.TlsVersion;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

@Module
public class HttpApiModule {

    @Provides
    public OkHttpClient providerOkHttpClient() {
        HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor();
        interceptor.setLevel(App.getInstance().getConfig().isDeveloperModeEnabled() ? HttpLoggingInterceptor.Level.BODY : HttpLoggingInterceptor.Level.NONE);

        OkHttpClient.Builder clientBuilder = new OkHttpClient.Builder().addInterceptor(interceptor)
                .addInterceptor(chain -> chain
                        .proceed(chain
                                .request()
                                .newBuilder()
                                .addHeader("Authorization", ConstantsHttp.TOKEN_BEARER.isEmpty() ? "" : "Bearer " + ConstantsHttp.TOKEN_BEARER)
                                .build()))
                .addInterceptor(chain -> {
                    Response response = null;
                    try {
                        Request request = chain.request();
                        response = chain.proceed(request);
                        if (response.code() == 200) {
                            ConstantsHttp.TOKEN_BEARER = response.headers().get(ConstantsHttp.COBIS_JWT);
                        } else if (response.code() == 401) {
                            Intent logout = new Intent(App.ACTION_AUTH_LOGOUT);
                            LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).sendBroadcast(logout);
                        } else if (response.code() == 500 || response.code() == 502 || response.code() == 503) {
                            App.analizeError();
                        }
                    } catch (ConnectException e) {
                        App.analizeError();
                    }

                    return response;
                })
                .readTimeout(ConstantsHttp.READ_TIMEOUT, TimeUnit.MILLISECONDS)
                .connectTimeout(ConstantsHttp.CONNECT_TIMEOUT, TimeUnit.MILLISECONDS);

        if (App.getInstance().getConfig().isSslKeystoreEnabled()) {
            KeyStore trustKeyStore = SslKeyStoreUtils.getKeyStore(R.raw.tuiiob2c, KManager.getInstance().getKeyStoreKey());
            clientBuilder = SslKeyStoreUtils.okHttpBuilderWithTls(clientBuilder, trustKeyStore);

            try {
                clientBuilder.certificatePinner(new CertificatePinner.Builder()
                        .add("www.stuiio.com", CertificatePinner.pin(trustKeyStore.getCertificate("cer_pro")))
                        .add("www.stuiiodrp.com", CertificatePinner.pin(trustKeyStore.getCertificate("cer_drp")))
                        .build());
            } catch (Exception ex) {
                Log.e("Error in config: ", ex);
            }
            ConnectionSpec spec = new ConnectionSpec.Builder(ConnectionSpec.MODERN_TLS)
                    .tlsVersions(TlsVersion.TLS_1_2)
                    .build();
            clientBuilder.connectionSpecs(Collections.singletonList(spec));
        }

        return clientBuilder.build();
    }

    @Provides
    public Retrofit providerRetrofit(OkHttpClient okHttpClient) {
        return new Retrofit.Builder()
                .baseUrl(AppConfig.getInstance().getConfig().getEnvironment().getEndPoint())
                .client(okHttpClient)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build();
    }

    @Singleton
    @Provides
    public PhoneValidationApi providerPhoneValidationApi() {
        return providerRetrofit(providerOkHttpClient()).create(PhoneValidationApi.class);
    }

    @Singleton
    @Provides
    public CreateUpdatePasswordApi providerPasswordValidationApi() {
        return providerRetrofit(providerOkHttpClient()).create(CreateUpdatePasswordApi.class);
    }

    @Singleton
    @Provides
    public ForgotPasswordApi providerForgotPassworApi() {
        return providerRetrofit(providerOkHttpClient()).create(ForgotPasswordApi.class);
    }

    @Singleton
    @Provides
    public LoanApi providerLoanApi() {
        return providerRetrofit(providerOkHttpClient()).create(LoanApi.class);
    }

    @Singleton
    @Provides
    public MessageApi providerMessageApi() {
        return providerRetrofit(providerOkHttpClient()).create(MessageApi.class);
    }

    @Singleton
    @Provides
    public LockUnlockApi providerLockUnlockApi() {
        return providerRetrofit(providerOkHttpClient()).create(LockUnlockApi.class);
    }
}
