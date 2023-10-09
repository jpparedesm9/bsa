package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.mainActivity.notifications.NotificationsMVP;
import com.cobis.tuiiob2c.presentation.mainActivity.notifications.NotificationsPresenter;
import com.cobis.tuiiob2c.repositories.NotificationsRepository;
import com.cobis.tuiiob2c.services.modules.MessageApi;
import com.cobis.tuiiob2c.usecases.NotificationsUseCase;
import com.cobis.tuiiob2c.usecases.source.NotificationsSource;

import dagger.Module;
import dagger.Provides;

@Module
public class NotificationsModule {

    @Provides
    public NotificationsMVP.NotificationsPresenter providerNotificationsPresenter(NotificationsMVP.NotificationsModel notificationsModel) {
        return new NotificationsPresenter(notificationsModel);
    }

    @Provides
    public NotificationsMVP.NotificationsModel providerNotificationsModel(NotificationsSource notificationsSource) {
        return new NotificationsUseCase(notificationsSource);
    }

    @Provides
    public NotificationsSource providerNotificationsSource(MessageApi messageApi) {
        return new NotificationsRepository(messageApi);
    }
}
