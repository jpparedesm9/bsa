package com.cobis.gestionasesores.presentation.sections.documents;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.presentation.person.PersonActivity;
import com.cobis.gestionasesores.presentation.sections.documents.items.DocumentActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class DocumentListFragment extends Fragment implements DocumentListContract.View, DocumentListAdapter.OnItemClickListener {
    private static final int REQUEST_CODE_DOCUMENT = 2;
    private DocumentListContract.Presenter mPresenter;

    private DocumentListAdapter mDocumentListAdapter;
    private ProgressDialog mProgressDialog;

    @BindView(R.id.list_documents)
    RecyclerView mDocumentRecyclerView;

    public static DocumentListFragment newInstance() {
        Bundle args = new Bundle();
        DocumentListFragment fragment = new DocumentListFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_document_list, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mDocumentRecyclerView.setLayoutManager(new GridLayoutManager(getContext(), 2));
        mDocumentListAdapter = new DocumentListAdapter(new ArrayList<Document>(0), this);
        mDocumentRecyclerView.setAdapter(mDocumentListAdapter);

        mPresenter.start();
    }

    @Override
    public void setPresenter(DocumentListContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showDocuments(List<Document> documents) {
        mDocumentListAdapter.updateAll(documents);
    }

    @Override
    public void startDocumentForm(int personId, @DocumentType String type, DocumentsData documents) {
        startActivityForResult(DocumentActivity.newIntent(getContext(), personId, type, documents), REQUEST_CODE_DOCUMENT);
    }

    @Override
    public void sendResult(int personId) {
        getActivity().setResult(Activity.RESULT_OK, PersonActivity.newIntent(personId));
        getActivity().finish();
    }

    @Override
    public void showLoadingProgress() {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(R.string.document_progress_getting));
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setCancelable(false);
            mProgressDialog.show();
        }
    }

    @Override
    public void hideLoadingProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showLoadingError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.document_error_loading)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE_DOCUMENT && resultCode == Activity.RESULT_OK) {
            mPresenter.onDocumentResultOk();
        }
    }

    @Override
    public void onItemClick(Document document) {
        mPresenter.onDocumentSelect(document);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
//        mPresenter.cleanUp();
    }
}
