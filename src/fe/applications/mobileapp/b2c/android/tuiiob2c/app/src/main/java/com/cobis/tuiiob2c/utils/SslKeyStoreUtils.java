package com.cobis.tuiiob2c.utils;

import android.content.res.Resources;
import android.support.annotation.RawRes;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;

import java.io.InputStream;
import java.security.KeyStore;
import java.util.Arrays;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

import okhttp3.OkHttpClient;

public class SslKeyStoreUtils {

    public static KeyStore getKeyStore(@RawRes int trustStoreRaw, String password) {
        KeyStore trustStore = null;
        try {
            Resources res = LibCore.getApplicationContext().getResources();
            InputStream inTrustStore = res.openRawResource(trustStoreRaw);
            if (inTrustStore != null) {
                trustStore = KeyStore.getInstance("BKS");
                try {
                    trustStore.load(inTrustStore, password.toCharArray());
                } finally {
                    inTrustStore.close();
                }
            }
        } catch (Exception ex) {
            Log.e("SslKeyStoreUtils::getKeyStore: ", ex);
        }
        return trustStore;
    }

    public static OkHttpClient.Builder okHttpBuilderWithTls(OkHttpClient.Builder builder, KeyStore trustKey) {
        try {
            TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
            trustManagerFactory.init(trustKey);

            TrustManager[] trustManagers = trustManagerFactory.getTrustManagers();
            if (trustManagers.length != 1 || !(trustManagers[0] instanceof X509TrustManager)) {
                throw new IllegalStateException("Unexpected default trust managers:" + Arrays.toString(trustManagers));
            }
            X509TrustManager trustManager = (X509TrustManager) trustManagers[0];
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[]{trustManager}, null);
            builder.sslSocketFactory(sslContext.getSocketFactory(), trustManager);
        } catch (Exception ex) {
            Log.e("SslKeyStoreUtils::okHttpBuilderWithTls:", ex);
        }
        return builder;
    }

}