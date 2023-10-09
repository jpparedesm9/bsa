package com.cobis.gestionasesores.presentation.catalogsearch;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

import static android.view.View.GONE;

/**
 * Created by bqtdesa02 on 6/6/2017.
 */

public class CatalogSearchFragment extends DialogFragment implements CatalogSearchContract.CatalogSearchView, CatalogItemSearchAdapter.CatalogItemSearchListener {

    private static final String ARG_CATALOG_CODE = "arg_catalog_code";

    private CatalogSearchContract.CatalogSearchPresenter mPresenter;

    private CatalogItemSearchAdapter mAdapter;

    private OnCatalogItemSelectedListener mListener;

    @BindView(R.id.list_catalog_item)
    RecyclerView mCatalogItemList;
    @BindView(R.id.edit_text_keyword)
    EditText mKeywordEditText;
    @BindView(R.id.text_search_msg)
    TextView mSearchMsgText;
    @BindView(R.id.text_title)
    TextView mTitleText;

    public static CatalogSearchFragment newInstance(@Catalog int code) {
        Bundle args = new Bundle();
        args.putInt(ARG_CATALOG_CODE, code);
        CatalogSearchFragment fragment = new CatalogSearchFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        new CatalogSearchPresenter(this, getArguments().getInt(ARG_CATALOG_CODE));
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_catalog_search, container, false);
        ButterKnife.bind(this, rootView);

        mAdapter = new CatalogItemSearchAdapter(getContext(), this);

        mCatalogItemList.setLayoutManager(new LinearLayoutManager(getContext()));
        mCatalogItemList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mCatalogItemList.setAdapter(mAdapter);

        mKeywordEditText.addTextChangedListener(mOnKeywordChange);
        return rootView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mPresenter.start();
    }

    @Override
    public void onStart() {
        super.onStart();
        if (getDialog().getWindow() != null) {
            getDialog().getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        }
    }

    private TextWatcher mOnKeywordChange = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
        }

        @Override
        public void afterTextChanged(Editable s) {
            mPresenter.onKeywordChange(s.toString());
        }
    };

    @Override
    public void setPresenter(CatalogSearchContract.CatalogSearchPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showNoResultsFound() {
        mSearchMsgText.setVisibility(View.VISIBLE);
        mCatalogItemList.setVisibility(GONE);

        mSearchMsgText.setText(R.string.search_catalog_no_results_msg);
    }

    @Override
    public void showResults(List<CatalogItem> results) {
        mSearchMsgText.setVisibility(GONE);
        mCatalogItemList.setVisibility(View.VISIBLE);

        mAdapter.setCatalogItems(results);
    }

    @Override
    public void showSearchError() {
        mSearchMsgText.setVisibility(View.VISIBLE);
        mCatalogItemList.setVisibility(GONE);

        mSearchMsgText.setText(R.string.search_catalog_error_search_msg);
    }

    @Override
    public void showTitle(@Catalog int code) {
        mTitleText.setText(ResourcesUtil.getCatalogName(code));
    }

    @Override
    public void clearResults() {
        mAdapter.clear();
    }

    @Override
    public void onClickItem(CatalogItem catalogItem) {
        if(mListener != null){
            mListener.onItemSelected(catalogItem);
        }
    }

    public void setListener(OnCatalogItemSelectedListener listener) {
        mListener = listener;
    }

    public interface OnCatalogItemSelectedListener{
        void onItemSelected(CatalogItem item);
    }
}
