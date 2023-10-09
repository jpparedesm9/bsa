package com.cobis.gestionasesores.presentation.sections.documents;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.DocumentRepository;
import com.cobis.gestionasesores.domain.usecases.GetDocumentsUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 14/06/2017.
 */

public class DocumentListActivity extends BaseActivity {
    public static final String EXTRA_SECTION = "section_documents";
    public static final String EXTRA_PERSON_ID = "personId";

    private DocumentListContract.Presenter mPresenter;

    public static Intent newIntent(Context context,Section section, int personId){
        Intent intent = new Intent(context,DocumentListActivity.class);
        intent.putExtra(DocumentListActivity.EXTRA_SECTION,section);
        intent.putExtra(DocumentListActivity.EXTRA_PERSON_ID,personId);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_document_list);

        DocumentListFragment fragment = (DocumentListFragment) getSupportFragmentManager().findFragmentById(R.id.content_list);
        if(fragment == null){
            fragment = DocumentListFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_list,fragment).commit();
        }

        mPresenter =  new DocumentListPresenter(fragment,
                (Section) getIntent().getSerializableExtra(EXTRA_SECTION),
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                new GetDocumentsUseCase(DocumentRepository.getInstance()));
    }

    @Override
    public void onBackPressed() {
        mPresenter.onTryToExit();
    }
}
