package com.cobis.gestionasesores.presentation.sections.prospectdata;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 6/28/2017.
 */

public class ProspectDataActivity extends BaseActivity {
    public static final String EXTRA_PROSPECT = "com.cobis.gestionasesores.extras.prospect";

    public static Intent newIntent(Context context, Person prospect) {
        Intent intent = new Intent(context, ProspectDataActivity.class);
        intent.putExtra(EXTRA_PROSPECT,prospect);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_prospect);

        ProspectDataFragment fragment = (ProspectDataFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if(fragment == null){
            fragment = ProspectDataFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,fragment).commit();
        }

        new ProspectDataPresenter(fragment, (Person) getIntent().getSerializableExtra(EXTRA_PROSPECT),
                new GetSectionDataUseCase(PersonRepository.getInstance()),
                new SaveSectionUseCase(PersonRepository.getInstance()),
                new GetAddressNameUseCase(PostalCodeRepository.getInstance()));
    }
}
