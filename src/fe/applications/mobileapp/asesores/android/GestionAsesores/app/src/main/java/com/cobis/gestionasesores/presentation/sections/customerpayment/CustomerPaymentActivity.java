package com.cobis.gestionasesores.presentation.sections.customerpayment;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 6/9/2017.
 */

public class CustomerPaymentActivity extends BaseActivity {
    public static final String EXTRA_SECTION = "com.cobis.gestionasesores.extras.SECTION";
    public static final String EXTRA_PERSON_ID = "com.cobis.gestionasesores.extras.PERSON_ID";
    public static final String EXTRA_OTHER_INCOME = "com.cobis.gestionasesores.extras.OTHER_INCOME";

    public static Intent newIntent(Context context,int personId,Section section, double otherIncome) {
        Intent intent = new Intent(context, CustomerPaymentActivity.class);
        intent.putExtra(EXTRA_SECTION, section);
        intent.putExtra(EXTRA_PERSON_ID, personId);
        intent.putExtra(EXTRA_OTHER_INCOME, otherIncome);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_customer_payment);

        CustomerPaymentFragment fragment = (CustomerPaymentFragment) getSupportFragmentManager()
                .findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = CustomerPaymentFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new CustomerPaymentPresenter(fragment,
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                (Section) getIntent().getSerializableExtra(EXTRA_SECTION),
                getIntent().getDoubleExtra(EXTRA_OTHER_INCOME,0),
                new GetSectionDataUseCase(PersonRepository.getInstance()),
                new SaveSectionUseCase(PersonRepository.getInstance()));
    }
}
