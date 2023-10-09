package com.cobis.gestionasesores.presentation.applications;

import android.app.Activity;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
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

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.SingleItem;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.TitleAdapter;
import com.cobis.gestionasesores.presentation.customers.CustomersPresenter;
import com.cobis.gestionasesores.presentation.customers.SelectCustomerActivity;
import com.cobis.gestionasesores.presentation.groupcredit.GroupCreditActivity;
import com.cobis.gestionasesores.presentation.individualcredit.IndividualCreditActivity;
import com.cobis.gestionasesores.presentation.selectgroup.SelectGroupActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Credit Application request fragment
 * Created by bqtdesa02 on 6/22/2017.
 */
public class CreditAppFragment extends Fragment implements CreditAppContract.ApplicationsView, CreditAppAdapter.OnItemClickListener, SearchView.OnQueryTextListener, AdapterView.OnItemSelectedListener {
    private static final int REQUEST_GROUP = 1;
    private static final int REQUEST_CUSTOMER = 2;

    @BindView(R.id.individual_layout)
    View mIndividualLayout;
    @BindView(R.id.group_layout)
    View mGroupLayout;
    @BindView(R.id.fab_add)
    FloatingActionButton mAddActionButton;
    @BindView(R.id.fab_individual)
    FloatingActionButton mIndividualActionButton;
    @BindView(R.id.fab_group)
    FloatingActionButton mGroupActionButton;
    @BindView(R.id.list_apps)
    RecyclerView mAppsRecyclerView;
    @BindView(R.id.swipe_refresh_layout)
    SwipeRefreshLayout mSwipeRefreshLayout;
    @BindView(R.id.view_empty)
    View mEmptyView;
    @BindView(R.id.text_empty)
    TextView mEmptyText;
    @BindView(R.id.text_empty_add)
    TextView mEmptyAddText;
    @BindView(R.id.fab_blockscreen)
    View mFabBlockscreenView;

    private TitleAdapter mFilterAdapter;
    private CreditAppAdapter mAppAdapter;
    private CreditAppContract.ApplicationsPresenter mPresenter;
    private MenuItem mSearchMenuItem;
    private Animation fabOpenAnimation;
    private Animation fabCloseAnimation;
    private boolean isFabMenuOpen = false;
    private SwipeRefreshLayout.OnRefreshListener mOnRefreshListener = new SwipeRefreshLayout.OnRefreshListener() {
        @Override
        public void onRefresh() {
            mPresenter.onRefresh();
        }
    };

    public static CreditAppFragment newInstance() {
        Bundle args = new Bundle();
        CreditAppFragment fragment = new CreditAppFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
        getAnimations();
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_credit_apps, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mAppAdapter = new CreditAppAdapter(new ArrayList<CreditApp>(0), this);

        mAppsRecyclerView.setAdapter(mAppAdapter);
        mAppsRecyclerView.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mAppsRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        //setup toolbar
        Toolbar toolbar = ((BaseActivity) getActivity()).getToolbar();
        if (toolbar != null) {
            Spinner filterSpinner = (Spinner) toolbar.findViewById(R.id.spinner_nav);
            List<SingleItem> options = new ArrayList<>();
            options.add(new SingleItem(StringUtils.EMPTY, getString(R.string.credit_app_nav_all)));
            options.add(new SingleItem(CreditAppType.GROUP, getString(R.string.credit_app_nav_group)));
            options.add(new SingleItem(CreditAppType.INDIVIDUAL, getString(R.string.credit_app_nav_individual)));

            mFilterAdapter = new TitleAdapter(getContext(), R.string.credit_app_title, options);
            filterSpinner.setAdapter(mFilterAdapter);
            filterSpinner.setSelection(0, false);
            filterSpinner.setOnItemSelectedListener(this);
        }
        mSwipeRefreshLayout.setOnRefreshListener(mOnRefreshListener);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_apps, menu);
        // Associate searchable configuration with the SearchView
        SearchManager searchManager =
                (SearchManager) getContext().getSystemService(Context.SEARCH_SERVICE);
        mSearchMenuItem = menu.findItem(R.id.menu_search_apps);
        SearchView searchView = (SearchView) mSearchMenuItem.getActionView();
        searchView.setQueryHint(getString(R.string.credit_app_hint_search));
        searchView.setSearchableInfo(
                searchManager.getSearchableInfo(getActivity().getComponentName()));
        searchView.setSubmitButtonEnabled(false);
        searchView.setOnQueryTextListener(this);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_GROUP && resultCode == Activity.RESULT_OK) {
            mPresenter.onGroupSelected((Group) data.getSerializableExtra(SelectGroupActivity.EXTRA_GROUP));
        } else if (requestCode == REQUEST_CUSTOMER && resultCode == Activity.RESULT_OK) {
            mPresenter.onCustomerSelected((Person) data.getSerializableExtra(SelectCustomerActivity.EXTRA_CUSTOMER));
        } else {
            super.onActivityResult(requestCode, resultCode, data);
        }
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

    @OnClick({R.id.fab_group, R.id.label_group})
    public void onClickAddGroup(View view) {
        collapseFabMenu();
        startActivityForResult(SelectGroupActivity.newIntent(getContext()), REQUEST_GROUP);
    }

    @OnClick({R.id.fab_individual, R.id.label_individual})
    public void onClickAddIndividual(View view) {
        collapseFabMenu();
        startActivityForResult(SelectCustomerActivity.newIntent(getContext(), null, null, CustomersPresenter.Mode.CREDIT_APP), REQUEST_CUSTOMER);
    }

    @Override
    public void setPresenter(CreditAppContract.ApplicationsPresenter presenter) {
        mPresenter = presenter;
    }

    private void getAnimations() {
        fabOpenAnimation = AnimationUtils.loadAnimation(getContext(), R.anim.fab_open);
        fabCloseAnimation = AnimationUtils.loadAnimation(getContext(), R.anim.fab_close);
    }

    @OnClick(R.id.fab_blockscreen)
    public void onClickBockScreen(View view) {
        collapseFabMenu();
    }

    private void expandFabMenu() {
        ViewCompat.animate(mAddActionButton).rotation(45.0F).withLayer().setDuration(300).setInterpolator(new OvershootInterpolator(10.0F)).start();
        mFabBlockscreenView.setVisibility(View.VISIBLE);
        mGroupLayout.startAnimation(fabOpenAnimation);
        mIndividualLayout.startAnimation(fabOpenAnimation);
        mGroupActionButton.setClickable(true);
        mIndividualActionButton.setClickable(true);
        mFabBlockscreenView.setClickable(true);
        isFabMenuOpen = true;
    }

    private void collapseFabMenu() {
        ViewCompat.animate(mAddActionButton).rotation(0.0F).withLayer().setDuration(300).setInterpolator(new OvershootInterpolator(10.0F)).start();
        mFabBlockscreenView.setVisibility(View.INVISIBLE);
        mGroupLayout.startAnimation(fabCloseAnimation);
        mIndividualLayout.startAnimation(fabCloseAnimation);
        mGroupActionButton.setClickable(false);
        mIndividualActionButton.setClickable(false);
        mFabBlockscreenView.setClickable(false);
        isFabMenuOpen = false;
    }

    @Override
    public void onItemClick(CreditApp item) {
        if (item.getType().equals(CreditAppType.GROUP)) {
            startGroupCreditApp((GroupCreditApp) item);
        } else if (item.getType().equals(CreditAppType.INDIVIDUAL)) {
            startIndividualCreditApp((IndividualCreditApp) item);
        } else {
            throw new RuntimeException("Credit Application Type not supported!!");
        }
    }

    @Override
    public void showCreditApps(List<CreditApp> creditApps) {
        mAppAdapter.updateAll(creditApps);
        mAppsRecyclerView.setVisibility(View.VISIBLE);
        mEmptyView.setVisibility(View.GONE);
    }

    @Override
    public void showSearchError() {
        Toast.makeText(getContext(), R.string.credit_app_error_load, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showCreditAppsEmpty() {
        showNoAppsView(getString(R.string.credit_app_msg_empty), true);
    }

    @Override
    public void showNoResultsFound() {
        showNoAppsView(getString(R.string.search_result_empty_msg), false);
    }

    @Override
    public void showLoadCreditAppsError() {
        Toast.makeText(getContext(), R.string.credit_app_error_load, Toast.LENGTH_SHORT).show();
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
    public void clearResults() {
        mAppAdapter.clear();
    }

    @Override
    public void startGroupCreditApp(GroupCreditApp groupCreditApp) {
        startActivity(GroupCreditActivity.newIntent(getContext(), groupCreditApp));
    }

    @Override
    public void startIndividualCreditApp(IndividualCreditApp individualCreditApp) {
        startActivity(IndividualCreditActivity.newIntent(getContext(), individualCreditApp));
    }

    @Override
    public void clearSearch() {
        if (mSearchMenuItem != null) {
            MenuItemCompat.collapseActionView(mSearchMenuItem);
        }
    }

    private void showNoAppsView(String message, boolean showAddView) {
        mAppsRecyclerView.setVisibility(View.GONE);
        mEmptyView.setVisibility(View.VISIBLE);
        mEmptyAddText.setVisibility(showAddView ? View.VISIBLE : View.GONE);
        mEmptyText.setText(message);
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

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
        mPresenter.loadCreditApps(mFilterAdapter.getItem(pos).getCode());
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }
}