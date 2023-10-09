package com.cobis.gestionasesores.presentation.registerdevice;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.ActionBar;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.RegisterDeviceRepository;
import com.cobis.gestionasesores.domain.usecases.RegisterDeviceUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class RegisterDeviceActivity extends BaseActivity {

    private RegisterDeviceContract.RegisterDevicePresenter mPresenter;

    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context, RegisterDeviceActivity.class);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register_device);

        RegisterDeviceFragment registerDeviceFragment = (RegisterDeviceFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (registerDeviceFragment == null) {
            registerDeviceFragment = RegisterDeviceFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, registerDeviceFragment).commit();
        }
        mPresenter = new RegisterDevicePresenter(registerDeviceFragment, new RegisterDeviceUseCase(RegisterDeviceRepository.getInstance()));
    }
    @Override
    protected ActionBar setupActionBar() {
        final ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(false);
        }
        return actionBar;
    }

    //Prevent back from closing activity
    @Override
    public void onBackPressed() {

    }
}
