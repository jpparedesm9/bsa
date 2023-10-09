package com.cobis.tuiiob2c.presentation.unlock;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.forgotPassword.ForgotPasswordFragment;

public class UnlockActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forgot_password);
        UnlockFragment unlockFragment = (UnlockFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (unlockFragment == null) {
            unlockFragment = UnlockFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, unlockFragment).commit();
        }
//        new LoginPresenter(loginFragment, new LoginUseCase(AuthRepository.getInstance()));

//        getSupportActionBar().setDisplayHomeAsUpEnabled(false);
    }
}
