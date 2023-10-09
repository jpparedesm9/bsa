package com.cobis.tuiiob2c.presentation.phoneValidation;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.cobis.tuiiob2c.R;

public class PhoneValidationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_phone_validation);

        PhoneValidationFragment phoneValidationFragment = (PhoneValidationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (phoneValidationFragment == null) {
            phoneValidationFragment = PhoneValidationFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, phoneValidationFragment).commit();
        }
    }
}
