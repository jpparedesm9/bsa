package com.cobis.tuiiob2c.presentation.mainActivity.notifications;

import com.cobis.tuiiob2c.data.enums.ResponseMessageType;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.infraestructure.SessionManager;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class NotificationsPresenter implements NotificationsMVP.NotificationsPresenter {

    private NotificationsMVP.NotificationsView notificationsView;
    private NotificationsMVP.NotificationsModel notificationsModel;

    private Disposable disposable;

    public NotificationsPresenter(NotificationsMVP.NotificationsModel notificationsModel) {
        this.notificationsModel = notificationsModel;
    }

    @Override
    public void setView(NotificationsMVP.NotificationsView notificationsView) {
        this.notificationsView = notificationsView;
    }

    @Override
    public void start() {
        notificationsView.showMessages(SessionManager.getInstance().getParameters().getNotificaciones());
    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }

    @Override
    public void onSendResponseMessage(String messageId, @ResponseMessageType String response) {
        notificationsView.showLoading();
        disposable = notificationsModel.sendResponseMessage(Integer.parseInt(messageId), response)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<BaseModel>() {
                    @Override
                    public void onNext(BaseModel baseModel) {
                        if (baseModel.isResult()) {
                            notificationsView.showMessageResponseSuccess();
                        } else {
                            notificationsView.showMessageResponseError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        notificationsView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        notificationsView.hideLoading();
                    }
                });
    }
}
