package com.cobis.tuiiob2c.presentation.forgotPassword;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;

public class ForgotPasswordActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forgot_password);
        ForgotPasswordFragment forgotPasswordFragment = (ForgotPasswordFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (forgotPasswordFragment == null) {
            forgotPasswordFragment = ForgotPasswordFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, forgotPasswordFragment).commit();
        }
//        new LoginPresenter(loginFragment, new LoginUseCase(AuthRepository.getInstance()));

//        getSupportActionBar().setDisplayHomeAsUpEnabled(false);
    }
}
