package com.cobiscorp.cloud.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

public class CryptoUtils {

	  private static final String ALGORITHM = "AES";
	  
	  public static void encrypt(String key, File inputFile, File outputFile)
	    throws CryptoException
	  {
	    doCrypto(1, key, inputFile, outputFile);
	  }
	  
	  public static void decrypt(String key, File inputFile, File outputFile)
	    throws CryptoException
	  {
	    doCrypto(2, key, inputFile, outputFile);
	  }
	  
	  private static void doCrypto(int cipherMode, String key, File inputFile, File outputFile)
	    throws CryptoException
	  {
	    try
	    {
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

					FileInputStream fis = new FileInputStream(outputFile.getParentFile().getAbsolutePath().concat("\\destFile.txt"));
					BufferedReader r = new BufferedReader(new InputStreamReader(fis, "UTF-8"));

					// output
					FileOutputStream fos = new FileOutputStream(new File(outputFile.getParentFile().getAbsolutePath().concat("\\" + fileInitialName)));
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
	    
	    }catch (Exception e)
	    {
	      if (((e instanceof NoSuchPaddingException)) || ((e instanceof NoSuchAlgorithmException)) || ((e instanceof InvalidKeyException)) || ((e instanceof BadPaddingException)) || ((e instanceof IllegalBlockSizeException)) || ((e instanceof IOException))) {
	        throw new CryptoException("Error encrypting/decrypting file", e);
	      }
	    }
	  }

}
