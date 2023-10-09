package com.cobiscorp.mobile.services.impl.utils;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

public class SimpleRSA {

	public static final String ALGORITHM = "RSA";
	private static final String UTF_8 = "UTF-8";

	public String decrypt(String cipherText, PrivateKey privateKey) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {

		byte[] encryptedData = Base64.getDecoder().decode(cipherText);
		Cipher cipher = Cipher.getInstance(ALGORITHM);	

		cipher.init(Cipher.DECRYPT_MODE, privateKey);

		byte[] plainText = cipher.doFinal(encryptedData);

		return new String(plainText, UTF_8);
	}
}
