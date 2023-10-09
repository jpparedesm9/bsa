package com.cobis.tuiiob2c.presentation;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.cobis.tuiiob2c.BuildConfig;
import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.infraestructure.InactivityManager;
import com.cobis.tuiiob2c.infraestructure.KManager;
import com.cobis.tuiiob2c.presentation.splash.SplashActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.utils.TamperingProtection;

/**
 * Abstract activity for global application settings
 * Created by mnaunay on 04/06/2017.
 */

public abstract class BaseActivity extends AppCompatActivity implements InactivityManager.InactivityListener{
    private Toolbar mToolbar;

    @Override
    protected void onResume() {
        super.onResume();
        TamperingProtection protectionBuilder = new TamperingProtection.Builder(this, KManager.getInstance().getAppSignature())
                .setReleaseOnly(!BuildConfig.DEBUG)
                .setValidateSignature(BuildConfig.STORE)
                .installOnlyFromPlayStore(BuildConfig.STORE)
                .build();
        if(!protectionBuilder.validate()){
            Log.e("Invalid Application :-(");
            super.finishAndRemoveTask();
            System.exit(0);
        }

        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).registerReceiver(authBroadcastReceiver, new IntentFilter(App.ACTION_AUTH_LOGOUT));
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).registerReceiver(restartAppBroadcastReceiver, new IntentFilter(App.ACTION_RESTART_APP));

        /*if (isSessionRequired()) {
            startActivity(SplashActivity.newIntent(this));

            if (InactivityManager.getInstance().isInactive()) {
                showInactiveDialog();
            }
            InactivityManager.getInstance().register(this);
            InactivityManager.getInstance().start();
        }*/
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (isSessionRequired()) {
            InactivityManager.getInstance().unregister();
        }
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).unregisterReceiver(authBroadcastReceiver);
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).unregisterReceiver(restartAppBroadcastReceiver);
        if (isSessionRequired()) {
            InactivityManager.getInstance().unregister();
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setContentView(int layoutResId) {
        super.setContentView(layoutResId);
        setupToolbar();
    }

    @Override
    public void onInactive() {
        runOnUiThread(this::showInactiveDialog);
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return true;
    }

    @Override
    public void onUserInteraction() {
        super.onUserInteraction();
        if(isSessionRequired()){
           InactivityManager.getInstance().start();
        }
    }

    protected void setupToolbar() {
        if (findViewById(R.id.toolbar) != null) {
            mToolbar = (Toolbar) findViewById(R.id.toolbar);
            setSupportActionBar(mToolbar);
            setupActionBar();
        }
    }

    protected ActionBar setupActionBar() {
        final ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
        }
        return actionBar;
    }

    public Toolbar getToolbar() {
        return mToolbar;
    }

    protected boolean isSessionRequired() {
        return true;
    }


    private void showInactiveDialog(){
        new AlertDialog.Builder(BaseActivity.this)
                .setTitle(R.string.session_inactive_title)
                .setMessage(R.string.session_inactive_message)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .setOnDismissListener(dialogInterface -> startActivity(SplashActivity.newIntent(BaseActivity.this)))
                .show();
    }

    protected BroadcastReceiver authBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            new AlertDialog.Builder(BaseActivity.this)
                    .setTitle(R.string.session_expired_title)
                    .setMessage(R.string.session_expired_message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, null)
                    .setOnDismissListener(new DialogInterface.OnDismissListener() {
                        @Override
                        public void onDismiss(DialogInterface dialogInterface) {
                            startActivity(SplashActivity.newIntent(BaseActivity.this));
                        }
                    })
                    .show();
        }
    };

    protected BroadcastReceiver restartAppBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            new AlertDialog.Builder(BaseActivity.this)
                    .setTitle(R.string.app_name)
                    .setMessage(R.string.error_service_connect)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, null)
                    .setOnDismissListener(dialogInterface -> {
                        startActivity(SplashActivity.newIntent(BaseActivity.this));
                    })
                    .show();
        }
    };
}


