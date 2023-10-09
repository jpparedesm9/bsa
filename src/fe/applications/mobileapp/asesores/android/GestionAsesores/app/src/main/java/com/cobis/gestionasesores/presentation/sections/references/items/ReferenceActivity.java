package com.cobis.gestionasesores.presentation.sections.references.items;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.SaveReferenceUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

import java.io.Serializable;
import java.util.List;

public class ReferenceActivity extends BaseActivity {
    public static final String EXTRA_PERSON_ID= "PERSON_ID";
    public static final String EXTRA_REFERENCE = "REFERENCE";
    public static final String EXTRA_REFERENCE_LIST = "LIST";


    public static Intent newIntent(Context context, int personId, Reference reference, List<Reference> referenceList){
        Intent intent = new Intent(context,ReferenceActivity.class);
        intent.putExtra(EXTRA_PERSON_ID,personId);
        intent.putExtra(EXTRA_REFERENCE,reference);
        intent.putExtra(EXTRA_REFERENCE_LIST, (Serializable) referenceList);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reference);
        ReferenceFragment fragment = (ReferenceFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if(fragment == null){
            fragment = ReferenceFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment,fragment).commit();
        }
        new ReferencePresenter(fragment,
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                (Reference) getIntent().getSerializableExtra(EXTRA_REFERENCE),
                (List<Reference>) getIntent().getSerializableExtra(EXTRA_REFERENCE_LIST),
                new SaveReferenceUseCase(PersonRepository.getInstance()));
    }
}
