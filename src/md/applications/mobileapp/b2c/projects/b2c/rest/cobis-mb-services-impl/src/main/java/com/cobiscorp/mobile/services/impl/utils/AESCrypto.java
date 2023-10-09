package com.cobiscorp.mobile.services.impl.utils;

import java.io.ByteArrayOutputStream;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.services.impl.SecurityServiceImpl;

/**
 * @author MIT via Esteban "Doc" Garcia Luna
 * @version 1.0
 * @date 2017/10/10
 */

public class AESCrypto {
	private static final String ALGORITMO = "AES/CBC/PKCS5Padding"; // Este es
																	// el
																	// algoritmo
																	// a usar
	private static final String CODIFICACION = "UTF-8"; // Esta es la
														// codificación a usar

	/**
	 * Permite cifrar una cadena a partir de un llave proporcionada
	 * 
	 * @param strToEncrypt
	 * @param key
	 * @return String con la cadena encriptada
	 */

	/** Logger. */
	private static ILogger LOGGER = LogFactory.getLogger(SecurityServiceImpl.class);

	public static String encrypt(String strToEncrypt, String key) {
		try {
			byte[] raw = DatatypeConverter.parseHexBinary(key);
			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");

			Cipher cipher = Cipher.getInstance(ALGORITMO);

			cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
			byte[] iv = cipher.getIV();
			byte[] cipherText = cipher.doFinal(strToEncrypt.getBytes(CODIFICACION));

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			outputStream.write(iv);
			outputStream.write(cipherText);

			return Base64.getEncoder().encodeToString(outputStream.toByteArray());
		} catch (Exception e) {
			String error = "Error al cifrar: " + e.toString();
			LOGGER.logDebug("Error al encriptar: ", e);
			return error;
		}
	}

	/**
	 * Permite descifrar una cadena a partir de un llave proporcionada
	 * 
	 * @param strToDecrypt
	 * @param key
	 * @return String con la cadena descifrada
	 */
	public static String decrypt(String strToDecrypt, String key) {
		try {
			byte[] encryptedData = DatatypeConverter.parseBase64Binary(strToDecrypt);

			byte[] raw = DatatypeConverter.parseHexBinary(key);

			SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("encryptedData ==> " + encryptedData);
			}
			byte[] iv = Arrays.copyOfRange(encryptedData, 0, 16);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("iv ==> " + iv);
			}
			byte[] cipherText = Arrays.copyOfRange(encryptedData, 16, encryptedData.length);
			IvParameterSpec iv_specs = new IvParameterSpec(iv);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("encryptedData.length ==> " + encryptedData.length);
			}
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv_specs);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("cipherText ==> " + cipherText);
			}
			byte[] plainTextBytes = cipher.doFinal(cipherText);
			
			LOGGER.logDebug("Decrypt plainTextBytes: " + plainTextBytes);
			
			String plainText = new String(plainTextBytes);
			LOGGER.logDebug("Decrypt plainText: " + plainText);

			return plainText;
		} catch (Exception e) {
			String error = "Error al descifrar: " + e.toString();
			LOGGER.logDebug("Error al desencriptar: ", e);
			return error;
		}
	}
}
