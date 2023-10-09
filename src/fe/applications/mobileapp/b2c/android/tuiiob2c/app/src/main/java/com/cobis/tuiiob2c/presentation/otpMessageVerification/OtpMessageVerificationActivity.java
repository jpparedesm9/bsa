package com.cobis.tuiiob2c.presentation.otpMessageVerification;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.mainActivity.notifications.NotificationsFragment;
import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationFragment;

public class OtpMessageVerificationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_otp_verification);
        OtpMessageVerificationFragment optFragment = (OtpMessageVerificationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (optFragment == null) {
            optFragment = OtpMessageVerificationFragment.newInstance();
            optFragment.setanswer(getIntent().getStringExtra(NotificationsFragment.ANSWER));
            optFragment.setNotificationId(getIntent().getStringExtra(NotificationsFragment.NOTIFICATION_ID));
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, optFragment).commit();
        }
    }
}
