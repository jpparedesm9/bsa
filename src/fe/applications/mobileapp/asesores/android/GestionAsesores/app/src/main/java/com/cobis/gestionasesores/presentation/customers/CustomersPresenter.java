package com.cobis.gestionasesores.presentation.customers;

import android.support.annotation.IntDef;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.requests.GetPersonsRequest;
import com.cobis.gestionasesores.domain.usecases.GetPersonsUseCase;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.List;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

import static com.cobis.gestionasesores.presentation.customers.CustomersPresenter.Mode.CREDIT_APP;
import static com.cobis.gestionasesores.presentation.customers.CustomersPresenter.Mode.GUARANTOR;
import static com.cobis.gestionasesores.presentation.customers.CustomersPresenter.Mode.MEMBER_GROUP;
import static com.cobis.gestionasesores.presentation.customers.CustomersPresenter.Mode.PARTNER;

public class CustomersPresenter implements CustomersContract.Presenter {
    @IntDef({MEMBER_GROUP, CREDIT_APP, GUARANTOR, PARTNER})
    @Retention(RetentionPolicy.SOURCE)
    public @interface Mode {
        int MEMBER_GROUP = 0;
        int CREDIT_APP = 1;
        int GUARANTOR = 2;
        int PARTNER = 3;
    }

    private CustomersContract.View mView;
    private GetPersonsUseCase mGetPersonsUseCase;
    private String mLastKeyword;
    private int[] mServerIds;
    private int[] mLocalIds;
    @Mode
    private int mMode;

    public CustomersPresenter(CustomersContract.View view, int[] serverIds, int[] localIds, int mode, GetPersonsUseCase getPersonsUseCase) {
        mView = view;
        mServerIds = serverIds;
        mLocalIds = localIds;
        mMode = mode;
        mGetPersonsUseCase = getPersonsUseCase;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mLastKeyword = "";
        mView.clearSearch();
        getCustomers(mLastKeyword, false);
    }

    @Override
    public void onSearchChange(String keyword) {
        mLastKeyword = keyword;
        getCustomers(mLastKeyword, true);
    }

    @Override
    public void onCustomerSelected(Person customer) {
        mView.sendResult(customer);
    }

    @Override
    public void onRefresh() {
        getCustomers(mLastKeyword, StringUtils.isNotEmpty(mLastKeyword));
    }

    private void getCustomers(String keyword, final boolean isSearch) {
        mView.showLoadingIndicator();
        GetPersonsRequest.Builder request = new GetPersonsRequest.Builder().setValidated(true).setKeyword(keyword).setInGroup(null);
        switch (mMode) {
            case GUARANTOR:
                request.setStatus(SyncStatus.SYNCED, SyncStatus.PENDING);
                break;
            case MEMBER_GROUP:
                request.setType(PersonType.CUSTOMER).setStatus(SyncStatus.SYNCED, SyncStatus.PENDING);
                request.setInGroup(Boolean.FALSE);
                break;
            case CREDIT_APP:
                request.setType(PersonType.CUSTOMER).setStatus(SyncStatus.SYNCED, SyncStatus.PENDING).setCreditType(CreditAppType.INDIVIDUAL);
                break;
            case PARTNER:
                request.setHasPartner(false);
                break;
            default:
                throw new RuntimeException("Customer mode list not implemented!!" + mMode);
        }
        mGetPersonsUseCase.execute(request.build(), new DisposableObserver<List<Person>>() {
            @Override
            public void onNext(@NonNull List<Person> customers) {
                if (isSearch) {
                    handleSearchResult(customers);
                } else {
                    handleLoadResult(customers);
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.hideLoadingIndicator();
                mView.showLoadCustomersError();
            }

            @Override
            public void onComplete() {
                mView.hideLoadingIndicator();
            }
        });
    }

    private void handleLoadResult(@NonNull List<Person> customers) {
        if (customers.isEmpty()) {
            mView.showCustomersEmpty();
        } else {
            mView.showCustomers(customers, mServerIds, mLocalIds);
        }
    }

    private void handleSearchResult(@NonNull List<Person> customers) {
        if (customers.isEmpty()) {
            mView.showNoResultsFound();
        } else {
            mView.showCustomers(customers, mServerIds, mLocalIds);
        }
    }
}