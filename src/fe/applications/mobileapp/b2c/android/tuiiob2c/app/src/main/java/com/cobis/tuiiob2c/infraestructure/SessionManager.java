package com.cobis.tuiiob2c.infraestructure;

import android.content.Context;
import android.content.SharedPreferences;

import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.data.models.CommissionTable;
import com.cobis.tuiiob2c.data.models.Enrollment;
import com.google.gson.Gson;
import com.securepreferences.SecurePreferences;

import java.util.Calendar;

public final class SessionManager {

    private static Context appContext = null;

    private static final String PREF_APP = "app-data";

    private final String PREF_USER_ENROLLMENT = "PREF_USER_ENROLLMENT";
    private final String USER_ENROLLMENT_REGISTRY_CODE = "USER_ENROLLMENT_REGISTRY_CODE";
    private final String USER_ENROLLMENT_NAMES = "USER_ENROLLMENT_NAMES";
    private final String USER_ENROLLMENT_LASTNAMES = "USER_ENROLLMENT_LASTNAMES";
    private final String USER_ENROLLMENT_PHONE = "USER_ENROLLMENT_PHONE";
    private final String USER_ENROLLMENT_ID_CLIENTE = "USER_ENROLLMENT_ID_CLIENTE";
    private final String USER_ENROLLMENT_STATUS = "USER_ENROLLMENT_STATUS";
    private final String USER_ENROLLMENT_PROCEDURE_NUMBER = "USER_ENROLLMENT_PROCEDURE_NUMBER";
    private final String USER_ENROLLMENT_CREDIT_NUMBER = "USER_ENROLLMENT_CREDIT_NUMBER";

    private final String PREF_PARAMATERS_FOR_CALCULATE = "PARAMATERS_CALCULATE";
    private final String PARAMETERS = "PARAMETERS";

    private static final String KEY_TIME_LAST_CHANGE_ENVIRONMENT = "KEY_TIME_LAST_CHANGE_ENVIRONMENT";
    private static final String KEY_ENVIRONMENT = "KEY_ENVIRONMENT";
    private static final String KEY_INACTIVITY_TIMEOUT = "inactivity_timeout";

    private static final int MINIMUM_TIMEOUT = 300; //Seconds


    private static SessionManager sInstance = null;

    private SharedPreferences sharedPreferencesEnrollment;
    private SharedPreferences sharedPreferencesParameters;
    private SharedPreferences mPrefApp;

    private SessionManager() {
        mPrefApp = new SecurePreferences(appContext,KManager.getInstance().getPreferenceKey(),PREF_APP);
        sharedPreferencesEnrollment = new SecurePreferences(appContext, KManager.getInstance().getPreferenceKey(),PREF_USER_ENROLLMENT);
        sharedPreferencesParameters =  new SecurePreferences(appContext,KManager.getInstance().getPreferenceKey(),PREF_PARAMATERS_FOR_CALCULATE);
    }

    public static SessionManager getInstance() {
        if (sInstance == null) {
            sInstance = new SessionManager();
        }
        return sInstance;
    }

    public static void setAppContext(Context context) {
        if (context != null && appContext == null) {
            appContext = context;
        }

    }

    public void saveStatusEnrollment(boolean status) {
        SharedPreferences.Editor editor = sharedPreferencesEnrollment.edit();
        editor.putBoolean(USER_ENROLLMENT_STATUS, status);

        editor.apply();
    }

    public boolean getStatusEnrollment() {
        return sharedPreferencesEnrollment.getBoolean(USER_ENROLLMENT_STATUS, false);
    }

    public void saveValuesEnrollment(Enrollment enrollment) {
        SharedPreferences.Editor editor = sharedPreferencesEnrollment.edit();
        editor.putString(USER_ENROLLMENT_REGISTRY_CODE, enrollment.getRegistryCode());
        editor.putString(USER_ENROLLMENT_NAMES, enrollment.getNombres());
        editor.putString(USER_ENROLLMENT_LASTNAMES, enrollment.getApellidos());
        editor.putString(USER_ENROLLMENT_PHONE, enrollment.getTelefono());
        editor.putString(USER_ENROLLMENT_ID_CLIENTE, enrollment.getIdCliente());
        editor.putString(USER_ENROLLMENT_PROCEDURE_NUMBER, enrollment.getNumeroTramite());
        editor.putString(USER_ENROLLMENT_CREDIT_NUMBER, enrollment.getNumeroCredito());

        editor.apply();
    }

    public Enrollment getValuesEnrollment() {
        return new Enrollment.Builder()
                .addRegistryCode(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_REGISTRY_CODE, null))
                .addNombres(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_NAMES, null))
                .addApellidos(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_LASTNAMES, null))
                .addTelefono(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_PHONE, null))
                .addIdCliente(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_ID_CLIENTE, null))
                .addNumeroTramite(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_PROCEDURE_NUMBER, null))
                .addNumeroCredito(sharedPreferencesEnrollment.getString(USER_ENROLLMENT_CREDIT_NUMBER, null))
                .build();
    }

    public void saveParameters(CommissionTable commissionTable) {
        SharedPreferences.Editor editor = sharedPreferencesParameters.edit();
        editor.putString(PARAMETERS, new Gson().toJson(commissionTable));

        editor.apply();
    }

    public CommissionTable getParameters() {
        if (sharedPreferencesParameters.contains(PARAMETERS)) {
            return new Gson().fromJson(sharedPreferencesParameters.getString(PARAMETERS, ""), CommissionTable.class);
        } else {
            return new CommissionTable();
        }
    }

    public void saveLastEnviromentSwitch(Environment environment) {
        mPrefApp.edit()
                .putLong(KEY_TIME_LAST_CHANGE_ENVIRONMENT, Calendar.getInstance().getTimeInMillis())
                .putString(KEY_ENVIRONMENT, String.valueOf(environment))
                .apply();
    }

    public String getLastEnviromentSwitch() {
        return mPrefApp.getString(KEY_ENVIRONMENT, "");
    }

    /**
     * This method returns the last value obtained in login otherwise returns minimum value
     *
     * @return Return timeout in seconds
     */
    public long getInactivityTimeout() {
        long inactivity = mPrefApp.getLong(KEY_INACTIVITY_TIMEOUT, MINIMUM_TIMEOUT);
        return inactivity <= 0 ? MINIMUM_TIMEOUT : inactivity;
    }
}
