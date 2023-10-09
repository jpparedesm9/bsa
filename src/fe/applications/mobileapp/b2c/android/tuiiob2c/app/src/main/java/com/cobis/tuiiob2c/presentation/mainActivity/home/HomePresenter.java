package com.cobis.tuiiob2c.presentation.mainActivity.home;

import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.data.models.responses.ParametersResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class HomePresenter implements HomeMVP.HomePresenter {

    private HomeMVP.HomeView homeView;
    private HomeMVP.HomeModel homeModel;

    private Disposable disposable;

    private LoanInfoResponse loanInfoResponse;

    public HomePresenter(HomeMVP.HomeModel homeModel) {
        this.homeModel = homeModel;
    }

    @Override
    public void setView(HomeMVP.HomeView homeView) {
        this.homeView = homeView;
    }

    @Override
    public void start() {
        homeView.showLoading();
        disposable = homeModel.getLoanInfo(SessionManager.getInstance().getValuesEnrollment().getNumeroCredito())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<LoanInfoResponse>() {
                    @Override
                    public void onNext(LoanInfoResponse loanInfoResponse) {
                        if (loanInfoResponse.isResult()) {
                            HomePresenter.this.loanInfoResponse = loanInfoResponse;
                            homeView.showGetLoanInfoSuccess(loanInfoResponse);
                        } else {
                            homeView.showGetLoanInfoError(loanInfoResponse.getFirstMessage() == null ? "" : loanInfoResponse.getFirstMessage().getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        homeView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        homeView.hideLoading();
                        getParametersDispersion();
                    }
                });
    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }

    @Override
    public void setClickCreateCreditSolicitation() {
        homeView.openActivityCreditSolicitation(loanInfoResponse);
    }

    private void getParametersDispersion() {
        homeView.showLoading();
        disposable = homeModel.getParametersDispersion()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<ParametersResponse>() {
                    @Override
                    public void onNext(ParametersResponse parametersResponse) {

                    }

                    @Override
                    public void onError(Throwable e) {
                        homeView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        homeView.hideLoading();

                    }
                });
    }
}
