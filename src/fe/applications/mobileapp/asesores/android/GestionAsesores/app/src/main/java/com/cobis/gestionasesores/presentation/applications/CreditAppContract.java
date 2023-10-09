package com.cobis.gestionasesores.presentation.applications;

import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/22/2017.
 */

public interface CreditAppContract {

    interface ApplicationsView extends BaseView<ApplicationsPresenter> {

        void showCreditApps(List<CreditApp> creditApps);

        void showSearchError();

        void showCreditAppsEmpty();

        void showNoResultsFound();

        void showLoadCreditAppsError();

        void showLoadingIndicator();

        void hideLoadingIndicator();

        void clearResults();

        void startGroupCreditApp(GroupCreditApp groupCreditApp);

        void startIndividualCreditApp(IndividualCreditApp individualCreditApp);

        void clearSearch();
    }

    interface ApplicationsPresenter extends BasePresenter {

        void onRefresh();

        void onSearchChange(String query);

        void loadCreditApps(String creditAppType);

        void onGroupSelected(Group group);

        void onCustomerSelected(Person person);
    }
}
