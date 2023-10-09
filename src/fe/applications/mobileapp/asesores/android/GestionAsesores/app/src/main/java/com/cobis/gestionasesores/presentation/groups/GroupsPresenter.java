package com.cobis.gestionasesores.presentation.groups;

import android.support.annotation.IntDef;
import android.support.annotation.NonNull;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.domain.usecases.GetGroupsForCredit;
import com.cobis.gestionasesores.domain.usecases.GetGroupsUseCase;

import java.util.ArrayList;
import java.util.List;

import io.reactivex.observers.DisposableObserver;

import static com.cobis.gestionasesores.presentation.groups.GroupsPresenter.Mode.MODE_ADD;
import static com.cobis.gestionasesores.presentation.groups.GroupsPresenter.Mode.MODE_SELECT;

/**
 * Created by mnaunay on 15/06/2017.
 */

public class GroupsPresenter implements GroupsContract.Presenter {
    @IntDef({GroupsPresenter.Mode.MODE_SELECT, MODE_ADD})
    public @interface Mode {
        int MODE_SELECT = 1;
        int MODE_ADD = 2;
    }

    @NonNull
    private GroupsContract.View mGroupsView;
    @Mode
    private final int mMode;
    private String mLastKeyword;
    private GetGroupsUseCase mGetGroupsUseCase;
    private GetGroupsForCredit mGetGroupsForCredit;
    private List<Group> mFirstLoadGroups;

    public GroupsPresenter(@NonNull GroupsContract.View groupsView, @Mode int mode, GetGroupsUseCase getGroupsUseCase, GetGroupsForCredit getGroupsForCredit) {
        mGroupsView = groupsView;
        mMode = mode;
        mGetGroupsUseCase = getGroupsUseCase;
        mGetGroupsForCredit = getGroupsForCredit;
        mGroupsView.setPresenter(this);
    }

    @Override
    public void start() {
        configureMode(mMode);
        mLastKeyword = "";
        mGroupsView.clearSearch();
        getGroups(mLastKeyword, false);
    }

    @Override
    public void onAddNewGroup() {
        mGroupsView.startNewGroup();
    }

    @Override
    public void onRefresh() {
        getGroups(mLastKeyword, StringUtils.isNotEmpty(mLastKeyword));
    }

    @Override
    public void onSearchChange(String keyword) {
        mLastKeyword = keyword;
        getGroups(mLastKeyword, true);
    }

    @Override
    public void onGroupSelected(Group group) {
        if (mMode == MODE_ADD) {
            mGroupsView.startGroupDetail(group);
        } else if (mMode == GroupsPresenter.Mode.MODE_SELECT) {
            mGroupsView.sendResult(group);
        } else {
            throw new RuntimeException("Group mode is not implemented: " + mMode);
        }
    }

    private void configureMode(@Mode int mode) {
        switch (mode) {
            case MODE_ADD:
                mGroupsView.showAddGroup(true);
                break;
            case GroupsPresenter.Mode.MODE_SELECT:
                mGroupsView.showAddGroup(false);
                break;
            default:
                throw new RuntimeException("Groups mode operator is not implemented: " + mode);
        }
    }

    private void getGroups(String query, final boolean isSearch) {
        mGroupsView.showLoadingIndicator();
        switch (mMode) {
            case MODE_ADD:
                mGetGroupsUseCase.execute(query, new DisposableObserver<List<Group>>() {
                    @Override
                    public void onNext(@NonNull List<Group> groups) {
                        if (isSearch) {
                            if (groups.isEmpty()) {
                                mGroupsView.clearResults();
                                mGroupsView.showNoResultsFound();
                            } else {
                                mGroupsView.showGroups(groups);
                            }
                        } else {
                            handleLoadResult(groups, true);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        if (isSearch) {
                            mGroupsView.clearResults();
                            mGroupsView.showSearchError();
                        } else {
                            mGroupsView.showLoadGroupsError();
                        }
                    }

                    @Override
                    public void onComplete() {
                        mGroupsView.hideLoadingIndicator();
                    }
                });
                break;
            case MODE_SELECT:
                mGetGroupsForCredit.execute(new GetGroupsForCredit.GetGroupsForCreditRequest(query, mFirstLoadGroups), new DisposableObserver<List<Group>>() {
                    @Override
                    public void onNext(@NonNull List<Group> groups) {
                        if (isSearch) {
                            if (groups.isEmpty()) {
                                mGroupsView.clearResults();
                                mGroupsView.showNoResultsFound();
                            } else {
                                mGroupsView.showGroups(groups);
                            }
                        } else {
                            handleLoadResult(groups, false);
                        }

                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        if (isSearch) {
                            mGroupsView.clearResults();
                            mGroupsView.showSearchError();
                        } else {
                            mGroupsView.showLoadGroupsError();
                        }
                    }

                    @Override
                    public void onComplete() {
                        mGroupsView.hideLoadingIndicator();
                    }
                });
                break;
            default:
                throw new RuntimeException("Mode is not implemented!!");
        }
    }

    private void handleLoadResult(@NonNull List<Group> groups, boolean showEmpty) {
        if (groups.isEmpty()) {
            mGroupsView.showGroupsEmpty(showEmpty);
        } else {
            mGroupsView.showGroups(groups);
        }
        if(mFirstLoadGroups == null){
            mFirstLoadGroups = new ArrayList<>();
            mFirstLoadGroups.addAll(groups);
        }
    }
}
