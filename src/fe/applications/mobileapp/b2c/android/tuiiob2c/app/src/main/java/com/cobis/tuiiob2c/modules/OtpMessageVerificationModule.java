package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.otpMessageVerification.OtpMessageVerificationMVP;
import com.cobis.tuiiob2c.presentation.otpMessageVerification.OtpMessageVerificationPresenter;
import com.cobis.tuiiob2c.repositories.NotificationsRepository;
import com.cobis.tuiiob2c.services.modules.MessageApi;
import com.cobis.tuiiob2c.usecases.NotificationsUseCase;
import com.cobis.tuiiob2c.usecases.source.NotificationsPinSource;

import dagger.Module;
import dagger.Provides;

@Module
public class OtpMessageVerificationModule {

    @Provides
    public OtpMessageVerificationMVP.OtpMessageVerificationPresenter providerMessageVerificationPresenter(OtpMessageVerificationMVP.OtpMessageVerificationModel otpMessageVerificationModel) {
        return new OtpMessageVerificationPresenter(otpMessageVerificationModel);
    }

    @Provides
    public OtpMessageVerificationMVP.OtpMessageVerificationModel providerMessageVerificationModel(NotificationsPinSource notificationsPinSource) {
        return new NotificationsUseCase(notificationsPinSource);
    }

    @Provides
    public NotificationsPinSource providerMessageVerificationSource(MessageApi messageApi) {
        return new NotificationsRepository(messageApi);
    }
}
