package com.cobis.gestionasesores.infrastructure;

import com.bayteq.libcore.util.SecurityUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.BuildConfig;

/**
 * Use this class to generate key store for database
 * Created by mnaunay on 28/08/2017.
 */

public final class KManager {

    private static final String KEY = "Zx" + Math.log(2) / 3;

    private static KManager sInstance;
    private String mUserKey;
    private String mAppSignature;
    private String mKeyStoreKey;

    private String mPrefKey;

    private KManager() {
    }

    /**
     * Singleton instance
     *
     * @return {@link KManager}
     */
    public static KManager getInstance() {
        if (sInstance == null) {
            sInstance = new KManager();
        }
        return sInstance;
    }

    public String getAppSignature() {
        if(mAppSignature == null){
            mAppSignature = BuildConfig.STORE? illuminate(get3()): illuminate(get6());
        }
        return mAppSignature;
    }

    public String getKeyStoreKey() {
        if(mKeyStoreKey == null){
            mKeyStoreKey = illuminate(get4());
        }
        return mKeyStoreKey;
    }

    public String getPreferenceKey(){
        if(mPrefKey == null){
            mPrefKey = illuminate(get5());
        }
        return mPrefKey;
    }

    /**
     * Generate Key store for current user
     *
     * @return Key Store
     */
    public String getDatabaseKey() {
        if (BankAdvisorApp.getInstance().getConfig().isDataBaseEncrypted()) {
            return generateKey(getUserKey(), illuminate(get1()));
        } else {
            return null;
        }
    }

    /**
     * Get current key
     *
     * @return Key String
     */
    public String getUserKey() {
        if (!SessionManager.getInstance().isSessionActive()) {
            throw new RuntimeException("Not active!");
        }
        if (mUserKey == null) {
            mUserKey = SecurityUtils.encodeWithMD5(SessionManager.getInstance().getSession().getUserName());
        }
        return mUserKey;
    }

    /**
     * Internal implementation for key store
     *
     * @param key   Key
     * @param nonce Nonce
     * @return Key generated
     */
    private String generateKey(String key, String nonce) {
        if (key == null || nonce == null) throw new RuntimeException("Invalid parameters");
        String token = String.format(illuminate(get2()), key, nonce);
        return SecurityUtils.encodeWithSHA256(token);
    }

    private static String illuminate(String s) {
        char[] result = new char[s.length()];
        for (int i = 0; i < s.length(); i++) {
            result[i] = (char) (s.charAt(i) - KEY.charAt(i % KEY.length()));
        }

        return new String(result);
    }

    //Api key
    private native String get1();

    //Key Format
    private native String get2();

    //Sign Dev 15188E0427400F107A6753927975B6B34A872792
    //Sign Sust 63C1AB24BFC7B4DBC28FBDACE04C747C86795CD5
    //Sign Prod 1D621A7528F91327DB198B1662B8E9DA1D76E797
    private native String get3();

    //KeyStoreKey Ngm8K@UkP.6D:bP>
    private native String get4();

    //Pref Key
    private native String get5();

    //Default sign Key
    private native String get6();

    static {
        System.loadLibrary("native-lib");
    }
}