package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.mainActivity.home.HomeMVP;
import com.cobis.tuiiob2c.presentation.mainActivity.home.HomePresenter;
import com.cobis.tuiiob2c.repositories.LoanRepository;
import com.cobis.tuiiob2c.services.modules.LoanApi;
import com.cobis.tuiiob2c.usecases.LoanInfoUseCase;
import com.cobis.tuiiob2c.usecases.source.LoanSource;

import dagger.Module;
import dagger.Provides;

@Module
public class HomeModule {

    @Provides
    public HomeMVP.HomePresenter providerHomePresenter(HomeMVP.HomeModel homeModel) {
        return new HomePresenter(homeModel);
    }

    @Provides
    public HomeMVP.HomeModel providerHomeModel(LoanSource loanSource) {
        return new LoanInfoUseCase(loanSource);
    }

    @Provides
    public LoanSource providerHomeSource(LoanApi loanApi) {
        return new LoanRepository(loanApi);
    }
}
