package com.cobis.tuiiob2c.root;

import android.app.Application;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.ConsoleAppender;
import com.bayteq.libcore.logs.Log;
import com.cobis.tuiiob2c.B2CAdvisorConfig;
import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.modules.ChangePasswordModule;
import com.cobis.tuiiob2c.modules.CreatePasswordModule;
import com.cobis.tuiiob2c.modules.CreditSolicitationModule;
import com.cobis.tuiiob2c.modules.EnrollmentModule;
import com.cobis.tuiiob2c.modules.ForgotPasswordModule;
import com.cobis.tuiiob2c.modules.HomeModule;
import com.cobis.tuiiob2c.modules.LoginModule;
import com.cobis.tuiiob2c.modules.NotificationsModule;
import com.cobis.tuiiob2c.modules.OtpCreditVerificationModule;
import com.cobis.tuiiob2c.modules.OtpVerificationModule;
import com.cobis.tuiiob2c.modules.ResetPasswordModule;
import com.cobis.tuiiob2c.modules.SettingsModule;
import com.cobis.tuiiob2c.modules.UnlockModule;
import com.cobis.tuiiob2c.services.HttpApiModule;
import com.cobis.tuiiob2c.services.HttpAuthModule;

import java.io.InputStream;

public abstract class App extends Application {

    private ApplicationComponent component;
    private static App sInstance;
    private B2CAdvisorConfig mConfig;

    public static final String ACTION_AUTH_LOGOUT = "com.cobis.gestionasesores.auth.actions.LOGOUT";
   public static final String ACTION_RESTART_APP = "com.cobis.gestionasesores.auth.actions.RESTART_APP";

    @Override
    public void onCreate() {
        super.onCreate();

        sInstance = this;

        if(LibCore.getApplicationContext() == null) {
            LibCore.setApplicationContext(this);
            Log.addAppender(new ConsoleAppender());
            Log.init();
        }

        component = DaggerApplicationComponent.builder()
                .applicationModule(new ApplicationModule(this))
                .httpAuthModule(new HttpAuthModule())
                .httpApiModule(new HttpApiModule())
                .loginModule(new LoginModule())
                .enrollmentModule(new EnrollmentModule())
                .createPasswordModule(new CreatePasswordModule())
                .otpVerificationModule(new OtpVerificationModule())
                .forgotPasswordModule(new ForgotPasswordModule())
                .resetPasswordModule(new ResetPasswordModule())
                .changePasswordModule(new ChangePasswordModule())
                .creditSolicitationModule(new CreditSolicitationModule())
                .otpCreditVerificationModule(new OtpCreditVerificationModule())
                .homeModule(new HomeModule())
                .notificationsModule(new NotificationsModule())
                .settingsModule(new SettingsModule())
                .unlockModule(new UnlockModule())
                .build();

        SessionManager.setAppContext(this);

        mConfig = buildConfig();
    }

    public static App getInstance() {
        return sInstance;
    }

    public ApplicationComponent getComponent() {
        return component;
    }

    public synchronized B2CAdvisorConfig getConfig() {
        return mConfig;
    }

    public abstract B2CAdvisorConfig buildConfig();

    public void setEnvironment(Environment environment) {
        mConfig.setEnvironment(environment);
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
            App.getInstance().setEnvironment(Environment.DRP);
            SessionManager.getInstance().saveLastEnviromentSwitch(Environment.DRP);
        } else {
            if (preferencesEnvironment.equalsIgnoreCase(String.valueOf(Environment.DRP))) {
                App.getInstance().setEnvironment(Environment.PROD);
                SessionManager.getInstance().saveLastEnviromentSwitch(Environment.PROD);
            } else {
                App.getInstance().setEnvironment(Environment.DRP);
                SessionManager.getInstance().saveLastEnviromentSwitch(Environment.DRP);
            }
        }
        Intent error_services = new Intent(ACTION_RESTART_APP);
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).sendBroadcast(error_services);
    }
}
