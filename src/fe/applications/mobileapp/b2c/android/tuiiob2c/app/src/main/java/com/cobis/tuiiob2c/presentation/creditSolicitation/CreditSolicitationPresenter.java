package com.cobis.tuiiob2c.presentation.creditSolicitation;

import android.text.TextUtils;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Commission;
import com.cobis.tuiiob2c.data.models.CommissionCalculateValues;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;

import java.text.DecimalFormat;
import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class CreditSolicitationPresenter implements CreditSolicitationMVP.CreditSolicitationPresenter {

    private CreditSolicitationMVP.CreditSolicitationView creditSolicitationView;
    private CreditSolicitationMVP.CreditSolicitationModel creditSolicitationModel;

    private Disposable disposable;

    private LoanInfoResponse loanInfo;

    public CreditSolicitationPresenter(CreditSolicitationMVP.CreditSolicitationModel creditSolicitationModel) {
        this.creditSolicitationModel = creditSolicitationModel;
    }

    @Override
    public void setView(CreditSolicitationMVP.CreditSolicitationView creditSolicitationView) {
        this.creditSolicitationView = creditSolicitationView;
    }

    @Override
    public void start() {

    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }

    @Override
    public void setLoanInfo(LoanInfoResponse loanInfo) {
        this.loanInfo = loanInfo;
    }

    @Override
    public void calculateCommissionValues(String value) {
        if (TextUtils.isEmpty(value))
            value = "0";
        double v = Double.parseDouble(value);

        List<Commission> commissionList = SessionManager.getInstance().getParameters().getTablaComision();
        double percentage = 0;
        for (Commission commission : commissionList) {
            if (v >= commission.getMin() && v <= commission.getMax()) {
                percentage = commission.getComission();
                break;
            }
        }

        CommissionCalculateValues commissionCalculateValues = new CommissionCalculateValues();

        double commission = v * percentage / 100;
        double iva = commission * SessionManager.getInstance().getParameters().getPorcentajeIva() / 100;
        double valueToReceive = v - commission - iva;

        commissionCalculateValues.setCommission(new DecimalFormat("0.00").format(commission));
        commissionCalculateValues.setIva(new DecimalFormat("0.00").format(iva));
        commissionCalculateValues.setValueToReceive(new DecimalFormat("0.00").format(valueToReceive));

        creditSolicitationView.setCalculateValues(commissionCalculateValues);
    }

    @Override
    public void saveLoanDispersion(String amount) {
        if (validateAmount(amount)) {
            creditSolicitationView.showLoading();
            disposable = creditSolicitationModel.saveLoanDispersion(Double.parseDouble(amount))
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                creditSolicitationView.showCalculateDispersionSuccess();
                            } else {
                                creditSolicitationView.showCalculateDispersionError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            creditSolicitationView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            creditSolicitationView.hideLoading();
                        }
                    });
        }
    }

    private boolean validateAmount(String amount) {
        if (amount == null || amount.isEmpty()) {
            creditSolicitationView.showErrorValidateFields();
            return false;
        } else {
            double value = Double.parseDouble(amount);
            List<Commission> commissionList = SessionManager.getInstance().getParameters().getTablaComision();
            double max = -1, min = -1;
            for (Commission commission : commissionList) {
                if (min == -1 || min > commission.getMin()) {
                    min = commission.getMin();
                }

                if (max == -1 || max < commission.getMax()) {
                    max = commission.getMax();
                }
            }

            if (loanInfo.getData().getLineaCredito() <= 0) {
                creditSolicitationView.showErrorZeroAmount();
                return false;
            } else if (value > loanInfo.getData().getLineaCredito() && value < min) {
                creditSolicitationView.showErrorMinPermittedAmount(min);
                return false;
            } else if (value > max && value < loanInfo.getData().getLineaCredito()) {
                creditSolicitationView.showErrorMaxPermittedAmount(max);
                return false;
            } else if (value < min) {
                creditSolicitationView.showErrorMinPermittedAmount(min);
                return false;
            } else if (value > loanInfo.getData().getLineaCredito()) {
                creditSolicitationView.showErrorMaxPermittedAmount(loanInfo.getData().getLineaCredito());
                return false;
            } else {
                return true;
            }
        }
    }
}
