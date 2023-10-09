package com.cobis.tuiiob2c.presentation.createPassword;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.login.LoginFragment;

public class CreatePasswordActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_password);
        CreatePasswordFragment passwordFragment = (CreatePasswordFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (passwordFragment == null) {
            passwordFragment = CreatePasswordFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, passwordFragment).commit();
        }
    }
}
