package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.CreatePasswordRequest;
import com.cobis.tuiiob2c.data.models.requests.ResetPasswordRequest;
import com.cobis.tuiiob2c.data.models.requests.UpdatePasswordRequest;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.changePassword.ChangePasswordMVP;
import com.cobis.tuiiob2c.presentation.createPassword.CreatePasswordMVP;
import com.cobis.tuiiob2c.presentation.resetPassword.ResetPasswordMVP;
import com.cobis.tuiiob2c.usecases.source.CreatePasswordSource;
import com.cobis.tuiiob2c.usecases.source.ResetPasswordSource;
import com.cobis.tuiiob2c.usecases.source.UpdatePasswordSource;

import io.reactivex.Observable;

public class CreatePasswordUseCase implements CreatePasswordMVP.CreatePasswordModel, ChangePasswordMVP.ChangePasswordModel, ResetPasswordMVP.ResetPasswordModel {

    private CreatePasswordSource createPasswordSource;
    private UpdatePasswordSource updatePasswordSource;
    private ResetPasswordSource resetPasswordSource;

    public CreatePasswordUseCase(CreatePasswordSource createPasswordSource) {
        this.createPasswordSource = createPasswordSource;
    }

    public CreatePasswordUseCase(UpdatePasswordSource updatePasswordSource) {
        this.updatePasswordSource = updatePasswordSource;
    }

    public CreatePasswordUseCase(ResetPasswordSource resetPasswordSource) {
        this.resetPasswordSource = resetPasswordSource;
    }

    @Override
    public Observable<BaseModel> validateCreatePassword(String password) {
        return Observable.fromCallable(() -> {
            BaseModel baseModel = createPasswordSource.validatePasswords(new CreatePasswordRequest(password));
            if (baseModel.isResult()) {
                SessionManager sessionManager = SessionManager.getInstance();
                sessionManager.saveStatusEnrollment(true);
            }
            return baseModel;
        });
    }

    @Override
    public Observable<BaseModel> validateChangePassword(String oldPAssword, String newPassword) {
        return Observable.fromCallable(() -> updatePasswordSource.validateChangePassword(new UpdatePasswordRequest(oldPAssword, newPassword)));
    }

    @Override
    public Observable<BaseModel> validateResetPassword(String password) {
        return Observable.fromCallable(() -> resetPasswordSource.resetPassword(new ResetPasswordRequest(SessionManager.getInstance().getValuesEnrollment().getTelefono(), password)));
    }
}
