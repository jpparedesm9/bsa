package com.cobis.gestionasesores.utils;

import com.bayteq.libcore.logs.Log;

import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

/**
 * Created by bqtdesa02 on 10/26/2017.
 */

public class SecurityUtil {

    public static String encryptWithPublicKey(byte[] publicBytes, String stringToEncrypt){
        try {
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicBytes);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            PublicKey pubKey = keyFactory.generatePublic(keySpec);
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.ENCRYPT_MODE, pubKey);
            return Util.bytesToHex(cipher.doFinal(stringToEncrypt.getBytes()));
        }catch (Exception ex){
            Log.e("SecurityUtil: Error in encryptWithPublicKey", ex);
            return null;
        }
    }
}
