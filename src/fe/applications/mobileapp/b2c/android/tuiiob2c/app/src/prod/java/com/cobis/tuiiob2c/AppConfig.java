package com.cobis.tuiiob2c;

import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.root.App;

import java.util.Locale;

public class AppConfig extends App {

    @Override
    public B2CAdvisorConfig buildConfig() {
        String preferencesEnvironment = SessionManager.getInstance().getLastEnviromentSwitch();
        Environment environment;
        if (preferencesEnvironment.isEmpty()) {
            environment = Environment.PROD;
        } else {
            environment = Environment.valueOf(preferencesEnvironment);
        }

        return new B2CAdvisorConfig.Builder()
                .setDeveloperModeEnabled(false)
                .setLocale(Locale.US)
                .setEnvironmentSelectorEnabled(false)
                .setEnvironment(environment)
                .setSslKeyStoreEnabled(true)
                .build();
    }
}
