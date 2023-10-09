package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.CommissionTable;
import com.cobis.tuiiob2c.data.models.MessagePin;
import com.cobis.tuiiob2c.data.models.Notification;
import com.cobis.tuiiob2c.data.models.requests.MessageRequest;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.mainActivity.notifications.NotificationsMVP;
import com.cobis.tuiiob2c.presentation.otpMessageVerification.OtpMessageVerificationMVP;
import com.cobis.tuiiob2c.usecases.source.NotificationsPinSource;
import com.cobis.tuiiob2c.usecases.source.NotificationsSource;

import java.util.List;

import io.reactivex.Observable;

public class NotificationsUseCase implements NotificationsMVP.NotificationsModel, OtpMessageVerificationMVP.OtpMessageVerificationModel {

    private NotificationsSource notificationsSource;
    private NotificationsPinSource notificationsPinSource;

    public NotificationsUseCase(NotificationsSource notificationsSource) {
        this.notificationsSource = notificationsSource;
    }

    public NotificationsUseCase(NotificationsPinSource notificationsPinSource) {
        this.notificationsPinSource = notificationsPinSource;
    }

    @Override
    public Observable<BaseModel> sendResponseMessage(int messageId, String response) {
        return Observable.fromCallable(() -> {
            BaseModel baseModel = notificationsSource.responseMessage(new MessageRequest(messageId, response));
            if (baseModel.isResult()) {
                CommissionTable commissionTable = SessionManager.getInstance().getParameters();
                List<Notification> notificationList = commissionTable.getNotificaciones();
                for (int i = 0; i < notificationList.size(); i++) {
                    if (notificationList.get(i).getId().equalsIgnoreCase(Integer.toString(messageId))) {
                        notificationList.remove(i);
                        break;
                    }
                }

                commissionTable.setNotificaciones(notificationList);
                SessionManager.getInstance().saveParameters(commissionTable);
            }

            return baseModel;
        });
    }

    @Override
    public Observable<BaseModel> sendResponseMessagePin(int messageId, String response, String password) {
        return Observable.fromCallable(() -> {
            BaseModel baseModel = notificationsPinSource.responseMessagePin(new MessagePin(messageId, response, password));
            if (baseModel.isResult()) {
                CommissionTable commissionTable = SessionManager.getInstance().getParameters();
                List<Notification> notificationList = commissionTable.getNotificaciones();
                for (int i = 0; i < notificationList.size(); i++) {
                    if (notificationList.get(i).getId().equalsIgnoreCase(Integer.toString(messageId))) {
                        notificationList.remove(i);
                        break;
                    }
                }

                commissionTable.setNotificaciones(notificationList);
                SessionManager.getInstance().saveParameters(commissionTable);
            }

            return baseModel;
        });
    }
}
