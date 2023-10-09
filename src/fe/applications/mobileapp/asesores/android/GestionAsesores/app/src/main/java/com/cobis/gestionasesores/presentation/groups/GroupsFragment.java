package com.cobis.gestionasesores.presentation.groups;

import android.app.Activity;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
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

import com.bayteq.libcore.util.CommonUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.presentation.group.GroupActivity;
import com.cobis.gestionasesores.presentation.selectgroup.SelectGroupActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by mnaunay on 15/06/2017.
 */

public class GroupsFragment extends Fragment implements GroupsContract.View, GroupsAdapter.OnItemClickListener ,SearchView.OnQueryTextListener{
    @BindView(R.id.view_empty)
    View mEmptyView;
    @BindView(R.id.list_groups)
    RecyclerView mGroupsRecyclerView;
    @BindView(R.id.text_empty_add)
    TextView mEmptyAddText;
    @BindView(R.id.text_empty)
    TextView mEmptyText;
    @BindView(R.id.swipe_refresh_layout)
    SwipeRefreshLayout mSwipeRefreshLayout;
    @BindView(R.id.action_button_add)
    FloatingActionButton mAddGroupButton;

    private GroupsContract.Presenter mPresenter;
    private GroupsAdapter mAdapter;
    private MenuItem mSearchMenuItem;

    public static GroupsFragment newInstance() {
        Bundle args = new Bundle();
        GroupsFragment fragment = new GroupsFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
        mAdapter = new GroupsAdapter(new ArrayList<Group>(0),this);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_groups, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mGroupsRecyclerView.addItemDecoration(new DividerItemDecoration(getContext(),DividerItemDecoration.VERTICAL));
        mGroupsRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
        mGroupsRecyclerView.setHasFixedSize(true);
        mGroupsRecyclerView.setAdapter(mAdapter);

        mSwipeRefreshLayout.setOnRefreshListener(mOnRefreshListener);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.search_group, menu);
        SearchManager searchManager = (SearchManager) getContext().getSystemService(Context.SEARCH_SERVICE);
        mSearchMenuItem = menu.findItem(R.id.menu_search_groups);
        SearchView searchView = (SearchView) mSearchMenuItem.getActionView();
        searchView.setQueryHint(getString(R.string.groups_hint_search));
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getActivity().getComponentName()));
        searchView.setSubmitButtonEnabled(false);
        searchView.setOnQueryTextListener(this);
    }

    @Override
    public void onResume() {
        super.onResume();
        mPresenter.start();
    }

    @OnClick(R.id.action_button_add)
    public void onClickAddGroup(View view) {
        CommonUtils.hideSoftKeyboard(view);
        mPresenter.onAddNewGroup();
    }

    @Override
    public void setPresenter(@NonNull GroupsContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showNoResultsFound() {
        showNoCustomersView(getString(R.string.search_result_empty_msg), false);
    }

    @Override
    public void clearResults() {
        mAdapter.clear();
    }

    @Override
    public void startNewGroup() {
        startActivity(GroupActivity.newIntent(getContext(), -1));
    }

    @Override
    public void showGroupsEmpty(boolean showAdd) {
        showNoCustomersView(getString(R.string.groups_msg_empty),showAdd);
    }

    @Override
    public void showLoadGroupsError() {
        Toast.makeText(getContext(), R.string.groups_error_load, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showSearchError() {
        Toast.makeText(getContext(), R.string.groups_error_load, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void clearSearch() {
        if (mSearchMenuItem != null) {
            MenuItemCompat.collapseActionView(mSearchMenuItem);
        }
    }

    @Override
    public void showGroups(List<Group> groups) {
        mAdapter.replace(groups);
        mGroupsRecyclerView.setVisibility(View.VISIBLE);
        mEmptyView.setVisibility(View.GONE);
    }

    @Override
    public void showLoadingIndicator() {
        if(!mSwipeRefreshLayout.isRefreshing()) {
            mSwipeRefreshLayout.setRefreshing(true);
        }
    }

    @Override
    public void showAddGroup(boolean shouldShow) {
        mAddGroupButton.setVisibility(shouldShow? View.VISIBLE: View.GONE);
    }

    @Override
    public void startGroupDetail(Group group) {
        startActivity(GroupActivity.newIntent(getContext(), group.getId()));
    }

    @Override
    public void sendResult(Group group) {
        Intent intent = new Intent();
        intent.putExtra(SelectGroupActivity.EXTRA_GROUP,group);
        getActivity().setResult(Activity.RESULT_OK,intent);
        getActivity().finish();
    }

    @Override
    public void hideLoadingIndicator() {
        mSwipeRefreshLayout.setRefreshing(false);
    }

    @Override
    public void onItemClick(Group item) {
        mPresenter.onGroupSelected(item);
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

    private void showNoCustomersView(String message, boolean showAddView) {
        mGroupsRecyclerView.setVisibility(View.GONE);
        mEmptyView.setVisibility(View.VISIBLE);
        mEmptyAddText.setVisibility(showAddView ? View.VISIBLE : View.GONE);
        mEmptyText.setText(message);
    }

    private SwipeRefreshLayout.OnRefreshListener mOnRefreshListener = new SwipeRefreshLayout.OnRefreshListener() {
        @Override
        public void onRefresh() {
            mPresenter.onRefresh();
        }
    };
}
