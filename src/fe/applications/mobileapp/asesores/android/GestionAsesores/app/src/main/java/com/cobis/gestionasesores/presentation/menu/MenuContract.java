package com.cobis.gestionasesores.presentation.menu;

import com.cobis.gestionasesores.data.models.Session;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

final class MenuContract {
    public interface Presenter extends BasePresenter {
        void onDrawerOptionCustomerClick();

        void onDrawerOptionGroupClick();

        void onDrawerOptionApplicationClick();

        void onDrawerOptionSimulationClick();

        void onDrawerOptionDefaultClick();

        void onDrawerOptionTaskClick();

        void onDrawerOptionSynchronizationClick();

        void onOptionLogoutClick();

        void onDrawerOptionSettingsClick();

        void onOpenUploadClick();
    }

    public interface View extends BaseView<MenuContract.Presenter> {
        void showCustomersFragment();

        void showDefaultFragment();

        void closeDrawer();

        void showGroupsFragment();

        void showCommentsActivity();

        void showApplicationsFragment();

        void showSimulationFragment();

        void showSynchronizationActivity(boolean isForcedOpen);

        void showUploadActivity();

        void selectDefaultMenuOption();

        void showTaskFragment();

        void showSessionInfo(Session session);

        void logout();

        void navigateToChangePin();

        void showSyncDialog(int itemCount);

        void showLoading();

        void hideLoading();

        void navigateToSettings();
    }
}
