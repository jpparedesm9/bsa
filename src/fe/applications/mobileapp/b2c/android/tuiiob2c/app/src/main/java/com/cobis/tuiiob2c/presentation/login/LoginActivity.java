package com.cobis.tuiiob2c.presentation.login;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.BaseActivity;
import com.cobis.tuiiob2c.root.App;

public class LoginActivity extends BaseActivity {

    public static Intent newIntent(Context context, LoginActivity loginActivity){
        Intent intent = new Intent(context,LoginActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        LoginFragment loginFragment = (LoginFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (loginFragment == null) {
            loginFragment = LoginFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, loginFragment).commit();
        }
//        new LoginPresenter(loginFragment, new LoginUseCase(AuthRepository.getInstance()));

//        getSupportActionBar().setDisplayHomeAsUpEnabled(false);
    }

}
