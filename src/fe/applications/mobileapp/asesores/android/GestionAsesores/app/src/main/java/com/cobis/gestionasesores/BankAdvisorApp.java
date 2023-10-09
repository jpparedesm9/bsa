package com.cobis.gestionasesores;

import android.os.Build;
import android.support.multidex.MultiDexApplication;
import android.support.v4.content.ContextCompat;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.io.FileUtils;
import com.bayteq.libcore.io.LibCoreIO;
import com.bayteq.libcore.logs.ConsoleAppender;
import com.bayteq.libcore.logs.ELogLevel;
import com.bayteq.libcore.logs.FileAppender;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.DeviceUtils;
import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.infrastructure.KManager;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.utils.SslKeyStoreUtils;

import java.io.File;
import java.io.InputStream;
import java.security.KeyStore;
import java.util.Collections;
import java.util.concurrent.TimeUnit;

import okhttp3.CertificatePinner;
import okhttp3.ConnectionSpec;
import okhttp3.OkHttpClient;
import okhttp3.TlsVersion;

/**
 * Entry point application
 * Created by mnaunay on 02/06/2017.
 */
public abstract class BankAdvisorApp extends MultiDexApplication {
    /**
     * Timeout for connection
     */
    private static final int CONNECT_TIMEOUT = 90000;
    /**
     * Timeout for server
     */
    private static final int READ_TIMEOUT = 90000;
    /**
     * Max keep alive of the logs
     */
    private static final long MAX_KEEP_ALIVE_LOGS = 6 * 24 * 60 * 60 * 1000;

    private static BankAdvisorApp sInstance;
    private BankAdvisorConfig mConfig;
    private OkHttpClient mOkHttpClient;

    public static BankAdvisorApp getInstance() {
        return sInstance;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        sInstance = this;
        if (LibCore.getApplicationContext() == null) {
            LibCore.setApplicationContext(this);
            LibCore.setUseOnlyInternalStorage(!BuildConfig.DEBUG);
        }

        mConfig = buildConfig();

        configurationLogs(mConfig.isDeveloperModeEnabled());

        mOkHttpClient = createOkHttpClient();
        new Thread(new Runnable() {
            @Override
            public void run() {
                collectLogs(MAX_KEEP_ALIVE_LOGS);
            }
        }).start();
    }

    public void setmConfig(BankAdvisorConfig mConfig) {
        this.mConfig = mConfig;
    }

    /**
     * Collects records that are expired and deletes
     *
     * @param maxKeepAlive Maximum lifetime of records
     */
    public static void collectLogs(long maxKeepAlive) {
        try {
            int deleteFiles = 0;
            long now = System.currentTimeMillis();
            File logFile = new File(LibCoreIO.getLogDirectory());
            for (File file : logFile.listFiles()) {
                if ((now - file.lastModified()) > maxKeepAlive) {
                    file.delete();
                    deleteFiles++;
                }
            }

            //Delete zip of logs files storage into cache directory
            int deleteZipFiles = 0;
            File zipFile = new File(LibCoreIO.getCacheDirectory());
            for (File file : zipFile.listFiles()) {
                if (file.getName().endsWith(Constants.LOG_TRACE_EXTENSION)) {
                    file.delete();
                    deleteZipFiles++;
                }
            }
            Log.i(String.format("Logs Collector > %d traces and %d zip files deleted", deleteFiles, deleteZipFiles));
        } catch (Exception ex) {
            Log.e("MobilePosApp::collectLogs:", ex);
        }
    }

    public abstract BankAdvisorConfig buildConfig();

    /**
     * Gets application configuration
     *
     * @return Configuration
     */
    public synchronized BankAdvisorConfig getConfig() {
        return mConfig;
    }

    /**
     * The Http client used by the app to create web service requests
     *
     * @return
     */
    public OkHttpClient getOkHttpClient() {
        return mOkHttpClient;
    }

    public void setEnvironment(Environment environment) {
        mConfig.setEnvironment(environment);
    }

    private OkHttpClient createOkHttpClient() {
        OkHttpClient.Builder clientBuilder = new OkHttpClient.Builder();
        if (mConfig.isSslKeystoreEnabled()) {
            KeyStore trustKeyStore = SslKeyStoreUtils.getKeyStore(R.raw.cobiskeystore, KManager.getInstance().getKeyStoreKey());
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

        return clientBuilder
                .connectTimeout(CONNECT_TIMEOUT, TimeUnit.MILLISECONDS)
                .readTimeout(READ_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();
    }

    /**
     * Allows setup configuration log for all application
     *
     * @param enabled True for enabled and False for disabled log
     */
    private void configurationLogs(boolean enabled) {
        if (enabled) {
            String packageName = LibCore.getApplicationContext().getPackageName();
            String logFile = packageName.substring(packageName.lastIndexOf(".") + 1);
            Log.addAppender(new ConsoleAppender());
            Log.addAppender(new FileAppender(logFile));
            Log.init(ELogLevel.ALL);

            Log.d("App: " + DeviceUtils.getVersionName(packageName) + " (" + DeviceUtils.getCodeVersion(packageName) + ")");
            Log.d("Device: " + DeviceUtils.getDeviceName() + " (Android " + Build.VERSION.RELEASE + ")");
            Log.d("Architecture: " + System.getProperty("os.arch"));
        } else {
            Log.init(ELogLevel.DISABLED);
        }
    }

    public String getCacheDirectory() {
        try {
            String path = null;
            if (FileUtils.isExternalStorageAvaliable()) {
                return ContextCompat.getExternalFilesDirs(LibCore.getApplicationContext(), null)[0].getAbsolutePath();
            } else if (FileUtils.isInternalStorageAvaliable()) {
                path = LibCore.getApplicationContext().getFilesDir().getAbsolutePath();
            }
            return FileUtils.createDirectory(path);
        } catch (Exception ex) {
            Log.e("BankAdvisorApp::getDocumentCache: ", ex);
        }
        return "";
    }

    public byte[] getPublicKey() {
        try {
            InputStream inputStream = getResources().openRawResource(
                    getResources().getIdentifier("publickey",
                            "raw", getPackageName()));
            byte[] key = new byte[162];
            inputStream.read(key);
            inputStream.close();
            return key;
        } catch (Exception ex) {
            Log.e("BankAdviserApp: getPublicKey: ", ex);
            return null;
        }
    }

    public static void analizeError() {
        String preferencesEnvironment = SessionManager.getInstance().getLastEnviromentSwitch();
        if (preferencesEnvironment.isEmpty()) {
            BankAdvisorApp.getInstance().setEnvironment(Environment.DRP);
            SessionManager.getInstance().saveLastEnviromentSwitch(Environment.DRP);
        } else {
            if (preferencesEnvironment.equalsIgnoreCase(String.valueOf(Environment.DRP))) {
                BankAdvisorApp.getInstance().setEnvironment(Environment.PROD);
                SessionManager.getInstance().saveLastEnviromentSwitch(Environment.PROD);
            } else {
                BankAdvisorApp.getInstance().setEnvironment(Environment.DRP);
                SessionManager.getInstance().saveLastEnviromentSwitch(Environment.DRP);
            }
        }
    }
}
