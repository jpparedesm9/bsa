package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.requests.LoanInfoRequest;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.data.models.responses.ParametersResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.mainActivity.home.HomeMVP;
import com.cobis.tuiiob2c.usecases.source.LoanSource;

import io.reactivex.Observable;

public class LoanInfoUseCase implements HomeMVP.HomeModel {

    private LoanSource loanSource;

    public LoanInfoUseCase(LoanSource loanSource) {
        this.loanSource = loanSource;
    }

    @Override
    public Observable<LoanInfoResponse> getLoanInfo(String creditNumber) {
        return Observable.fromCallable(() -> loanSource.getLoanInfo(new LoanInfoRequest(creditNumber)));
    }

    @Override
    public Observable<ParametersResponse> getParametersDispersion() {
        return Observable.fromCallable(() -> {
            ParametersResponse parametersResponse = loanSource.getParametersDispersion();
                if (parametersResponse.isResult()) {
                    SessionManager.getInstance().saveParameters(parametersResponse.getData());
                }
            return parametersResponse;
        });
    }
}
