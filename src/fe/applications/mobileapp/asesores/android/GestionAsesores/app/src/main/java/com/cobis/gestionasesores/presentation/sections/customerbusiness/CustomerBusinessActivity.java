package com.cobis.gestionasesores.presentation.sections.customerbusiness;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 07/06/2017.
 */

public class CustomerBusinessActivity extends BaseActivity {
    public static final String EXTRA_SECTION = "com.cobis.gestionasesores.extras.SECTION ";
    public static final String EXTRA_PERSON_ID= "com.cobis.gestionasesores.extras.PERSON_ID";
    public static final String EXTRA_OPTIONAL_ADDRESS = "com.cobis.gestionasesores.extras.OPTIONAL_ADDRESS";

    public static Intent newIntent(Context context,int personId,Section section, AddressData optionalAddress) {
        Intent intent = new Intent(context, CustomerBusinessActivity.class);
        intent.putExtra(EXTRA_PERSON_ID, personId);
        intent.putExtra(EXTRA_SECTION, section);
        intent.putExtra(EXTRA_OPTIONAL_ADDRESS, optionalAddress);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_customer_business);
        CustomerBusinessFragment fragment = (CustomerBusinessFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = CustomerBusinessFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new CustomerBusinessPresenter(fragment,
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                (Section) getIntent().getSerializableExtra(EXTRA_SECTION),
                (AddressData) getIntent().getSerializableExtra(EXTRA_OPTIONAL_ADDRESS),
                new GetSectionDataUseCase(PersonRepository.getInstance()),
                new SaveSectionUseCase(PersonRepository.getInstance()),
                new GetAddressNameUseCase(PostalCodeRepository.getInstance())
                 );
    }
}
