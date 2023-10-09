package com.cobis.tuiiob2c.presentation.mainActivity.settings;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface SettingsMVP {

    interface SettingsModel {

        Observable<BaseModel> lock();
    }

    interface SettingsView extends BaseView {

        void showLockSuccess();

        void showLockResponseError(String message);
    }

    interface SettingsPresenter extends BasePresenter {

        void setView(SettingsMVP.SettingsView settingsView);

        void onLock();
    }
}
