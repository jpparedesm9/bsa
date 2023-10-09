package com.cobis.gestionasesores.presentation.customers;


import android.app.Activity;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.view.MenuItemCompat;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SearchView;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Person;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class CustomersFragment extends Fragment implements CustomersContract.View, CustomersAdapter.OnItemClickListener, SearchView.OnQueryTextListener {
    @BindView(R.id.view_empty)
    View mEmptyView;
    @BindView(R.id.text_empty)
    TextView mEmptyText;
    @BindView(R.id.list_customers)
    RecyclerView mListCustomers;
    @BindView(R.id.swipe_refresh_layout)
    SwipeRefreshLayout mSwipeRefreshLayout;

    private CustomersAdapter mAdapter;
    private MenuItem mSearchMenuItem;
    private CustomersContract.Presenter mPresenter;

    public static CustomersFragment newInstance() {
        Bundle args = new Bundle();
        CustomersFragment fragment = new CustomersFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_customers, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mAdapter = new CustomersAdapter(new ArrayList<Person>(0), this);
        mListCustomers.setAdapter(mAdapter);
        mListCustomers.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mListCustomers.setLayoutManager(new LinearLayoutManager(getContext()));

        mSwipeRefreshLayout.setOnRefreshListener(mOnRefreshListener);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_customers, menu);
        // Associate searchable configuration with the SearchView
        SearchManager searchManager =
                (SearchManager) getContext().getSystemService(Context.SEARCH_SERVICE);
        mSearchMenuItem = menu.findItem(R.id.menu_search_customers);
        SearchView searchView = (SearchView) mSearchMenuItem.getActionView();
        searchView.setQueryHint(getString(R.string.customers_hint_search));
        searchView.setSearchableInfo(
                searchManager.getSearchableInfo(getActivity().getComponentName()));
        searchView.setSubmitButtonEnabled(false);
        searchView.setOnQueryTextListener(this);
    }

    @Override
    public void onResume() {
        super.onResume();
        mPresenter.start();
    }

    @Override
    public void setPresenter(@NonNull CustomersContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showNoResultsFound() {
        showNoCustomersView(getString(R.string.search_result_empty_msg));
    }

    @Override
    public void showCustomersEmpty() {
        showNoCustomersView(getString(R.string.customers_msg_empty));
    }

    @Override
    public void showCustomers(List<Person> customers, int[] serverIds, int[] localIds) {
        mAdapter.setSelectedIds(serverIds, localIds);
        mAdapter.replace(customers);
        mListCustomers.setVisibility(View.VISIBLE);
        mEmptyView.setVisibility(View.GONE);
    }

    @Override
    public void showLoadCustomersError() {
        Toast.makeText(getContext(), R.string.customers_error_load_customers, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showLoadingIndicator() {
        if (!mSwipeRefreshLayout.isRefreshing()) {
            mSwipeRefreshLayout.setRefreshing(true);
        }
    }

    @Override
    public void hideLoadingIndicator() {
        mSwipeRefreshLayout.setRefreshing(false);
    }

    @Override
    public void clearSearch() {
        if (mSearchMenuItem != null) {
            MenuItemCompat.collapseActionView(mSearchMenuItem);
        }
    }

    @Override
    public void sendResult(Person customer) {
        Intent intent = new Intent();
        intent.putExtra(SelectCustomerActivity.EXTRA_CUSTOMER, customer);
        getActivity().setResult(Activity.RESULT_OK, intent);
        getActivity().finish();
    }

    @Override
    public void onItemClick(Person item) {
        mPresenter.onCustomerSelected(item);
    }

    @Override
    public boolean onQueryTextSubmit(String query) {
        return false;
    }

    @Override
    public boolean onQueryTextChange(String newText) {
        mPresenter.onSearchChange(newText);
        return true;
    }

    private void showNoCustomersView(String message) {
        mListCustomers.setVisibility(View.GONE);
        mEmptyView.setVisibility(View.VISIBLE);
        mEmptyText.setText(message);
    }

    private SwipeRefreshLayout.OnRefreshListener mOnRefreshListener = new SwipeRefreshLayout.OnRefreshListener() {
        @Override
        public void onRefresh() {
            mPresenter.onRefresh();
        }
    };
}