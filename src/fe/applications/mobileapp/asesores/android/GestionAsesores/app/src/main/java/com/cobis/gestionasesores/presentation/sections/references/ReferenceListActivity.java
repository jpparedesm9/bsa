package com.cobis.gestionasesores.presentation.sections.references;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 09/06/2017.
 */

public class ReferenceListActivity extends BaseActivity {
    public static final String EXTRA_SECTION = "com.cobis.gestionasesores.extras.REFERENCES";
    public static final String EXTRA_PERSON_ID = "com.cobis.gestionasesores.extras.PERSON_ID";

    private ReferenceListContract.Presenter mPresenter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reference_list);

        ReferenceListFragment fragment = (ReferenceListFragment) getSupportFragmentManager().findFragmentById(R.id.content_list);
        if(fragment == null){
            fragment = ReferenceListFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_list,fragment).commit();
        }
        mPresenter = new ReferenceListPresenter(fragment,
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                (Section) getIntent().getSerializableExtra(EXTRA_SECTION),
                new GetSectionDataUseCase(PersonRepository.getInstance()));
    }

    public static Intent newIntent(Context context,int personId,Section section) {
        Intent intent = new Intent(context, ReferenceListActivity.class);
        intent.putExtra(EXTRA_PERSON_ID,personId);
        intent.putExtra(EXTRA_SECTION,section);
        return intent;
    }

    public void onBackPressed() {
        mPresenter.onTryToExit();
    }

}
