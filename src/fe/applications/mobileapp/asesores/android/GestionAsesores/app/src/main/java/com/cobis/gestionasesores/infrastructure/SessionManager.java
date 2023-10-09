package com.cobis.gestionasesores.infrastructure;

import android.content.SharedPreferences;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.data.models.Session;
import com.cobis.gestionasesores.infrastructure.jwt.DecodeException;
import com.cobis.gestionasesores.infrastructure.jwt.JWT;
import com.cobis.gestionasesores.utils.GsonHelper;
import com.securepreferences.SecurePreferences;

/**
 * SessionManager allows for a global session which can be accessed globally from other layers/classes.
 * Created by mnaunay on 14/07/2017.
 */
public final class SessionManager {
    private static final String PREF_SESSION = "session-data";
    private static final String PREF_APP = "app-data";

    private static final String KEY_DATA = "data";
    private static final String KEY_LAST_USERNAME = "last_username";
    private static final String KEY_LAST_OFFICER_NAME = "last_officername";
    private static final String KEY_INACTIVITY_TIMEOUT = "inactivity_timeout";
    private static final String KEY_PIN = "pin_";
    private static final String KEY_LAST_SYNC_UP = "sync_up";
    private static final String KEY_LAST_SYNC_DOWN = "sync_down";
    private static final String KEY_LAST_SYNC_CATALOG = "sync_catalog";

    private static final String KEY_ENVIRONMENT = "KEY_ENVIRONMENT";

    private static final int MINIMUM_TIMEOUT = 300; //Seconds

    private static SessionManager sInstance = null;
    private Session mSession;
    private SharedPreferences mPrefSession;
    private SharedPreferences mPrefApp;

    /**
     * Gets current session manager instance
     *
     * @return Session Manager instance
     */
    public static SessionManager getInstance() {
        if (sInstance == null) {
            sInstance = new SessionManager();
        }
        return sInstance;
    }

    /**
     * Default constructor
     */
    private SessionManager() {
        if (LibCore.getApplicationContext() == null) {
            throw new RuntimeException("Invalidate application context");
        }
        mPrefSession = new SecurePreferences(LibCore.getApplicationContext(), KManager.getInstance().getPreferenceKey(), PREF_SESSION);
        mPrefApp = new SecurePreferences(LibCore.getApplicationContext(), KManager.getInstance().getPreferenceKey(), PREF_APP);
    }

    /**
     * Create application session
     *
     * @param session User session
     */
    public void createSession(Session session) {
        mSession = session;
        mPrefSession.edit().putString(KEY_DATA, GsonHelper.getGson().toJson(session)).apply();
        mPrefApp.edit().putString(KEY_LAST_OFFICER_NAME, session.getOfficerName()).apply();
        mPrefApp.edit().putString(KEY_LAST_USERNAME, session.getUserName()).apply();
        if (mSession.isOnline()) {
            mPrefApp.edit().putLong(KEY_INACTIVITY_TIMEOUT, session.getInactivityTimeout()).apply();
        }
    }

    public Session getSession() {
        if (mSession == null && mPrefSession.contains(KEY_DATA)) {
            mSession = GsonHelper.getGson().fromJson(mPrefSession.getString(KEY_DATA, null), Session.class);
        }
        return mSession;
    }

    /**
     * Allows closeSession current session and release resources
     */
    public void closeSession() {
        mSession = null;
        mPrefSession.edit().clear().apply();
    }

    /**
     * Checks if the current session is active or not
     *
     * @return True if session is active and False in otherwise
     */
    public boolean isSessionActive() {
        boolean isActive = false;
        Session session = getSession();
        if (session != null) {
            if (session.isOnline()) {
                try {
                    JWT jwt = new JWT(session.getToken());
                    isActive = !jwt.isExpired(0);
                } catch (DecodeException ex) {
                    Log.e("SessionManager:isSessionActive: ", ex);
                }
            } else {
                isActive = true;
            }
        }
        return isActive;
    }

    /**
     * Returns the last username
     *
     * @return userName
     */
    public String getLastUserLogin() {
        return mPrefApp.getString(KEY_LAST_USERNAME, null);
    }

    /**
     * Returns the last officer name
     *
     * @return officerName
     */
    public String getLastOfficerLogin() {
        return mPrefApp.getString(KEY_LAST_OFFICER_NAME, null);
    }

    /**
     * Allows register PIN for username param
     *
     * @param username user name
     * @param pin      PIN value
     */
    public void registerPin(String username, String pin) {
        mPrefApp.edit().putString(KEY_PIN + username, pin).apply();
    }

    public void removePin(String username) {
        mPrefApp.edit().remove(KEY_PIN + username).apply();
    }

    /**
     * Allows get user PIN for the username param
     *
     * @param username User name
     * @return PIN
     */
    private String getPinByUser(String username) {
        return mPrefApp.getString(KEY_PIN + username, null);
    }

    /**
     * Checks if PIN exist or not for last user login
     *
     * @return True if exist PIN, and False in otherwise
     */
    public boolean existPin() {
        String username = getLastUserLogin();
        return (StringUtils.isNotEmpty(username) && StringUtils.isNotEmpty(getPinByUser(username)));
    }

    /**
     * Allows validate the input PIN with last User´s login PIN
     *
     * @param pin
     */
    public boolean validatePIN(String username, String pin) {
        return (pin.equals(getPinByUser(username)));
    }

    /**
     * Returns the application's last upload synchronization time in millis
     *
     * @return last upload synchronization time in millis
     */
    public long getLastSyncUp() {
        return mPrefApp.getLong(KEY_LAST_SYNC_UP, 0);
    }

    /**
     * Saves the application's last upload synchronization time
     */
    public void saveLastSyncUp() {
        mPrefApp.edit().putLong(KEY_LAST_SYNC_UP, System.currentTimeMillis()).apply();
    }

    /**
     * Returns the application's last download synchronization time in millis
     *
     * @return last download synchronization time in millis
     */
    public long getLastSyncDown() {
        return mPrefApp.getLong(KEY_LAST_SYNC_DOWN, 0);
    }

    /**
     * Saves the application's last download synchronization time
     */
    synchronized void saveLastSyncDown() {
        mPrefApp.edit().putLong(KEY_LAST_SYNC_DOWN, System.currentTimeMillis()).apply();
    }

    public void removeLastUserData() {
        mPrefApp.edit().clear().apply();
        mPrefSession.edit().clear().apply();
    }

    public void saveLastSyncCatalog() {
        mPrefApp.edit().putLong(KEY_LAST_SYNC_CATALOG, System.currentTimeMillis()).apply();
    }

    public long getLastSyncCatalog() {
        return mPrefApp.getLong(KEY_LAST_SYNC_CATALOG, 0);
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

    public void saveLastEnviromentSwitch(Environment environment) {
        mPrefApp.edit()
                .putString(KEY_ENVIRONMENT, String.valueOf(environment))
                .apply();
    }

    public String getLastEnviromentSwitch() {
        return mPrefApp.getString(KEY_ENVIRONMENT, "");
    }
}