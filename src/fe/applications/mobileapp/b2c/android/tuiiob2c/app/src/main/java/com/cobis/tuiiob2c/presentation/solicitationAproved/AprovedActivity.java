package com.cobis.tuiiob2c.presentation.solicitationAproved;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;

public class AprovedActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_aproved);
        AprovedFragment passwordFragment = (AprovedFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (passwordFragment == null) {
            passwordFragment = AprovedFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, passwordFragment).commit();
        }
    }
}
