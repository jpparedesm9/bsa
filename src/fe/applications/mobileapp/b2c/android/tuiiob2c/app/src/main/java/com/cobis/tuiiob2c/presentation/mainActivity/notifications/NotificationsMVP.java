package com.cobis.tuiiob2c.presentation.mainActivity.notifications;

import com.cobis.tuiiob2c.data.enums.ResponseMessageType;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Notification;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import java.util.List;

import io.reactivex.Observable;

public interface NotificationsMVP {

    interface NotificationsModel {

        Observable<BaseModel> sendResponseMessage(int messageId, String response);
    }

    interface NotificationsView extends BaseView {

        void showMessages(List<Notification> notificationList);

        void showMessageResponseSuccess();

        void showMessageResponseError(String message);
    }

    interface NotificationsPresenter extends BasePresenter {

        void setView(NotificationsMVP.NotificationsView notificationsView);

        void onSendResponseMessage(String messageId, @ResponseMessageType String response);
    }
}
