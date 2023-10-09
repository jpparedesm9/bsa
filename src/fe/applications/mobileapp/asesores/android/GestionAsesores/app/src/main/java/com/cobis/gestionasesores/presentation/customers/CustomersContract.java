package com.cobis.gestionasesores.presentation.customers;

import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

public class CustomersContract {
    public interface View extends BaseView<Presenter> {
        void showCustomers(List<Person> customers, int[] serverIds, int[] localIds);

        void showCustomersEmpty();

        void showNoResultsFound();

        void showLoadCustomersError();

        void showLoadingIndicator();

        void hideLoadingIndicator();

        void clearSearch();

        void sendResult(Person customer);
    }

    public interface Presenter extends BasePresenter {
        void onSearchChange(String keyword);

        void onCustomerSelected(Person customer);

        void onRefresh();
    }
}