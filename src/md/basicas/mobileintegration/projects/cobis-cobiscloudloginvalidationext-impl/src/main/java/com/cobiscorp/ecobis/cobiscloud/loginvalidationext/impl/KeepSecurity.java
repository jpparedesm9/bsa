package com.cobiscorp.ecobis.cobiscloud.loginvalidationext.impl;

import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.apache.commons.codec.binary.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;


import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.security.*;

public class KeepSecurity {
    public static final String CIPHER_INSTANCE = "RSA/ECB/PKCS1Padding";
    public static final String KEY_FACTORY_INSTANCE = "RSA";
    private byte[] privateKey;

    public KeepSecurity(char[] privateKeyArray) {
        if(privateKeyArray != null) {
            privateKey = ByteConverter.tranformFromHex(String.copyValueOf(privateKeyArray));
        }
    }
    private int getBlockSize(int mode) {
        return (mode == Cipher.DECRYPT_MODE)? 256 : 245;
    }
    public String decrypt(String hexaCrypted) {
        if(privateKey == null) {
            throw new COBISInfrastructureRuntimeException("Private Key is Required to decrypt");
        }

        try {
            int blockSize = getBlockSize(Cipher.DECRYPT_MODE);

            byte[] buffer = new byte[blockSize];
            byte[] bytesCrypted = ByteConverter.tranformFromHex(hexaCrypted);
            StringBuffer completeStringDecrypted = new StringBuffer();
            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytesCrypted);
            int bytesReaded = 0;
            while(bytesReaded < bytesCrypted.length) {
                bytesReaded = bytesReaded + byteArrayInputStream.read(buffer);
                byte[] bytesDecrypted = decryptWithPrivateKey(privateKey, buffer);
                String decryptedString = new String(bytesDecrypted);
                decryptedString = decryptedString.replaceAll("\0", "");
                completeStringDecrypted.append(decryptedString);
            }
            return completeStringDecrypted.toString();
        } catch (java.security.spec.InvalidKeySpecException e) {
            throw new COBISInfrastructureRuntimeException("Llaves publica/privada con formato incorrecto verifique si son correctas", e);
        } catch (BadPaddingException e) {
            throw new COBISInfrastructureRuntimeException("Al parecer las llaves publica/privada usadas para encryptar no corresponden", e);
        } catch (GeneralSecurityException e) {
            throw new COBISInfrastructureRuntimeException("Problems when decrypt", e);
        } catch (IOException e) {
            throw new COBISInfrastructureRuntimeException("IOException when decrypt", e);
        }

    }

    private byte[] decryptWithPrivateKey(byte[] privateBytes, byte[] bytesToDecrypt)  throws NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_FACTORY_INSTANCE);
        PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
        Cipher cipher = Cipher.getInstance(CIPHER_INSTANCE);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] cipherText = cipher.doFinal(bytesToDecrypt);
        return cipherText;
    }

}
