package com.cobis.tuiiob2c.presentation.otpVerification;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;

public class OtpVerificationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_otp_verification);

        OtpVerificationFragment optFragment = (OtpVerificationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (optFragment == null) {
            optFragment = OtpVerificationFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, optFragment).commit();
        }
    }
}
