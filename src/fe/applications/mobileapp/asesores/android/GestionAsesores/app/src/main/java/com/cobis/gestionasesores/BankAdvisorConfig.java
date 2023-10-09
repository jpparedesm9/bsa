package com.cobis.gestionasesores;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.data.enums.Parameters;

import java.util.Locale;
import java.util.Map;

/**
 * Wrap Application configurations parameters (Local and remote)
 * Created by mnaunay on 26/06/2017.
 */

public class BankAdvisorConfig {
    private boolean isDeveloperModeEnabled;
    private boolean isEnvironmentSelectorEnabled;
    private boolean isDataBaseEncrypted;
    private boolean isSslKeystoreEnabled;
    private Map<String,String> remoteConfig;
    private Map<String,String> defaultConfig;
    private Locale locale = Locale.US;
    private Environment environment;

    private BankAdvisorConfig(Builder builder){
        isDeveloperModeEnabled = builder.isDeveloperModeEnabled;
        remoteConfig = builder.remoteConfig;
        defaultConfig = builder.defaultConfig;
        locale = builder.locale;
        environment = builder.environment;
        isEnvironmentSelectorEnabled = builder.isEnvironmentSelectorEnabled;
        isDataBaseEncrypted = builder.isDataBaseEncrypted;
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
     * Gets the value corresponding to the specified key, as a boolean
     * @param key The Remote Config parameter key to look up.
     * @return Value as a boolean
     */
    public boolean getBoolean(@Parameters String key){
        if(remoteConfig.containsKey(key)){
            return ConvertUtils.tryToBoolean(remoteConfig.get(key),false);
        }else{
            return ConvertUtils.tryToBoolean(defaultConfig.get(key),false);
        }

    }

    /**
     * Gets the value corresponding to the specified key, as a double
     * @param key The Remote Config parameter key to look up.
     * @return Value as a double
     */
    public double getDouble(@Parameters String key){
        if(remoteConfig.containsKey(key)) {
            return ConvertUtils.tryToDouble(remoteConfig.get(key), 0.0);
        }else{
            return ConvertUtils.tryToDouble(defaultConfig.get(key), 0.0);
        }
    }

    /**
     * Gets the value corresponding to the specified key, as a string
     * @param key The Remote Config parameter key to look up.
     * @return Value as a string
     */
    public String getString(@Parameters String key){
        if(remoteConfig.containsKey(key)) {
            return remoteConfig.get(key);
        }else{
            return defaultConfig.get(key);
        }
    }

    /**
     * Gets the value corresponding to the specified key, as a integer
     * @param key The Remote Config parameter key to look up.
     * @return Value as a integer
     */
    public int getInteger(@Parameters String key){
        if(remoteConfig.containsKey(key)) {
            return ConvertUtils.tryToInt(remoteConfig.get(key), 0);
        }else{
            return ConvertUtils.tryToInt(defaultConfig.get(key), 0);
        }
    }

    /**
     * Gets the value corresponding to the specified key, as a long
     * @param key The Remote Config parameter key to look up.
     * @return Value as a long
     */
    public long getLong(@Parameters String key){
        if(remoteConfig.containsKey(key)) {
            return ConvertUtils.tryToLong(remoteConfig.get(key), 0L);
        }else{
            return ConvertUtils.tryToLong(defaultConfig.get(key), 0L);
        }
    }

    /**
     * Gets the value corresponding to the specified key, as a float
     * @param key The Remote Config parameter key to look up.
     * @return Value as a float
     */
    public float getFloat(@Parameters String key){
        if(remoteConfig.containsKey(key)) {
            return ConvertUtils.tryToFloat(remoteConfig.get(key), 0.0F);
        }else{
            return ConvertUtils.tryToFloat(defaultConfig.get(key), 0.0F);
        }
    }

    /**
     * Indicates if database have to encrypted or not
     * @return True if is encrypted, false to otherwise
     */
    public boolean isDataBaseEncrypted() {
        return isDataBaseEncrypted;
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

    public Map<String, String> getRemoteConfig() {
        return remoteConfig;
    }

    public Map<String, String> getDefaultConfig() {
        return defaultConfig;
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
        private Map<String,String> remoteConfig;
        private Map<String,String> defaultConfig;
        private Environment environment;
        private boolean isDataBaseEncrypted;

        public Builder setRemoteConfig(Map<String, String> remoteConfig) {
            this.remoteConfig = remoteConfig;

            return this;
        }

        public Builder setDataBaseEncrypted(boolean dataBaseEncrypted) {
            isDataBaseEncrypted = dataBaseEncrypted;
            return this;
        }

        public Builder setDeveloperModeEnabled(boolean developerModeEnabled) {
            isDeveloperModeEnabled = developerModeEnabled;
            return this;
        }

        public Builder setDefaultConfig(Map<String, String> defaultConfig) {
            this.defaultConfig = defaultConfig;
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

        public BankAdvisorConfig build(){
            return new BankAdvisorConfig(this);
        }
    }
}
