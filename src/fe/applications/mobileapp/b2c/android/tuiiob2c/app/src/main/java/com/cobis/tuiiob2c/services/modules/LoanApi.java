package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.requests.LoanInfoRequest;
import com.cobis.tuiiob2c.data.models.requests.LoanRequest;
import com.cobis.tuiiob2c.data.models.requests.OtpLoanRequest;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.data.models.responses.ParametersResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.PUT;

public interface LoanApi {

    @POST("loan/info")
    Call<LoanInfoResponse> getLoanInfo(@Body LoanInfoRequest loanInfoRequest);

    @GET("security/client/parameters")
    Call<ParametersResponse> getParametersDispersion();

    @POST("loan")
    Call<Void> solicitAmount(@Body LoanRequest loanRequest);

    @PUT("loan")
    Call<Void> confirmOtpSolicitAmount(@Body OtpLoanRequest otpLoanRequest);
}
