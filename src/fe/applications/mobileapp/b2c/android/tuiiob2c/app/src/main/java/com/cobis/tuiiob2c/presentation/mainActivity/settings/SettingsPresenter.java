package com.cobis.tuiiob2c.presentation.mainActivity.settings;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class SettingsPresenter implements SettingsMVP.SettingsPresenter {

    private SettingsMVP.SettingsView settingsView;
    private SettingsMVP.SettingsModel settingsModel;

    private Disposable disposable;

    public SettingsPresenter(SettingsMVP.SettingsModel settingsModel) {
        this.settingsModel = settingsModel;
    }

    @Override
    public void setView(SettingsMVP.SettingsView settingsView) {
        this.settingsView = settingsView;
    }

    @Override
    public void start() {

    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }

    @Override
    public void onLock() {
        settingsView.showLoading();
        disposable = settingsModel.lock()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<BaseModel>() {
                    @Override
                    public void onNext(BaseModel baseModel) {
                        if (baseModel.isResult()) {
                            settingsView.showLockSuccess();
                        } else {
                            settingsView.showLockResponseError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        settingsView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        settingsView.hideLoading();
                    }
                });
    }
}
