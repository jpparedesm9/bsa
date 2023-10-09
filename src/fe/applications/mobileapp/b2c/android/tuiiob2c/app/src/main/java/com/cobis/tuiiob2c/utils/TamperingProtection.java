package com.cobis.tuiiob2c.utils;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.ConvertUtils;

import java.security.MessageDigest;

/**
 * Android Tampering protection validating the application signature and the installer. This implementation was based on:
 *  - https://github.com/SandroMachado/AndroidTampering
 *  - https://android-developers.googleblog.com/2010/09/securing-android-lvl-applications.html
 * Created by mnaunay on 26/10/2017.
 */

public final class TamperingProtection {
    private static final String PLAY_STORE_PACKAGE = "com.android.vending";

    private final Context context;
    private final Boolean playStoreOnly;
    private final Boolean releaseOnly;
    private final String certificateSignature;
    private final Boolean validateSignature;


    private TamperingProtection(Builder builder) {
        this.context = builder.context;
        this.playStoreOnly = builder.playStoreOnly;
        this.releaseOnly = builder.releaseOnly;
        this.certificateSignature = builder.certificateSignature;
        this.validateSignature = builder.validateSignature;
    }

    /**
     * Verifies if the application was installed using the Google Play Store.
     *
     * @param context The application context.
     *
     * @return returns a boolean indicating if the application was installed using the Google Play Store.
     */

    private static boolean wasInstalledFromPlayStore(final Context context) {
        final String installer = context.getPackageManager().getInstallerPackageName(context.getPackageName());

        return installer != null && installer.startsWith(PLAY_STORE_PACKAGE);
    }

    private static boolean isSignatureValid(Context context, String certificateSignature) {
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), PackageManager.GET_SIGNATURES);

            // The APK is signed with multiple signatures, probably it was tampered.
            if (packageInfo.signatures.length > 1) {
                return false;
            }

            for (Signature signature : packageInfo.signatures) {
                MessageDigest digest = MessageDigest.getInstance("SHA1", "BC");
                digest.update(signature.toByteArray());
                String sha1 = ConvertUtils.toHexadecimal(digest.digest());
                if (certificateSignature.equalsIgnoreCase(sha1)) {
                    return true;
                }
            }
        } catch (Exception ex) {
            Log.e("TamperingProtection::validateAppSignature", ex);
        }

        return false;
    }


    /**
     * Verifies if the application is debuggable
     * @param context The application context
     * @return return a boolean indicating if the application is debuggable
     */
    private static boolean isDebuggable(Context context){
        return  (( 0 != (context.getApplicationInfo().flags & ApplicationInfo.FLAG_DEBUGGABLE ) )  ||  android.os.Debug.isDebuggerConnected());
    }


    /**
     * Validates the APK. This method should return true if the apk is not tampered.
     *
     * @return a boolean indicating if the APK is valid. It returns true if the APK is valid, not tampered.
     */
    public Boolean validate() {
        // Check the application installer.
        if (this.playStoreOnly && !wasInstalledFromPlayStore(this.context)) {
            return false;
        }

        //Check the application debuggable
        if(this.releaseOnly && isDebuggable(this.context)){
            return false;
        }

        //check signature
        if(this.validateSignature && !isSignatureValid(context, certificateSignature)) {
            return false;
        }
        return true;
    }

    public static class Builder {

        private final Context context;
        private final String certificateSignature;
        private Boolean playStoreOnly = false;
        private Boolean releaseOnly = true;
        private Boolean validateSignature = true;

        /**
         * Constructor.
         *
         * @param context              The application context.
         * @param certificateSignature The certificate signature.
         */
        public Builder(Context context, String certificateSignature) {
            this.context = context;
            this.certificateSignature = certificateSignature;
        }

        /**
         * Configures to check against installations from outside the Google Play Store. The default is false.
         *
         * @param installOnlyFromPlayStore A boolean indicating if is to validate the application installer.
         * @return the builder.
         */
        public Builder installOnlyFromPlayStore(Boolean installOnlyFromPlayStore) {
            this.playStoreOnly = installOnlyFromPlayStore;

            return this;
        }


        /**
         * Configures to check if the application is running on release mode. The default is true.
         * @param releaseOnly A boolean indicating if is to validate the release mode
         * @return the builder
         */
        public Builder setReleaseOnly(Boolean releaseOnly) {
            this.releaseOnly = releaseOnly;
            return this;
        }

        public Builder setValidateSignature(Boolean validateSignature) {
            this.validateSignature = validateSignature;
            return this;
        }

        /**
         * Builds the Tampering Protection.
         *
         * @return the Tampering Protection.
         */

        public TamperingProtection build() {
            return new TamperingProtection(this);
        }
    }
}
