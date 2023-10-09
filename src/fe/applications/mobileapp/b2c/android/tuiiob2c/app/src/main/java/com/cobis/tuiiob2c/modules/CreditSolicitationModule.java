package com.cobis.tuiiob2c.modules;

import com.cobis.tuiiob2c.presentation.creditSolicitation.CreditSolicitationMVP;
import com.cobis.tuiiob2c.presentation.creditSolicitation.CreditSolicitationPresenter;
import com.cobis.tuiiob2c.repositories.LoanRepository;
import com.cobis.tuiiob2c.services.modules.LoanApi;
import com.cobis.tuiiob2c.usecases.OtpCreditVerificationUseCase;
import com.cobis.tuiiob2c.usecases.source.CreditSolicitationSource;

import dagger.Module;
import dagger.Provides;

@Module
public class CreditSolicitationModule {

    @Provides
    public CreditSolicitationMVP.CreditSolicitationPresenter providerCreditSolicitationPresenter(CreditSolicitationMVP.CreditSolicitationModel creditSolicitationModel) {
        return new CreditSolicitationPresenter(creditSolicitationModel);
    }

    @Provides
    public CreditSolicitationMVP.CreditSolicitationModel providerCreditSolicitationModel(CreditSolicitationSource creditSolicitationSource) {
        return new OtpCreditVerificationUseCase(creditSolicitationSource);
    }

    @Provides
    public CreditSolicitationSource providerCreditSolicitationSource(LoanApi loanApi) {
        return new LoanRepository(loanApi);
    }
}
