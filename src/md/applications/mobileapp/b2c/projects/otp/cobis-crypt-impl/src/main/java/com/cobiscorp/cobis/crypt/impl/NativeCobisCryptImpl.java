package com.cobiscorp.cobis.crypt.impl;


import java.security.MessageDigest;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cwc.api.util.Constant;

@Component(name = "NativeCobisCryptImpl", immediate = false)
@Service(value = { ICobisCrypt.class })
@Properties(value = {
		@Property(name = "service.description", value = "NativeCobisCryptImpl"),
		@Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"),
		@Property(name = "service.identifier", value = "NativeCobisCryptImpl") })
public class NativeCobisCryptImpl implements ICobisCrypt {

	private byte[] sbox = new byte[256];
	private static final String ZERO = "0";
	
	public NativeCobisCryptImpl() {
		System.out.println("Nueva versión COBISCrypt");
	}
	
	/**
	 * Method to encrypt
	 * 
	 * @param login
	 * @param password
	 * @return
	 */
	public String enCrypt(String login, String password) {
		MessageDigest messageDigest;

		byte[] iniKey = { 0x05, 0x02, 0x02, 0x04, 0x43, 0x26, 0x32, 0x03, 0x5A, 0x7D };

		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append(new String(iniKey));
		stringBuilder.append(password);

		byte[] data = stringBuilder.toString().getBytes();
		try {
			messageDigest = MessageDigest.getInstance(Constant.METHOD_MD5);
		} catch (Exception e) {
			return null;
		}
		messageDigest.update(data);
		byte[] hash = messageDigest.digest();

		for (int i = 5; i < 16; i++) {
			hash[i] = 0;
		}

		byte[] clearText = new byte[32];

		for (int i = 0; i < 32; i++) {
			if (i < login.length()) {
				clearText[i] = (byte) login.charAt(i);
			} else {
				clearText[i] = ' ';
			}
		}

		byte[] result = enDeCrypt(clearText, hash, 16, 32);
		StringBuilder builder = new StringBuilder();

		for (int i = 0; i < 32; i++) {
			int temp;
			String dig;

			temp = (result[i] < 0 ? 256 + result[i] : result[i]);
			dig = Integer.toHexString(temp);
			if (dig.length() == 1) {
				builder.append(ZERO);
			}
			builder.append(dig);
		}
		return builder.toString().toUpperCase();
	}

	/**
	 * @param strPwd
	 * @param length
	 * @return
	 */
	private int rC4Initialize(byte[] strPwd, int length) {
		byte[] key = new byte[256];
		byte tempSwap;
		int forA, forB;

		for (forA = 0; forA <= 255; forA++) {
			key[forA] = strPwd[forA % length];
			sbox[forA] = (byte) forA;
		}

		forB = 0;
		for (forA = 0; forA <= 255; forA++) {
			forB = (forB + (sbox[forA] < 0 ? (int) 256 + sbox[forA] : (int) sbox[forA])
					+ (key[forA] < 0 ? (int) 256 + key[forA] : (int) key[forA])) % 256;
			tempSwap = sbox[forA];
			sbox[forA] = sbox[forB];
			sbox[forB] = tempSwap;
		}
		return 0;
	}

	/**
	 * @param plaintxt
	 * @param password
	 * @param lengthA
	 * @param lengthB
	 * @return
	 */
	private byte[] enDeCrypt(byte[] plaintxt, byte[] password, int lengthA, int lengthB) {
		byte temp;
		int forA, forI, forJ;
		byte cipherby, tempResult;
		byte result[] = new byte[lengthB];

		forI = 0;
		forJ = 0;

		rC4Initialize(password, lengthA);

		for (forA = 1; forA <= lengthB; forA++) {
			forI = (forI + 1) % 256;
			forJ = (forJ + (sbox[forI] < 0 ? (int) 256 + sbox[forI] : (int) sbox[forI])) % 256;
			temp = sbox[forI];
			sbox[forI] = sbox[forJ];
			sbox[forJ] = temp;

			tempResult = sbox[((sbox[forI] < 0 ? (int) 256 + sbox[forI] : (int) sbox[forI])
					+ (sbox[forJ] < 0 ? (int) 256 + sbox[forJ] : (int) sbox[forJ])) % 256];

			cipherby = (byte) (plaintxt[forA - 1] ^ tempResult);
			result[forA - 1] = cipherby;
		}
		return result;
	}
}
