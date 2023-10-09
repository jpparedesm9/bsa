package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.unlock.UnlockMVP;
import com.cobis.tuiiob2c.presentation.unlock.UnlockPresenter;
import com.cobis.tuiiob2c.repositories.LockUnlockRepository;
import com.cobis.tuiiob2c.services.modules.LockUnlockApi;
import com.cobis.tuiiob2c.usecases.LockUnlockUseCase;
import com.cobis.tuiiob2c.usecases.source.UnlockSource;

import dagger.Module;
import dagger.Provides;

@Module
public class UnlockModule {

    @Provides
    public UnlockMVP.UnlockPresenter providerUnlockPresenter(UnlockMVP.UnlockModel unlockModel) {
        return new UnlockPresenter(unlockModel);
    }

    @Provides
    public UnlockMVP.UnlockModel providerUnlockModel(UnlockSource unlockSource) {
        return new LockUnlockUseCase(unlockSource);
    }

    @Provides
    public UnlockSource providerUnlockSource(LockUnlockApi lockUnlockApi) {
        return new LockUnlockRepository(lockUnlockApi);
    }
}
