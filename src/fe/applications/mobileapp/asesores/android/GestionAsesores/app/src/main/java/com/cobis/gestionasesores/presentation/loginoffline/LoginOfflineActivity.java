package com.cobis.gestionasesores.presentation.loginoffline;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.AuthRepository;
import com.cobis.gestionasesores.domain.usecases.LoginUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class LoginOfflineActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login_offline);
        LoginOfflineFragment fragment = (LoginOfflineFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if(fragment == null){
            fragment = LoginOfflineFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }
        new LoginOfflinePresenter(fragment, new LoginUseCase(AuthRepository.getInstance()));
    }

    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context, LoginOfflineActivity.class);
        return intent;
    }

    @Override
    public void onBackPressed() {}

    @Override
    protected boolean isSessionRequired() {
        return false;
    }
}
