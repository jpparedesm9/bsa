package com.cobiscorp.cloud.notificationservice.key;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.SecureRandom;
import java.security.spec.PKCS8EncodedKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.scheduler.utils.CryptoException;

public class CryptoUtils {
	private static final Logger LOGGER = Logger.getLogger(CryptoUtils.class);
	private static final int AES_KEY_LEN = 256;
	private static final int RSA_KEY_LEN = 2048;
	private static final String ASIMETRIC_ALGORITHM = "RSA";
	private static SecureRandom srandom = new SecureRandom();
	private static final String ALGORITHM = "AES";

	public static void encrypt(String key, File inputFile, File outputFile) throws CryptoException {
		doCrypto(1, key, inputFile, outputFile);
	}

	public static void decrypt(String key, File inputFile, File outputFile) throws CryptoException {
		doCrypto(2, key, inputFile, outputFile);
	}

	private static void doCrypto(int cipherMode, String key, File inputFile, File outputFile) throws CryptoException {
		try {
			Key secretKey = new SecretKeySpec(key.getBytes(), ALGORITHM);
			Cipher cipher = Cipher.getInstance(ALGORITHM);
			cipher.init(cipherMode, secretKey);
			System.out.println("Encriptacion --> " + Cipher.ENCRYPT_MODE);

			FileInputStream inputStream = new FileInputStream(inputFile);
			byte[] inputBytes = new byte[(int) inputFile.length()];
			inputStream.read(inputBytes);
			if (cipherMode == 1) {
				byte[] outputBytes = cipher.doFinal(inputBytes);

				FileOutputStream outputStream = new FileOutputStream(outputFile);
				outputStream.write(outputBytes);
				inputStream.close();
				outputStream.close();
			} else {
				if (cipherMode == 2) {
					String fileInitialName = outputFile.getName();
					byte[] outputBytes = cipher.doFinal(inputBytes);
					File destFile = new File(outputFile.getParentFile().getAbsolutePath().concat("\\destFile.txt"));
					FileOutputStream outputStream = new FileOutputStream(destFile);
					outputStream.write(outputBytes);

					inputStream.close();
					outputStream.close();
					// cierra todo
					// Convertir a Ansi

					FileInputStream fis = new FileInputStream(
							outputFile.getParentFile().getAbsolutePath().concat("\\destFile.txt"));
					BufferedReader r = new BufferedReader(new InputStreamReader(fis, "UTF-8"));

					// output
					FileOutputStream fos = new FileOutputStream(
							new File(outputFile.getParentFile().getAbsolutePath().concat("\\" + fileInitialName)));
					Writer w = new BufferedWriter(new OutputStreamWriter(fos, "Cp1252"));

					String oemString = "";
					while ((oemString = r.readLine()) != null) {
						w.write(oemString + "\r\n");
						w.flush();
					}
					w.close();
					r.close();
					// Se borra el archivo temporal
					File fileToDelete = new File(outputFile.getParentFile().getAbsolutePath().concat("\\destFile.txt"));
					fileToDelete.delete();
				}
			}
		} catch (Exception e) {
			if (((e instanceof NoSuchPaddingException)) || ((e instanceof NoSuchAlgorithmException))
					|| ((e instanceof InvalidKeyException)) || ((e instanceof BadPaddingException))
					|| ((e instanceof IllegalBlockSizeException)) || ((e instanceof IOException))) {
				throw new CryptoException("Error encrypting/decrypting file", e);
			}
		}
	}

	public static void encryptFileRSAWithAES(String pvtKeyFile, String fileToEncrypt) throws CryptoException {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("KEY FILE: " + pvtKeyFile);
			}

			//byte[] bytes = Files.readAllBytes(new File(pvtKeyFile).toPath());
			
			
			File f = new File(pvtKeyFile);
			FileInputStream fis = new FileInputStream(f);
			DataInputStream dis = new DataInputStream(fis);
			byte[] bytes = new byte[(int) f.length()];
			dis.readFully(bytes);
			dis.close();
			
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("PASO 1");
			}
			PKCS8EncodedKeySpec ks = new PKCS8EncodedKeySpec(bytes);
			KeyFactory kf = KeyFactory.getInstance("RSA");
			PrivateKey pvk = kf.generatePrivate(ks);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("PASO 2");
			}
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(AES_KEY_LEN);
			SecretKey skey = kgen.generateKey();

			byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
			srandom.nextBytes(iv);
			IvParameterSpec ivspec = new IvParameterSpec(iv);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("FILE OUT: " + fileToEncrypt.replace(".txt", ".enc"));
			}
			FileOutputStream out = new FileOutputStream(fileToEncrypt.replace(".txt", ".enc"));

			Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
			cipher.init(Cipher.ENCRYPT_MODE, pvk);
			byte[] b = cipher.doFinal(skey.getEncoded());
			out.write(b);
			out.write(iv);
			Cipher ci = Cipher.getInstance("AES/CBC/PKCS5Padding");
			ci.init(Cipher.ENCRYPT_MODE, skey, ivspec);
			FileInputStream in = new FileInputStream(fileToEncrypt);

			processFile(ci, in, out);

		} catch (IOException ie) {
			LOGGER.error("ERROR AL LEER KEY", ie);
			throw new CryptoException("Error encrypting RSA file", ie);
		} catch (Exception e) {
			LOGGER.error("ERROR AL ENCRIPTAR ARCHIVO ", e);
			throw new CryptoException("Error encrypting RSA file", e);
		} finally {
			LOGGER.debug("FINALIZA ENCRIPTACION DE ARCHIVO CON RSA");
		}
	}

	public static KeyPair generateRSAKeyPair() throws Exception {
		KeyPairGenerator generator = KeyPairGenerator.getInstance(ASIMETRIC_ALGORITHM);
		generator.initialize(RSA_KEY_LEN, new SecureRandom());
		KeyPair pair = generator.generateKeyPair();

		return pair;
	}

	private static void processFile(Cipher ci, InputStream in, OutputStream out)
			throws javax.crypto.IllegalBlockSizeException, javax.crypto.BadPaddingException, java.io.IOException {
		byte[] ibuf = new byte[1024];
		int len;
		while ((len = in.read(ibuf)) != -1) {
			byte[] obuf = ci.update(ibuf, 0, len);
			if (obuf != null)
				out.write(obuf);
		}
		byte[] obuf = ci.doFinal();
		if (obuf != null)
			out.write(obuf);
		in.close();
		out.close();
	}

}
