package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.BankAdvisorConfig;
import com.cobis.gestionasesores.data.models.Parameter;
import com.cobis.gestionasesores.data.models.responses.ParameterResponse;
import com.cobis.gestionasesores.data.repositories.ParametersRepository;
import com.cobis.gestionasesores.data.source.SyncDataSource;
import com.cobis.gestionasesores.domain.businesslogic.InitManager;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by Miguel on 17/07/2017.
 */

public class InitializeAppUseCase extends UseCase<Integer[],Boolean> {

    private SyncDataSource mSyncDataSource;

    public InitializeAppUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    public InitializeAppUseCase(SyncDataSource mSyncDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        this.mSyncDataSource = mSyncDataSource;
    }

    @Override
    protected Observable<Boolean> createObservableUseCase(final Integer[] parameter) {
        return Observable.fromCallable(new Callable<Boolean>() {
            @Override
            public Boolean call() throws Exception {
                InitManager manager = new InitManager(parameter[0],parameter[1]);
                boolean catalogSuccess = manager.checkCatalogsUpdate();
                boolean postalCodeSuccess = manager.checkPostalCodesUpdate();

                ParameterResponse parameterResponse = manager.getParametersApp();
                boolean getParameters = parameterResponse.isResult();
                if (getParameters) {
                    BankAdvisorConfig bankAdvisorConfig = BankAdvisorApp.getInstance().getConfig();

                    Map<String, String> remoteConfig = new HashMap<>();
                    for (Parameter parameter : parameterResponse.getData().getData()) {
                        remoteConfig.put(parameter.getKey(), parameter.getValue());
                    }

                    BankAdvisorApp.getInstance().setmConfig(new BankAdvisorConfig.Builder()
                            .setRemoteConfig(remoteConfig)
                            .setDefaultConfig(bankAdvisorConfig.getDefaultConfig())
                            .setDeveloperModeEnabled(bankAdvisorConfig.isDeveloperModeEnabled())
                            .setLocale(bankAdvisorConfig.getLocale())
                            .setEnvironmentSelectorEnabled(bankAdvisorConfig.isEnvironmentSelectorEnabled())
                            .setEnvironment(bankAdvisorConfig.getEnvironment())
                            .setDataBaseEncrypted(bankAdvisorConfig.isDataBaseEncrypted())
                            .setSslKeyStoreEnabled(bankAdvisorConfig.isSslKeystoreEnabled())
                            .build());

                    ParametersRepository.getInstance().clearValuesRemoteParameters();
                    ParametersRepository.getInstance().saveRemoteParameter(parameterResponse.getData().getData());
                }

                return catalogSuccess && postalCodeSuccess && getParameters;
            }
        });
    }
}
