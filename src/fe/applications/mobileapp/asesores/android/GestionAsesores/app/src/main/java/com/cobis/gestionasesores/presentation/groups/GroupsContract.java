package com.cobis.gestionasesores.presentation.groups;

import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

public class GroupsContract {
    public interface View extends BaseView<Presenter> {
        void startNewGroup();

        void showGroupsEmpty(boolean showAdd);

        void showGroups(List<Group> customers);

        void clearSearch();

        void showSearchError();

        void clearResults();

        void showNoResultsFound();

        void showLoadGroupsError();

        void hideLoadingIndicator();

        void showLoadingIndicator();

        void showAddGroup(boolean shouldShow);

        void startGroupDetail(Group group);

        void sendResult(Group group);
    }

    public interface Presenter extends BasePresenter {
        void onAddNewGroup();

        void onRefresh();

        void onSearchChange(String newText);

        void onGroupSelected(Group group);
    }
}