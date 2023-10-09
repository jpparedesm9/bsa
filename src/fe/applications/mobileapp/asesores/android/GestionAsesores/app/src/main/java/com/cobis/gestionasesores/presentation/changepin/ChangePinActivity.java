package com.cobis.gestionasesores.presentation.changepin;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.domain.usecases.RegisterPinUseCase;
import com.cobis.gestionasesores.domain.usecases.ValidatePinUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class ChangePinActivity extends BaseActivity {

    ChangePinContract.Presenter mPresenter;

    public static Intent newIntent(Context context){
        Intent intent = new Intent(context,ChangePinActivity.class);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_change_pin);
        ChangePinFragment fragment = (ChangePinFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if(fragment == null){
            fragment = ChangePinFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }
        mPresenter = new ChangePinPresenter(fragment,new ValidatePinUseCase(), new RegisterPinUseCase());
    }
}
