package com.cobis.tuiiob2c.infraestructure;

import com.bayteq.libcore.util.SecurityUtils;

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
            mAppSignature = illuminate(get1());
        }
        return mAppSignature;
    }

    public String getKeyStoreKey() {
        if(mKeyStoreKey == null){
            mKeyStoreKey = illuminate(get2());
        }
        return mKeyStoreKey;
    }

    public String getPreferenceKey(){
        if(mPrefKey == null){
            mPrefKey = illuminate(get3());
        }
        return mPrefKey;
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

    //app sign sha1
    private native String get1();

    //Store:
    //mW2r.ACe*BhDNEs@
    private native String get2();

    //Pref Key
    //fh'8X7nMet&;''3)
    private native String get3();
    static {
        System.loadLibrary("native-lib");
    }
}