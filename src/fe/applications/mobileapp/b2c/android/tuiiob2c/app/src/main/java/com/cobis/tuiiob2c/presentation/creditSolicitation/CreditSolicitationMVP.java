package com.cobis.tuiiob2c.presentation.creditSolicitation;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.CommissionCalculateValues;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface CreditSolicitationMVP {

    interface CreditSolicitationModel {

        Observable<BaseModel> saveLoanDispersion(double amount);
    }

    interface CreditSolicitationView extends BaseView {

        void showErrorValidateFields();

        void setCalculateValues(CommissionCalculateValues commissionCalculateValues);

        void showCalculateDispersionSuccess();

        void showCalculateDispersionError(String message);

        void showErrorZeroAmount();

        void showErrorMaxPermittedAmount(double amount);

        void showErrorMinPermittedAmount(double amount);
    }

    interface CreditSolicitationPresenter extends BasePresenter {

        void setView(CreditSolicitationMVP.CreditSolicitationView creditSolicitationView);

        void setLoanInfo(LoanInfoResponse loanInfo);

        void calculateCommissionValues(String value);

        void saveLoanDispersion(String amount);
    }

}
