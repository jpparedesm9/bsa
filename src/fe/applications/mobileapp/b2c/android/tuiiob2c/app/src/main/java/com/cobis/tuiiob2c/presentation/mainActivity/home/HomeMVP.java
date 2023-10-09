package com.cobis.tuiiob2c.presentation.mainActivity.home;

import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.data.models.responses.ParametersResponse;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface HomeMVP {

    interface HomeModel {

        Observable<LoanInfoResponse> getLoanInfo(String creditNumber);

        Observable<ParametersResponse> getParametersDispersion();
    }

    interface HomeView extends BaseView {

        void showGetLoanInfoSuccess(LoanInfoResponse loanInfoResponse);

        void showGetLoanInfoError(String message);

        void openActivityCreditSolicitation(LoanInfoResponse loanInfoResponse);
    }

    interface HomePresenter extends BasePresenter {

        void setView(HomeMVP.HomeView homeView);

        void setClickCreateCreditSolicitation();
    }
}
