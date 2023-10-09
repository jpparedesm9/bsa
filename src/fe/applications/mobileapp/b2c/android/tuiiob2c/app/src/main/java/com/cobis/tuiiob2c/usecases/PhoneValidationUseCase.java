package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Enrollment;
import com.cobis.tuiiob2c.data.models.requests.PhoneValidationOtpRequest;
import com.cobis.tuiiob2c.data.models.requests.PhoneValidationRequest;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationMVP;
import com.cobis.tuiiob2c.presentation.phoneValidation.PhoneValidationMVP;
import com.cobis.tuiiob2c.usecases.source.OtpVerificationSource;
import com.cobis.tuiiob2c.usecases.source.PhoneValidationSource;

import io.reactivex.Observable;

public class PhoneValidationUseCase implements PhoneValidationMVP.PhoneValidationModel, OtpVerificationMVP.OtpVerificationModel {

    private PhoneValidationSource phoneValidationSource;
    private OtpVerificationSource otpVerificationSource;

    public PhoneValidationUseCase(PhoneValidationSource phoneValidationSource) {
        this.phoneValidationSource = phoneValidationSource;
    }

    public PhoneValidationUseCase(OtpVerificationSource otpVerificationSource) {
        this.otpVerificationSource = otpVerificationSource;
    }

    @Override
    public Observable<BaseModel> changePhone(String phone) {
        return Observable.fromCallable(() -> {
            BaseModel baseModel = phoneValidationSource.changePhone(new PhoneValidationRequest(phone));
            if (baseModel.isResult()) {
                SessionManager sessionManager = SessionManager.getInstance();
                Enrollment enrollment = sessionManager.getValuesEnrollment();
                enrollment.setTelefono(phone);

                sessionManager.saveValuesEnrollment(enrollment);
            }
            return baseModel;
        });
    }

    @Override
    public Observable<BaseModel> changePhoneOtp(String otp) {
        return Observable.fromCallable(() -> otpVerificationSource.changePhoneOtp(new PhoneValidationOtpRequest(Integer.parseInt(otp))));
    }
}
