package com.cobis.gestionasesores.presentation.solidaritypayment;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.TaskRepository;
import com.cobis.gestionasesores.domain.usecases.GetSolidarityPaymentUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSolidarityPaymentUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class SolidarityPaymentActivity extends BaseActivity {

    private static final String EXTRA_SOLIDARITY_PAYMENT_ID = "com.cobis.gestionasesores.extras.extra_solidarity_payment_id";

    public static Intent newIntent(Context context, int solidarityPaymentId) {
        Intent intent = new Intent(context, SolidarityPaymentActivity.class);
        intent.putExtra(EXTRA_SOLIDARITY_PAYMENT_ID, solidarityPaymentId);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_solidarity_payment);

        SolidarityPaymentFragment fragment = (SolidarityPaymentFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (fragment == null) {
            fragment = SolidarityPaymentFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }

        new SolidarityPaymentPresenter(fragment,
                getIntent().getIntExtra(EXTRA_SOLIDARITY_PAYMENT_ID, -1),
                new GetSolidarityPaymentUseCase(TaskRepository.getInstance()),
                new SaveSolidarityPaymentUseCase(TaskRepository.getInstance()));
    }
}
