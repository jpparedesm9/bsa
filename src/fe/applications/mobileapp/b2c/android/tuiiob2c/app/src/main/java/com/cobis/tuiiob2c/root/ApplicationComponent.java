package com.cobis.tuiiob2c.root;

import com.cobis.tuiiob2c.modules.ChangePasswordModule;
import com.cobis.tuiiob2c.modules.CreatePasswordModule;
import com.cobis.tuiiob2c.modules.CreditSolicitationModule;
import com.cobis.tuiiob2c.modules.EnrollmentModule;
import com.cobis.tuiiob2c.modules.ForgotPasswordModule;
import com.cobis.tuiiob2c.modules.HomeModule;
import com.cobis.tuiiob2c.modules.LoginModule;
import com.cobis.tuiiob2c.modules.NotificationsModule;
import com.cobis.tuiiob2c.modules.OtpCreditVerificationModule;
import com.cobis.tuiiob2c.modules.OtpMessageVerificationModule;
import com.cobis.tuiiob2c.modules.OtpVerificationModule;
import com.cobis.tuiiob2c.modules.PhoneValidationModule;
import com.cobis.tuiiob2c.modules.ResetPasswordModule;
import com.cobis.tuiiob2c.modules.SettingsModule;
import com.cobis.tuiiob2c.modules.UnlockModule;
import com.cobis.tuiiob2c.presentation.changePassword.ChangePasswordFragment;
import com.cobis.tuiiob2c.presentation.createPassword.CreatePasswordFragment;
import com.cobis.tuiiob2c.presentation.creditSolicitation.CreditSolicitationFragment;
import com.cobis.tuiiob2c.presentation.enrollment.EnrollmentFragment;
import com.cobis.tuiiob2c.presentation.forgotPassword.ForgotPasswordFragment;
import com.cobis.tuiiob2c.presentation.login.LoginFragment;
import com.cobis.tuiiob2c.presentation.mainActivity.home.HomeFragment;
import com.cobis.tuiiob2c.presentation.mainActivity.notifications.NotificationsFragment;
import com.cobis.tuiiob2c.presentation.mainActivity.settings.SettingsFragment;
import com.cobis.tuiiob2c.presentation.otpCreditVerification.OtpCreditVerificationFragment;
import com.cobis.tuiiob2c.presentation.otpMessageVerification.OtpMessageVerificationFragment;
import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationFragment;
import com.cobis.tuiiob2c.presentation.phoneValidation.PhoneValidationFragment;
import com.cobis.tuiiob2c.presentation.resetPassword.ResetPasswordFragment;
import com.cobis.tuiiob2c.presentation.unlock.UnlockFragment;
import com.cobis.tuiiob2c.services.HttpApiModule;
import com.cobis.tuiiob2c.services.HttpAuthModule;

import javax.inject.Singleton;

import dagger.Component;

@Singleton
@Component(modules = {
        ApplicationModule.class,
        HttpAuthModule.class,
        HttpApiModule.class,
        LoginModule.class,
        EnrollmentModule.class,
        CreatePasswordModule.class,
        OtpVerificationModule.class,
        ForgotPasswordModule.class,
        ResetPasswordModule.class,
        PhoneValidationModule.class,
        ChangePasswordModule.class,
        CreditSolicitationModule.class,
        OtpCreditVerificationModule.class,
        HomeModule.class,
        NotificationsModule.class,
        OtpMessageVerificationModule.class,
        SettingsModule.class,
        UnlockModule.class})

public interface ApplicationComponent {

    void injectLogin(LoginFragment target);

    void injectEnrollment(EnrollmentFragment target);

    void injectCreatePassword(CreatePasswordFragment target);

    void injectOtpVerification(OtpVerificationFragment target);

    void injectForgotPassword(ForgotPasswordFragment target);

    void injectResetPassword(ResetPasswordFragment target);

    void injectPhoneValidation(PhoneValidationFragment target);

    void injectChangePassword(ChangePasswordFragment target);

    void injectCreditSolicitation(CreditSolicitationFragment target);

    void injectOtpCreditVerification(OtpCreditVerificationFragment target);

    void injectHome(HomeFragment target);

    void injectNotifications(NotificationsFragment target);

    void injectOtpMessageVerification(OtpMessageVerificationFragment target);

    void injectSettings(SettingsFragment target);

    void injectUnlock(UnlockFragment target);
}
