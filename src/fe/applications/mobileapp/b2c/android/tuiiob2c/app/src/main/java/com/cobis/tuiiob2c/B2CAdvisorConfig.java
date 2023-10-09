package com.cobis.tuiiob2c;

import com.cobis.tuiiob2c.data.enums.Environment;

import java.util.Locale;

/**
 * Wrap Application configurations parameters (Local and remote)
 */

public class B2CAdvisorConfig {
    private boolean isDeveloperModeEnabled;
    private boolean isEnvironmentSelectorEnabled;
    private boolean isSslKeystoreEnabled;
    private Locale locale;
    private Environment environment;

    private B2CAdvisorConfig(Builder builder){
        isDeveloperModeEnabled = builder.isDeveloperModeEnabled;
        locale = builder.locale;
        environment = builder.environment;
        isEnvironmentSelectorEnabled = builder.isEnvironmentSelectorEnabled;
        isSslKeystoreEnabled = builder.isSslKeystoreEnabled;
    }

    /**
     * Gets current locale configured for the project
     * @return Locale
     */
    public Locale getLocale() {
        return locale;
    }

    /**
     * Indicates the status of the developer mode setting.
     * @return true if the developer mode is enabled, false otherwise.
     */
    public boolean isDeveloperModeEnabled() {
        return isDeveloperModeEnabled;
    }

    public boolean isEnvironmentSelectorEnabled() {
        return isEnvironmentSelectorEnabled;
    }

    public boolean isSslKeystoreEnabled() {
        return isSslKeystoreEnabled;
    }



    public void setSslKeystoreEnabled(boolean isSslKeystoreEnabled){
        this.isSslKeystoreEnabled = isSslKeystoreEnabled;
    }

    public void setEnvironment(Environment environment){
        this.environment = environment;
    }
    /**
     * Indicates the environment that the app uses to perform web service requests.
     * @return Currently configured web service environment
     */
    public Environment getEnvironment() {
        return environment;
    }

    public static class Builder{
        private boolean isDeveloperModeEnabled;
        private boolean isEnvironmentSelectorEnabled;
        private boolean isSslKeystoreEnabled;
        private Locale locale;
        private Environment environment;

        public Builder setDeveloperModeEnabled(boolean developerModeEnabled) {
            isDeveloperModeEnabled = developerModeEnabled;
            return this;
        }

        public Builder setLocale(Locale locale) {
            this.locale = locale;
            return this;
        }

        public Builder setEnvironment(Environment environment) {
            this.environment = environment;
            return this;
        }

        public Builder setEnvironmentSelectorEnabled(boolean environmentSelectorEnabled) {
            isEnvironmentSelectorEnabled = environmentSelectorEnabled;
            return this;
        }

        public Builder setSslKeyStoreEnabled(boolean isSslKeystoreEnabled){
            this.isSslKeystoreEnabled = isSslKeystoreEnabled;
            return this;
        }

        public B2CAdvisorConfig build(){
            return new B2CAdvisorConfig(this);
        }
    }
}
