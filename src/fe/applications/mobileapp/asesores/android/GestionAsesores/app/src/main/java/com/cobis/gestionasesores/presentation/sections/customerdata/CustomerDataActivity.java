package com.cobis.gestionasesores.presentation.sections.customerdata;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 6/5/2017.
 */

public class CustomerDataActivity extends BaseActivity {
    public static final String EXTRA_CUSTOMER    = "com.cobis.gestionasesores.extras.customer";

    public static Intent newIntent(Context context, Person customer) {
        Intent intent = new Intent(context, CustomerDataActivity.class);
        intent.putExtra(EXTRA_CUSTOMER, customer);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_customer_data);
        CustomerDataFragment fragment = (CustomerDataFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = CustomerDataFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new CustomerDataPresenter(fragment,
                (Person) getIntent().getSerializableExtra(EXTRA_CUSTOMER),
                new GetSectionDataUseCase(PersonRepository.getInstance()),
                new SaveSectionUseCase(PersonRepository.getInstance()));
    }
}