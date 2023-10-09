package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.LoanRequest;
import com.cobis.tuiiob2c.data.models.requests.OtpLoanRequest;
import com.cobis.tuiiob2c.presentation.creditSolicitation.CreditSolicitationMVP;
import com.cobis.tuiiob2c.presentation.otpCreditVerification.OtpCreditVerificationMVP;
import com.cobis.tuiiob2c.usecases.source.CreditSolicitationSource;
import com.cobis.tuiiob2c.usecases.source.OtpCreditVerificationSource;

import io.reactivex.Observable;

public class OtpCreditVerificationUseCase implements CreditSolicitationMVP.CreditSolicitationModel, OtpCreditVerificationMVP.OtpCreditVerificationModel {

    private CreditSolicitationSource creditSolicitationSource;
    private OtpCreditVerificationSource otpCreditVerificationSource;

    public OtpCreditVerificationUseCase(CreditSolicitationSource creditSolicitationSource) {
        this.creditSolicitationSource = creditSolicitationSource;
    }

    public OtpCreditVerificationUseCase(OtpCreditVerificationSource otpCreditVerificationSource) {
        this.otpCreditVerificationSource = otpCreditVerificationSource;
    }

    @Override
    public Observable<BaseModel> saveLoanDispersion(double amount) {
        return Observable.fromCallable(() -> creditSolicitationSource.saveLoanDispersion(new LoanRequest(amount)));
    }

    @Override
    public Observable<BaseModel> confirmOtpSolicitAmount(String otp) {
        return Observable.fromCallable(() -> otpCreditVerificationSource.confirmOtpSolicitAmount(new OtpLoanRequest(otp)));
    }
}
