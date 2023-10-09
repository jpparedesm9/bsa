package com.cobis.tuiiob2c.presentation.resetPassword;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.createPassword.CreatePasswordFragment;

public class ResetPasswordActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reset_password);
        ResetPasswordFragment passwordFragment = (ResetPasswordFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (passwordFragment == null) {
            passwordFragment = ResetPasswordFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, passwordFragment).commit();
        }
    }

    @Override
    public void onBackPressed() {

    }
}
