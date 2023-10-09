package com.cobis.tuiiob2c.presentation.otpCreditVerification;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationFragment;

public class OtpCreditVerificationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_otp_credit_verification);

        OtpCreditVerificationFragment optFragment = (OtpCreditVerificationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (optFragment == null) {
            optFragment = OtpCreditVerificationFragment.newInstance();
            //optFragment.setValidationResponse(response);
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, optFragment).commit();
        }
    }
}
