package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.mainActivity.settings.SettingsMVP;
import com.cobis.tuiiob2c.presentation.mainActivity.settings.SettingsPresenter;
import com.cobis.tuiiob2c.repositories.LockUnlockRepository;
import com.cobis.tuiiob2c.services.modules.LockUnlockApi;
import com.cobis.tuiiob2c.usecases.LockUnlockUseCase;
import com.cobis.tuiiob2c.usecases.source.LockSource;

import dagger.Module;
import dagger.Provides;

@Module
public class SettingsModule {

    @Provides
    public SettingsMVP.SettingsPresenter providerSettingsPresenter(SettingsMVP.SettingsModel settingsModel) {
        return new SettingsPresenter(settingsModel);
    }

    @Provides
    public SettingsMVP.SettingsModel providerSettingsModel(LockSource lockSource) {
        return new LockUnlockUseCase(lockSource);
    }

    @Provides
    public LockSource providerSettingsSource(LockUnlockApi lockUnlockApi) {
        return new LockUnlockRepository(lockUnlockApi);
    }
}
