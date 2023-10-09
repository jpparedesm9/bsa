package com.cobis.gestionasesores.presentation.sections.documents.items;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.repositories.DocumentRepository;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.DeleteDocumentUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveDocumentUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 14/06/2017.
 */

public class DocumentActivity extends BaseActivity{
    public static final String EXTRA_PERSON_ID = "PERSON_ID";
    public static final String EXTRA_DOCUMENT_TYPE = "DOCUMENT_TYPE";
    public static final String EXTRA_DOCUMENTS = "DOCUMENTS";

    public static Intent newIntent(Context context,int personId,String type,DocumentsData data){
        Intent intent = new Intent(context,DocumentActivity.class);
        intent.putExtra(EXTRA_DOCUMENTS,data);
        intent.putExtra(EXTRA_DOCUMENT_TYPE,type);
        intent.putExtra(EXTRA_PERSON_ID,personId);
        return  intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_document);

        DocumentFragment fragment = (DocumentFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if(fragment == null){
            fragment = DocumentFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment,fragment).commit();
        }
        new DocumentPresenter(fragment,
                getIntent().getIntExtra(EXTRA_PERSON_ID,-1),
                (DocumentsData) getIntent().getSerializableExtra(EXTRA_DOCUMENTS),
                getIntent().getStringExtra(EXTRA_DOCUMENT_TYPE),
                new SaveDocumentUseCase(DocumentRepository.getInstance(), PersonRepository.getInstance()),
                new DeleteDocumentUseCase(PersonRepository.getInstance()));
    }
}
