package com.cobis.gestionasesores.presentation.people;


import android.app.SearchManager;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.support.v4.view.MenuItemCompat;
import android.support.v4.view.ViewCompat;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SearchView;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.OvershootInterpolator;
import android.widget.AdapterView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.SingleItem;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.TitleAdapter;
import com.cobis.gestionasesores.presentation.person.PersonActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PeopleFragment extends Fragment implements PeopleContract.View, PeopleAdapter.OnItemClickListener, SearchView.OnQueryTextListener, AdapterView.OnItemSelectedListener {
    @BindView(R.id.view_empty)
    View mEmptyView;
    @BindView(R.id.text_empty)
    TextView mEmptyText;
    @BindView(R.id.text_empty_add)
    TextView mEmptyAddText;

    @BindView(R.id.prospect_layout)
    View mProspectLayout;
    @BindView(R.id.customer_layout)
    View mCusLayout;
    @BindView(R.id.fab_add)
    FloatingActionButton mAddActionButton;
    @BindView(R.id.fab_prospect)
    FloatingActionButton mProspectActionButton;
    @BindView(R.id.fab_customer)
    FloatingActionButton mCustomerActionButton;

    @BindView(R.id.list_customers)
    RecyclerView mListPeople;
    @BindView(R.id.swipe_refresh_layout)
    SwipeRefreshLayout mSwipeRefreshLayout;

    private Animation fabOpenAnimation;
    private Animation fabCloseAnimation;
    private boolean isFabMenuOpen = false;
    private PeopleContract.Presenter mPresenter;
    private PeopleAdapter mAdapter;
    private MenuItem mSearchMenuItem;
    private TitleAdapter mFilterAdapter;

    public static PeopleFragment newInstance() {
        Bundle args = new Bundle();
        PeopleFragment fragment = new PeopleFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
        getAnimations();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_people, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mAdapter = new PeopleAdapter(new ArrayList<Person>(0), this);
        mListPeople.setAdapter(mAdapter);
        mListPeople.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mListPeople.setLayoutManager(new LinearLayoutManager(getContext()));

        //setup toolbar
        Toolbar toolbar = ((BaseActivity) getActivity()).getToolbar();
        if (toolbar != null) {
            Spinner filterSpinner = (Spinner) toolbar.findViewById(R.id.spinner_nav);
            List<SingleItem> options = new ArrayList<>();
            options.add(new SingleItem(String.valueOf(PersonType.UNKNOWN), getString(R.string.people_nav_all)));
            options.add(new SingleItem(String.valueOf(PersonType.CUSTOMER), getString(R.string.people_nav_customers)));
            options.add(new SingleItem(String.valueOf(PersonType.PROSPECT), getString(R.string.people_nav_prospects)));

            mFilterAdapter = new TitleAdapter(getContext(), R.string.people_title, options);
            filterSpinner.setAdapter(mFilterAdapter);
            filterSpinner.setSelection(0, false);
            filterSpinner.setOnItemSelectedListener(this);
        }

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
        searchView.setQueryHint(getString(R.string.people_hint_search));
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

    @OnClick(R.id.fab_add)
    public void onClickAdd(View view) {
        if (isFabMenuOpen) {
            collapseFabMenu();
        } else {
            expandFabMenu();
        }
    }

    @OnClick({R.id.fab_prospect, R.id.label_prospect,R.id.fab_add_prospect})
    public void onClickAddProspect(View view) {
        collapseFabMenu();
        startActivity(PersonActivity.newIntent(getContext(), -1, PersonType.PROSPECT));
    }

    @OnClick({R.id.fab_customer, R.id.label_customer})
    public void onClickAddCustomer(View view) {
        collapseFabMenu();
        startActivity(PersonActivity.newIntent(getContext(), -1, PersonType.CUSTOMER));
    }

    @Override
    public void setPresenter(PeopleContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showNoResultsFound() {
        showNoPeopleView(getString(R.string.search_result_empty_msg));
    }

    @Override
    public void showPeopleEmpty() {
        showNoPeopleView(getString(R.string.people_msg_empty));
    }

    @Override
    public void showPeople(List<Person> people) {
        mAdapter.replace(people);
        mListPeople.setVisibility(View.VISIBLE);
        mEmptyView.setVisibility(View.GONE);
    }

    @Override
    public void showLoadPeopleError() {
        Toast.makeText(getContext(), R.string.people_error_load_customers, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showSearchError() {
        Toast.makeText(getContext(), R.string.people_error_load_customers, Toast.LENGTH_SHORT).show();
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
    public void startPersonActivity(Person person) {
        startActivity(PersonActivity.newIntent(getContext(), person.getId(), person.getType()));
    }

    @Override
    public void onItemClick(Person item) {
        mPresenter.onPersonSelected(item);
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

    private void getAnimations() {
        fabOpenAnimation = AnimationUtils.loadAnimation(getContext(), R.anim.fab_open);
        fabCloseAnimation = AnimationUtils.loadAnimation(getContext(), R.anim.fab_close);
    }

    private void expandFabMenu() {
        ViewCompat.animate(mAddActionButton).rotation(45.0F).withLayer().setDuration(300).setInterpolator(new OvershootInterpolator(10.0F)).start();
        mCusLayout.startAnimation(fabOpenAnimation);
        mProspectLayout.startAnimation(fabOpenAnimation);
        mCustomerActionButton.setClickable(true);
        mProspectActionButton.setClickable(true);
        isFabMenuOpen = true;
    }

    private void collapseFabMenu() {
        ViewCompat.animate(mAddActionButton).rotation(0.0F).withLayer().setDuration(300).setInterpolator(new OvershootInterpolator(10.0F)).start();
        mCusLayout.startAnimation(fabCloseAnimation);
        mProspectLayout.startAnimation(fabCloseAnimation);
        mCustomerActionButton.setClickable(false);
        mProspectActionButton.setClickable(false);
        isFabMenuOpen = false;
    }

    private void showNoPeopleView(String message) {
        mListPeople.setVisibility(View.GONE);
        mEmptyView.setVisibility(View.VISIBLE);
        mEmptyText.setText(message);
    }

    private SwipeRefreshLayout.OnRefreshListener mOnRefreshListener = new SwipeRefreshLayout.OnRefreshListener() {
        @Override
        public void onRefresh() {
            mPresenter.onRefresh();
        }
    };


    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        mPresenter.onTypeChange(Integer.valueOf(mFilterAdapter.getItem(position).getCode()));

    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {
    }
}