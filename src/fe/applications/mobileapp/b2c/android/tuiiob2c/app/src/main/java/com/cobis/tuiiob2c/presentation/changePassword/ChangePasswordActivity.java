package com.cobis.tuiiob2c.presentation.changePassword;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;

public class ChangePasswordActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_change_password);
        ChangePasswordFragment passwordFragment = (ChangePasswordFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (passwordFragment == null) {
            passwordFragment = ChangePasswordFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, passwordFragment).commit();
        }
    }
}
