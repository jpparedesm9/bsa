package com.cobis.gestionasesores.presentation.people;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.requests.GetPersonsRequest;
import com.cobis.gestionasesores.domain.usecases.GetPersonsUseCase;

import java.util.List;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

public class PeoplePresenter implements PeopleContract.Presenter {

    private final PeopleContract.View mView;
    private GetPersonsUseCase mGetPersonsUseCase;
    private String mLastKeyword;
    private int mLastPersonType = PersonType.UNKNOWN;

    public PeoplePresenter(PeopleContract.View view, GetPersonsUseCase getPersonsUseCase) {
        mView = view;
        mGetPersonsUseCase = getPersonsUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mLastKeyword = "";
        mView.clearSearch();
        loadPeople(mLastKeyword, mLastPersonType, false);
    }

    @Override
    public void onSearchChange(String keyword) {
        mLastKeyword = keyword;
        loadPeople(mLastKeyword, mLastPersonType, true);
    }

    @Override
    public void onPersonSelected(Person person) {
        mView.startPersonActivity(person);
    }

    @Override
    public void onRefresh() {
        loadPeople(mLastKeyword, mLastPersonType, StringUtils.isNotEmpty(mLastKeyword));
    }

    @Override
    public void onTypeChange(int type) {
        mLastPersonType = type;
        loadPeople(mLastKeyword, mLastPersonType, false);
    }

    private void loadPeople(String keyword, int personType, final boolean isSearch) {
        mView.showLoadingIndicator();
        mGetPersonsUseCase.execute(new GetPersonsRequest.Builder().setType(personType).setKeyword(keyword).build(), new DisposableObserver<List<Person>>() {
            @Override
            public void onNext(@NonNull List<Person> people) {
                if (people.isEmpty()) {
                    if (isSearch) {
                        mView.showNoResultsFound();
                    } else {
                        mView.showPeopleEmpty();
                    }
                } else {
                    mView.showPeople(people);
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("PeoplePresenter: Error loading people! ", e);
                //mView.showLoadPeopleError();
                mView.hideLoadingIndicator();
            }

            @Override
            public void onComplete() {
                mView.hideLoadingIndicator();
            }
        });
    }
}