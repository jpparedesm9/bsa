package com.cobis.gestionasesores;

import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.data.repositories.ParametersRepository;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.utils.Util;

import java.util.Locale;
import java.util.Map;

/**
 * Created by Jose on 11/1/2017.
 */

public class AppConfig extends BankAdvisorApp {
    @Override
    public BankAdvisorConfig buildConfig() {
        Map<String, String> remoteConfig = ParametersRepository.getInstance().getAll();

        String preferencesEnvironment = SessionManager.getInstance().getLastEnviromentSwitch();
        Environment environment;
        if (preferencesEnvironment.isEmpty()) {
            environment = Environment.PROD;
        } else {
            environment = Environment.valueOf(preferencesEnvironment);
        }

        return new BankAdvisorConfig.Builder()
                .setRemoteConfig(remoteConfig)
                .setDefaultConfig(Util.parseParameters(getResources().getXml(R.xml.default_config)))
                .setDeveloperModeEnabled(true)
                .setLocale(Locale.US)
                .setEnvironmentSelectorEnabled(true)
                .setEnvironment(environment)
                .setDataBaseEncrypted(true)
                .setSslKeyStoreEnabled(false)
                .build();
    }
}
