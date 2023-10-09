package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.phoneValidation.PhoneValidationMVP;
import com.cobis.tuiiob2c.presentation.phoneValidation.PhoneValidationPresenter;
import com.cobis.tuiiob2c.repositories.PhoneValidationRepository;
import com.cobis.tuiiob2c.services.modules.PhoneValidationApi;
import com.cobis.tuiiob2c.usecases.PhoneValidationUseCase;
import com.cobis.tuiiob2c.usecases.source.PhoneValidationSource;

import dagger.Module;
import dagger.Provides;

@Module
public class PhoneValidationModule {

    @Provides
    public PhoneValidationMVP.PhoneValidationPresenter providerPhoneValidationPresenter(PhoneValidationMVP.PhoneValidationModel phoneValidationModel) {
        return new PhoneValidationPresenter(phoneValidationModel);
    }

    @Provides
    public PhoneValidationMVP.PhoneValidationModel providerPhoneValidationModel(PhoneValidationSource phoneValidationSource) {
        return new PhoneValidationUseCase(phoneValidationSource);
    }

    @Provides
    public PhoneValidationSource providerPhoneValidationSource(PhoneValidationApi phoneValidationApi) {
        return new PhoneValidationRepository(phoneValidationApi);
    }
}
