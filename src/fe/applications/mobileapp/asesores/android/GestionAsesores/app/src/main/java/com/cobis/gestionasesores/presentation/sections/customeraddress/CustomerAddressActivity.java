package com.cobis.gestionasesores.presentation.sections.customeraddress;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class CustomerAddressActivity extends BaseActivity {
    public static final String EXTRA_SECTION = "com.cobis.gestionasesores.extras.SECTION";
    public static final String EXTRA_CUSTOMER_ID= "com.cobis.gestionasesores.extras.CUSTOMER_ID";

    public static Intent newIntent(Context context,int customerId, Section section) {
        Intent intent = new Intent(context, CustomerAddressActivity.class);
        intent.putExtra(EXTRA_SECTION, section);
        intent.putExtra(EXTRA_CUSTOMER_ID, customerId);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_customer_address);

        CustomerAddressFragment fragment = (CustomerAddressFragment) getSupportFragmentManager()
                .findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = CustomerAddressFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new CustomerAddressPresenter(fragment,
                getIntent().getIntExtra(EXTRA_CUSTOMER_ID,-1),
                (Section) getIntent().getSerializableExtra(EXTRA_SECTION),
                new GetSectionDataUseCase(PersonRepository.getInstance()),
                new SaveSectionUseCase(PersonRepository.getInstance()),
                new GetAddressNameUseCase(PostalCodeRepository.getInstance()));
    }
}
