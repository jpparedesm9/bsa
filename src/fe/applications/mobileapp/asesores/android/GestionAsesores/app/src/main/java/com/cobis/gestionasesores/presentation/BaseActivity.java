package com.cobis.gestionasesores.presentation;

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
import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.source.remote.ServiceBase;
import com.cobis.gestionasesores.infrastructure.InactivityManager;
import com.cobis.gestionasesores.infrastructure.KManager;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.presentation.launcher.LauncherActivity;
import com.cobis.gestionasesores.utils.TamperingProtection;

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
                .installOnlyFromPlayStore(BuildConfig.STORE)
                .build();
        if(!protectionBuilder.validate()){
            Log.e("Invalid Application :-(");
            super.finishAndRemoveTask();
            System.exit(0);
        }

        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).registerReceiver(authBroadcastReceiver, new IntentFilter(ServiceBase.ACTION_AUTH_LOGOUT));
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).registerReceiver(needAuthLoginBroadcastReceiver, new IntentFilter(ServiceBase.ACTION_AUTH_NEED_ONLINE));

        if (isSessionRequired()) {
            if(!SessionManager.getInstance().isSessionActive()) {
                startActivity(LauncherActivity.newIntent(this));
            }else if (InactivityManager.getInstance().isInactive()) {
                showInactiveDialog();
            }
            InactivityManager.getInstance().register(this);
            InactivityManager.getInstance().start();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).unregisterReceiver(authBroadcastReceiver);
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).unregisterReceiver(needAuthLoginBroadcastReceiver);
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

    @Override
    public void onInactive() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                showInactiveDialog();
            }
        });
    }

    private void showInactiveDialog(){
        new AlertDialog.Builder(BaseActivity.this)
                .setTitle(R.string.session_inactive_title)
                .setMessage(R.string.session_inactive_message)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .setOnDismissListener(new DialogInterface.OnDismissListener() {
                    @Override
                    public void onDismiss(DialogInterface dialogInterface) {
                        startActivity(LauncherActivity.newIntent(BaseActivity.this));
                    }
                })
                .show();
    }

    protected BroadcastReceiver authBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            SessionManager.getInstance().closeSession();
            new AlertDialog.Builder(BaseActivity.this)
                    .setTitle(R.string.session_expired_title)
                    .setMessage(R.string.session_expired_message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, null)
                    .setOnDismissListener(new DialogInterface.OnDismissListener() {
                        @Override
                        public void onDismiss(DialogInterface dialogInterface) {
                            startActivity(LauncherActivity.newIntent(BaseActivity.this));
                            finish();
                        }
                    })
                    .show();
        }
    };

    protected BroadcastReceiver needAuthLoginBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            SessionManager.getInstance().closeSession();
            new AlertDialog.Builder(BaseActivity.this)
                    .setTitle(R.string.app_name)
                    .setMessage(R.string.session_need_online)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, null)
                    .setOnDismissListener(new DialogInterface.OnDismissListener() {
                        @Override
                        public void onDismiss(DialogInterface dialogInterface) {
                            startActivity(LauncherActivity.newIntent(BaseActivity.this));
                            finish();
                        }
                    })
                    .show();
        }
    };
}


