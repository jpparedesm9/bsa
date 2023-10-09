package com.cobiscorp.mobile.services.impl.utils;

import java.io.EOFException;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class KeepSecurity {
	public static final String CIPHER_INSTANCE = "RSA/ECB/OAEPPadding";
	public static final String KEY_FACTORY_INSTANCE = "RSA";
	private byte[] privateKey;
	private byte[] publicKey;

	public KeepSecurity(char[] publicKeyArray, char[] privateKeyArray) {
		if (privateKeyArray != null) {
			privateKey = ByteConverter.tranformFromHex(String.copyValueOf(privateKeyArray));
		}
		if (publicKeyArray != null) {
			publicKey = ByteConverter.tranformFromHex(String.copyValueOf(publicKeyArray));
		}
	}

	public String decrypt(String hexaCryptedPassword) {
		if (privateKey == null) {
			throw new COBISInfrastructureRuntimeException("Private Key is Required to decrypt");
		}

		try {
			return new String(decryptWithPrivateKey(privateKey, ByteConverter.tranformFromHex(hexaCryptedPassword)));
		} catch (java.security.spec.InvalidKeySpecException e) {
			throw new COBISInfrastructureRuntimeException(
					"Llaves publica/privada con formato incorrecto verifique si son correctas", e);
		} catch (BadPaddingException e) {
			throw new COBISInfrastructureRuntimeException(
					"Al parecer las llaves publica/privada usadas para encryptar no corresponden", e);
		} catch (GeneralSecurityException e) {
			throw new COBISInfrastructureRuntimeException("Problems when decrypt", e);
		}

	}

	public String encrypt(char[] str) {
		if (publicKey == null) {
			throw new COBISInfrastructureRuntimeException("Public Key is Required to Encrypt");
		}

		try {
			return ByteConverter.tranformToHex(encryptWithPublicKey(publicKey, new String(str).getBytes()));
		} catch (java.security.spec.InvalidKeySpecException e) {
			throw new COBISInfrastructureRuntimeException(
					"Llaves publica/privada con formato incorrecto verifique si son correctas", e);
		} catch (GeneralSecurityException e) {
			throw new COBISInfrastructureRuntimeException("Problemas el momento de desencriptar", e);
		}
	}

	private byte[] encryptWithPublicKey(byte[] publicBytes, byte[] bytesToEncrypt)
			throws NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException,
			BadPaddingException, IllegalBlockSizeException {
		X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_FACTORY_INSTANCE);
		PublicKey pubKey = keyFactory.generatePublic(keySpec);
		Cipher cipher = Cipher.getInstance(CIPHER_INSTANCE);
		cipher.init(Cipher.ENCRYPT_MODE, pubKey);
		byte[] cipherText = cipher.doFinal(bytesToEncrypt);
		return cipherText;
	}

	private byte[] decryptWithPrivateKey(byte[] privateBytes, byte[] bytesToDecrypt)
			throws NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException,
			BadPaddingException, IllegalBlockSizeException {
		PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateBytes);
		KeyFactory keyFactory = KeyFactory.getInstance(KEY_FACTORY_INSTANCE);
		PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
		Cipher cipher = Cipher.getInstance(CIPHER_INSTANCE);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] cipherText = cipher.doFinal(bytesToDecrypt);
		return cipherText;
	}

	public static byte[] readBytes(String fileName) throws IOException {
		byte[] content = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(fileName);
			content = new byte[fis.available()];
			int count = 0;
			while ((count = fis.read(content)) > 0) {
				//
			}
		} catch (IOException e) {
			throw new COBISInfrastructureRuntimeException("Problemas el momento de desencriptar", e);
		} finally {
			if (fis != null) {
				fis.close();
			}
		}
		return content;
	}
}