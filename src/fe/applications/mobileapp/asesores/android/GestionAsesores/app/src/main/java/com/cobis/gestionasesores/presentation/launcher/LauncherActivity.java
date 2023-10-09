package com.cobis.gestionasesores.presentation.launcher;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AlertDialog;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.infrastructure.InactivityManager;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.login.LoginActivity;
import com.cobis.gestionasesores.presentation.loginoffline.LoginOfflineActivity;
import com.cobis.gestionasesores.utils.EmulatorDetector;
import com.cobis.gestionasesores.utils.RootDetector;

public class LauncherActivity extends BaseActivity {
    private static final long LAUNCHER_DELAY = 1000L;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_launcher);
        InactivityManager.getInstance().reset();
        if(!BuildConfig.DEBUG) {
            EmulatorDetector.with(this).detect(new EmulatorDetector.OnEmulatorDetectorListener() {
                @Override
                public void onResult(final boolean isEmulator) {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            if (isEmulator) {
                                showDeviceError(getString(R.string.error_emulator));
                            } else if (RootDetector.isDeviceRooted()) {
                                showDeviceError(getString(R.string.error_root));
                            } else {
                                startLogin();
                            }
                        }
                    });
                }
            });
        }else{
            startLogin();
        }
    }

    private void startLogin(){
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if(!NetworkUtils.isOnline() && SessionManager.getInstance().existPin()){
                    startActivity(LoginOfflineActivity.newIntent(getApplicationContext()));
                }
                else{
                    startActivity(LoginActivity.newIntent(getApplicationContext()));
                }
            }
        },LAUNCHER_DELAY);
    }

    private void showDeviceError(String error){
        new AlertDialog.Builder(this)
                .setTitle(getString(R.string.error_device_title, getString(R.string.app_name)))
                .setMessage(error)
                .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        finish();
                    }
                })
                .setCancelable(false)
                .show();
    }

    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context, LauncherActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        return intent;
    }

    @Override
    protected boolean isSessionRequired() {
        return false;
    }
}
