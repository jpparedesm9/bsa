package com.cobis.gestionasesores.presentation.address;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class UnitTestActivity extends BaseActivity {

    private static AddressData addressData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_unit_test);

    }

    public void onClickTest(View view){
        startActivityForResult(AddressActivity.newIntent(this,addressData),100);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            addressData = (AddressData) data.getSerializableExtra(AddressActivity.EXTRA_ADDRESS);
        }
    }
}
