package com.cobis.tuiiob2c.presentation.splash;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.BuildConfig;
import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.infraestructure.InactivityManager;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.enrollment.EnrollmentActivity;
import com.cobis.tuiiob2c.presentation.login.LoginActivity;
import com.cobis.tuiiob2c.utils.EmulatorDetector;
import com.cobis.tuiiob2c.utils.RootDetector;

public class SplashActivity extends AppCompatActivity {

    private static final long LAUNCHER_DELAY = 1000L;

    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context, SplashActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        InactivityManager.getInstance().reset();
        if(!BuildConfig.DEBUG) {
            EmulatorDetector.with(this).detect(isEmulator -> runOnUiThread(() -> {
                if (isEmulator) {
                    showDeviceError(getString(R.string.error_emulator));
                } else if (RootDetector.isDeviceRooted()) {
                    showDeviceError(getString(R.string.error_root));
                } else {
                    startLogin();
                }
            }));
        } else {
            startLogin();
        }
    }

    private void showDeviceError(String error){
        new AlertDialog.Builder(this)
                .setTitle(getString(R.string.error_device_title, getString(R.string.app_name)))
                .setMessage(error)
                .setPositiveButton(R.string.action_accept, (dialogInterface, i) -> finish())
                .setCancelable(false)
                .show();
    }


    private void startLogin() {
        Handler handler = new Handler();
        handler.postDelayed(() -> {
            if (SessionManager.getInstance().getStatusEnrollment()) {
                Intent intent = new Intent(SplashActivity.this, LoginActivity.class);
                startActivity(intent);
            } else {
                Intent intent = new Intent(SplashActivity.this, EnrollmentActivity.class);
                startActivity(intent);
            }
            finish();
        },LAUNCHER_DELAY);
    }

}
