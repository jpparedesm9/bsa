package com.cobis.gestionasesores.presentation.registerpin;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.domain.usecases.RegisterPinUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class RegisterPinActivity extends BaseActivity {

    public static Intent NewIntent(Context context){
        Intent intent = new Intent(context, RegisterPinActivity.class);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register_pin);

        RegisterPinFragment fragment = (RegisterPinFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if(fragment == null){
            fragment = RegisterPinFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }
        new RegisterPinPresenter(fragment, new RegisterPinUseCase());
    }

    //Prevent back from closing activity
    @Override
    public void onBackPressed() {

    }
}
