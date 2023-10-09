package com.cobis.gestionasesores.presentation.tasks;

import android.app.SearchManager;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.view.MenuItemCompat;
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
import android.widget.AdapterView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.SingleItem;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.TitleAdapter;
import com.cobis.gestionasesores.presentation.groupverification.GroupVerificationActivity;
import com.cobis.gestionasesores.presentation.solidaritypayment.SolidarityPaymentActivity;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class TasksFragment extends Fragment implements TasksContract.View,
        AdapterView.OnItemSelectedListener, TaskAdapter.TaskListener {

    @BindView(R.id.list_tasks)
    RecyclerView mTaskList;
    @BindView(R.id.swipe_refresh_layout)
    SwipeRefreshLayout mSwipeRefreshLayout;
    @BindView(R.id.text_empty)
    TextView mEmptyText;

    private MenuItem mSearchMenuItem;
    private TasksContract.Presenter mPresenter;
    private TaskAdapter mAdapter;
    private TitleAdapter mFilterAdapter;

    public static TasksFragment newInstance() {
        Bundle args = new Bundle();
        TasksFragment fragment = new TasksFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_task, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mAdapter = new TaskAdapter(this);

        mTaskList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mTaskList.setLayoutManager(new LinearLayoutManager(getContext()));

        mTaskList.setAdapter(mAdapter);

        //setup toolbar
        Toolbar toolbar = ((BaseActivity) getActivity()).getToolbar();
        if (toolbar != null) {
            Spinner filterSpinner = (Spinner) toolbar.findViewById(R.id.spinner_nav);
            List<SingleItem> options = new ArrayList<>();
            options.add(new SingleItem(StringUtils.EMPTY, getString(R.string.tasks_nav_all)));
            options.add(new SingleItem(TaskType.SOLIDARITY_PAYMENT, getString(R.string.tasks_nav_solidarity_payment)));
            options.add(new SingleItem(TaskType.GROUP_VERIFICATION, getString(R.string.tasks_nav_verify_group)));
            options.add(new SingleItem(TaskType.INDIVIDUAL_VERIFICATION, getString(R.string.tasks_nav_verify_individual)));

            mFilterAdapter = new TitleAdapter(getContext(), R.string.tasks_title, options);
            filterSpinner.setAdapter(mFilterAdapter);
            filterSpinner.setSelection(0, false);
            filterSpinner.setOnItemSelectedListener(this);
        }
        mSwipeRefreshLayout.setOnRefreshListener(mOnRefreshListener);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.tasks, menu);
        // Associate searchable configuration with the SearchView
        SearchManager searchManager =
                (SearchManager) getContext().getSystemService(Context.SEARCH_SERVICE);
        mSearchMenuItem = menu.findItem(R.id.menu_search_tasks);
        final SearchView searchView = (SearchView) mSearchMenuItem.getActionView();
        searchView.setQueryHint(getString(R.string.menu_search_tasks));
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getActivity().getComponentName()));
        searchView.setSubmitButtonEnabled(false);

       io.reactivex.Observable.create(new ObservableOnSubscribe<String>() {
            @Override
            public void subscribe(final ObservableEmitter<String> e) throws Exception {
                searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
                    @Override
                    public boolean onQueryTextSubmit(String query) {
                        return false;
                    }

                    @Override
                    public boolean onQueryTextChange(String newText) {
                        e.onNext(newText);
                        return false;
                    }
                });
            }
        }).debounce(500, TimeUnit.MILLISECONDS)
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeOn(Schedulers.io())
                .subscribeWith(new DisposableObserver<String>() {
                    @Override
                    public void onNext(String s) {
                        mPresenter.onSearchChange(s);
                    }

                    @Override
                    public void onError(Throwable e) {

                    }

                    @Override
                    public void onComplete() {

                    }
                });
    }

    @Override
    public void onResume() {
        super.onResume();
        mPresenter.start();
    }

    @Override
    public void setPresenter(TasksContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showTasks(List<Task> tasks) {
        mTaskList.setVisibility(View.VISIBLE);
        mEmptyText.setVisibility(View.GONE);

        mAdapter.setNewTasks(tasks);
    }

    @Override
    public void showTasksEmpty() {
        showNoTasksView(getString(R.string.tasks_msg_empty));
    }

    @Override
    public void showNoResultsFound() {
        showNoTasksView(getString(R.string.search_result_empty_msg));
    }

    @Override
    public void showLoadTasksError() {
        Toast.makeText(getContext(), R.string.tasks_error_load, Toast.LENGTH_SHORT).show();
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
        mAdapter.clear();
    }

    @Override
    public void clearSearch() {
        if (mSearchMenuItem != null) {
            MenuItemCompat.collapseActionView(mSearchMenuItem);
        }
    }

    @Override
    public void startVerification(Verification verification) {
        startActivity(GroupVerificationActivity.newIntent(getContext(), verification.getId(), verification.getType()));
    }

    @Override
    public void startSolidarityPayment(SolidarityPayment solidarityPayment) {
        startActivity(SolidarityPaymentActivity.newIntent(getContext(), solidarityPayment.getId()));
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        mPresenter.loadTasks(mFilterAdapter.getItem(position).getCode());
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {
    }

    private SwipeRefreshLayout.OnRefreshListener mOnRefreshListener = new SwipeRefreshLayout.OnRefreshListener() {
        @Override
        public void onRefresh() {
            mPresenter.onRefresh();
        }
    };

    private void showNoTasksView(String message) {
        mTaskList.setVisibility(View.GONE);
        mEmptyText.setVisibility(View.VISIBLE);
        mEmptyText.setText(message);
    }

    @Override
    public void onClickTask(Task task) {
        mPresenter.onTaskSelected(task);
    }
}