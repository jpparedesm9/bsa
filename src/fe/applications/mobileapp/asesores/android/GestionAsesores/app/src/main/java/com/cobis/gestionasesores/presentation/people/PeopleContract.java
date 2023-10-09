package com.cobis.gestionasesores.presentation.people;

import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

public class PeopleContract {
    public interface View extends BaseView<Presenter>{
        void showPeople(List<Person> people);
        void showSearchError();
        void showPeopleEmpty();
        void showNoResultsFound();
        void showLoadPeopleError();
        void showLoadingIndicator();
        void hideLoadingIndicator();
        void clearSearch();
        void startPersonActivity(Person person);
    }

    public interface Presenter extends BasePresenter{
        void onSearchChange(String keyword);
        void onPersonSelected(Person person);
        void onRefresh();
        void onTypeChange(int type);
    }
}