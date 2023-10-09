package com.cobis.tuiiob2c.presentation.enrollment;

import android.os.Bundle;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.BaseActivity;

public class EnrollmentActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_enrollment);

        EnrollmentFragment enrollmentFragment = (EnrollmentFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (enrollmentFragment == null) {
            enrollmentFragment = EnrollmentFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, enrollmentFragment).commit();
        }
    }
}
