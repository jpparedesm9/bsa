package com.cobis.gestionasesores.presentation.login;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.AuthRepository;
import com.cobis.gestionasesores.domain.usecases.LoginUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Login Activity
 */
public class LoginActivity extends BaseActivity {
    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context,LoginActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        LoginFragment loginFragment = (LoginFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (loginFragment == null) {
            loginFragment = LoginFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, loginFragment).commit();
        }
        new LoginPresenter(loginFragment, new LoginUseCase(AuthRepository.getInstance()));
        getSupportActionBar().setDisplayHomeAsUpEnabled(false);
    }

    @Override
    protected boolean isSessionRequired() {
        return false;
    }
}