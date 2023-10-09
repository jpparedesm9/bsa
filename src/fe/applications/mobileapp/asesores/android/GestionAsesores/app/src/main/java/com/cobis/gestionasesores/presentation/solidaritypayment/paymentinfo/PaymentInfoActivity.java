package com.cobis.gestionasesores.presentation.solidaritypayment.paymentinfo;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 8/22/2017.
 */

public class PaymentInfoActivity extends BaseActivity {

    private static final String EXTRA_SOLIDARITY_PAYMENT = "com.cobis.gestionasesores.extras.extra_solidarity_payment";

    public static Intent newIntent(Context context, SolidarityPayment solidarityPayment){
        Intent intent = new Intent(context,PaymentInfoActivity.class);
        intent.putExtra(EXTRA_SOLIDARITY_PAYMENT, solidarityPayment);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment_info);

        PaymentInfoFragment fragment = (PaymentInfoFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if(fragment == null){
            fragment = PaymentInfoFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }

        new PaymentInfoPresenter(fragment, (SolidarityPayment) getIntent().getSerializableExtra(EXTRA_SOLIDARITY_PAYMENT));
    }
}
