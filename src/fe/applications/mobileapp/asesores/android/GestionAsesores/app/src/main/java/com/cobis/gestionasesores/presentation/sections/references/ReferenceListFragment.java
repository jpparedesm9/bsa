package com.cobis.gestionasesores.presentation.sections.references;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.presentation.sections.references.items.ReferenceActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ReferenceListFragment extends SectionFragment implements ReferencesAdapter.OnItemClickListener, ReferenceListContract.View {
    private static final int REQUEST_REFERENCE = 1;

    @BindView(R.id.list_references)
    RecyclerView mReferencesList;
    @BindView(R.id.action_button_add)
    FloatingActionButton mAddButton;
    @BindView(R.id.label_caption)
    TextView mCaptionTextView;

    private ReferencesAdapter mReferencesAdapter;
    private ReferenceListContract.Presenter mPresenter;

    public static ReferenceListFragment newInstance() {
        Bundle args = new Bundle();
        ReferenceListFragment fragment = new ReferenceListFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mReferencesAdapter = new ReferencesAdapter(new ArrayList<Reference>(0), this);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_reference_list, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mReferencesList.setAdapter(mReferencesAdapter);
        mReferencesList.setLayoutManager(new LinearLayoutManager(getContext()));
        mReferencesList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mReferencesList.setHasFixedSize(true);
        mPresenter.start();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_REFERENCE && resultCode == Activity.RESULT_OK) {
            mPresenter.updateReferences();
        }
    }

    @OnClick(R.id.action_button_add)
    public void onNewReferenceClick(View view) {
        mPresenter.onAddNewReference();
    }

    @Override
    public void onItemClick(int position, Reference reference) {
        mPresenter.onEditReference(reference);
    }

    @Override
    public void setPresenter(ReferenceListContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showReferences(List<Reference> references) {
        mReferencesAdapter.replaceAll(references);
    }

    @Override
    public void startReference(int personId, Reference reference, List<Reference> referenceList) {
        startActivityForResult(ReferenceActivity.newIntent(getContext(), personId, reference, referenceList), REQUEST_REFERENCE);
    }

    @Override
    public void sendResult(Section section) {
        Intent intent = new Intent();
        intent.putExtra(ReferenceListActivity.EXTRA_SECTION, section);
        getActivity().setResult(Activity.RESULT_OK, intent);
        getActivity().finish();
    }

    @Override
    public void showCaption(int maxReferences) {
        mCaptionTextView.setText(getString(R.string.references_caption, maxReferences));
    }

    @Override
    public void showButtonAdd(boolean visible) {
        mAddButton.setVisibility(visible ? View.VISIBLE : View.GONE);
    }
}
