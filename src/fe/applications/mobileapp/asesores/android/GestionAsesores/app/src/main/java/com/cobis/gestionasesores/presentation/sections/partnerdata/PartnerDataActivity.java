package com.cobis.gestionasesores.presentation.sections.partnerdata;

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
 * Created by bqtdesa02 on 6/8/2017.
 */

public class PartnerDataActivity extends BaseActivity {
    public static final String EXTRA_SECTION = "com.cobis.gestionasesores.extras.SECTION ";
    public static final String EXTRA_PERSON_ID = "com.cobis.gestionasesores.extras.PERSON_ID";

    public static Intent newIntent(Context context,int personId, Section section) {
        Intent intent = new Intent(context, PartnerDataActivity.class);
        intent.putExtra(EXTRA_PERSON_ID, personId);
        intent.putExtra(EXTRA_SECTION, section);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_partner_data);

        PartnerDataFragment fragment = (PartnerDataFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);

        if (fragment == null) {
            fragment = PartnerDataFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new PartnerDataPresenter(fragment,
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                (Section) getIntent().getSerializableExtra(EXTRA_SECTION),
                new GetSectionDataUseCase(PersonRepository.getInstance()),
                new SaveSectionUseCase(PersonRepository.getInstance()));
    }
}
