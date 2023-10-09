package com.cobis.tuiiob2c.repositories;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.LoanInfoRequest;
import com.cobis.tuiiob2c.data.models.requests.LoanRequest;
import com.cobis.tuiiob2c.data.models.requests.OtpLoanRequest;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.data.models.responses.ParametersResponse;
import com.cobis.tuiiob2c.services.modules.LoanApi;
import com.cobis.tuiiob2c.usecases.source.CreditSolicitationSource;
import com.cobis.tuiiob2c.usecases.source.LoanSource;
import com.cobis.tuiiob2c.usecases.source.OtpCreditVerificationSource;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Response;

public class LoanRepository implements LoanSource, CreditSolicitationSource, OtpCreditVerificationSource {

    private LoanApi loanApi;

    public LoanRepository(LoanApi loanApi) {
        this.loanApi = loanApi;
    }

    @Override
    public LoanInfoResponse getLoanInfo(LoanInfoRequest loanInfoRequest) {
        LoanInfoResponse loanInfoResponse = new LoanInfoResponse();
        loanInfoResponse.setResult(false);
        try {
            Response<LoanInfoResponse> loanInfoResponseResponse = loanApi.getLoanInfo(loanInfoRequest).execute();
            int statusCode = loanInfoResponseResponse.code();
            if (statusCode == 200) {
                loanInfoResponse = loanInfoResponseResponse.body();
            } else {
                if (loanInfoResponseResponse.errorBody() != null) {
                    loanInfoResponse = new Gson().fromJson(loanInfoResponseResponse.errorBody().charStream(), LoanInfoResponse.class);
                }
            }
            if (loanInfoResponse != null) {
                loanInfoResponse.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            loanInfoResponse.setResult(false);
        }

        return loanInfoResponse;
    }

    @Override
    public ParametersResponse getParametersDispersion() {
        ParametersResponse parametersResponse = new ParametersResponse();
        parametersResponse.setResult(false);
        try {
            Response<ParametersResponse> parametersResponseResponse = loanApi.getParametersDispersion().execute();
            int statusCode = parametersResponseResponse.code();
            if (statusCode == 200) {
                parametersResponse = parametersResponseResponse.body();
            } else {
                if (parametersResponseResponse.errorBody() != null) {
                    parametersResponse = new Gson().fromJson(parametersResponseResponse.errorBody().charStream(), ParametersResponse.class);
                }
            }
            if (parametersResponse != null) {
                parametersResponse.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            parametersResponse.setResult(false);
        }

        return parametersResponse;
    }

    @Override
    public BaseModel saveLoanDispersion(LoanRequest loanRequest) {
        BaseModel baseModel = new BaseModel();
        baseModel.setResult(false);
        try {
            Response<Void> saveLoanResponseResponse = loanApi.solicitAmount(loanRequest).execute();
            int statusCode = saveLoanResponseResponse.code();
            if (statusCode != 200) {
                if (saveLoanResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(saveLoanResponseResponse.errorBody().charStream(), BaseModel.class);
                }
            }
            if (baseModel != null) {
                baseModel.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            baseModel.setResult(false);
        }

        return baseModel;
    }

    @Override
    public BaseModel confirmOtpSolicitAmount(OtpLoanRequest otpLoanRequest) {
        BaseModel baseModel = new BaseModel();
        baseModel.setResult(false);
        try {
            Response<Void> confirmOtpLoanResponseResponse = loanApi.confirmOtpSolicitAmount(otpLoanRequest).execute();
            int statusCode = confirmOtpLoanResponseResponse.code();
            if (statusCode != 200) {
                if (confirmOtpLoanResponseResponse.errorBody() != null) {
                    baseModel = new Gson().fromJson(confirmOtpLoanResponseResponse.errorBody().charStream(), BaseModel.class);
                }
            }
            if (baseModel != null) {
                baseModel.setResult(statusCode == 200);
            }
        } catch (IOException e) {
            baseModel.setResult(false);
        }

        return baseModel;
    }
}
