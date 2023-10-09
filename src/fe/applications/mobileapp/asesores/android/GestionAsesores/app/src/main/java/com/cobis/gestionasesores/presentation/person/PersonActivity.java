package com.cobis.gestionasesores.presentation.person;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.ConvertToCustomerUserCase;
import com.cobis.gestionasesores.domain.usecases.GetPersonUseCase;
import com.cobis.gestionasesores.domain.usecases.ValidateProspectUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class PersonActivity extends BaseActivity {
    public static final String EXTRA_PERSON_ID = "PERSON_ID";
    private static final String EXTRA_PERSON_TYPE = "EXTRA_PERSON_TYPE";

    public static Intent newIntent(Context context, int personId, @PersonType int personType) {
        Intent intent = new Intent(context, PersonActivity.class);
        intent.putExtra(EXTRA_PERSON_ID, personId);
        intent.putExtra(EXTRA_PERSON_TYPE, personType);
        return intent;
    }

    public static Intent newIntent(int personId){
        Intent intent = new Intent();
        intent.putExtra(EXTRA_PERSON_ID, personId);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_person);
        PersonFragment fragment = (PersonFragment) getSupportFragmentManager().findFragmentById(R.id.content_list);
        if(fragment == null) {
            fragment = PersonFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_list, fragment).commit();
        }
        int personId = getIntent().getIntExtra(EXTRA_PERSON_ID, -1);
        int personType = getIntent().getIntExtra(EXTRA_PERSON_TYPE, -1);
        new PersonPresenter(personId,
                personType,
                fragment,
                new ConvertToCustomerUserCase(PersonRepository.getInstance()),
                new ValidateProspectUseCase(),
                new GetPersonUseCase(PersonRepository.getInstance()));
    }
}
