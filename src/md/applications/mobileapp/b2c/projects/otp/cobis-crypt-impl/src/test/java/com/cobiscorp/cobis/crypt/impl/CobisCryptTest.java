package com.cobiscorp.cobis.crypt.impl;

import java.security.MessageDigest;
import java.util.Map;

import org.junit.BeforeClass;
import org.junit.Ignore;

import com.cobiscorp.cobis.crypt.ICobisCrypt;

@Ignore
public class CobisCryptTest {
	/* E787406EF736E309252ED9B7AD35818C334455170165A55C69452ABAAECAE28E */
	/* E787406EF736E309252ED9B7AD35818C334455170165A55C69452ABAAECAE28E */

	byte[] key = new byte[256];
	byte[] sbox = new byte[256];

	int RC4Initialize(byte[] strPwd, int len) {
		byte tempSwap;
		int a, b, intLength;

		intLength = len;
		for (a = 0; a <= 255; a++) {
			key[a] = strPwd[a % intLength];
			sbox[a] = (byte) a;
		}

		b = 0;
		for (a = 0; a <= 255; a++) {
			b = (b + (sbox[a] < 0 ? (int) 256 + sbox[a] : (int) sbox[a]) + (key[a] < 0 ? (int) 256
					+ key[a]
					: (int) key[a])) % 256;
			tempSwap = sbox[a];
			sbox[a] = sbox[b];
			sbox[b] = tempSwap;
		}
		return 0;
	}

	byte[] EnDeCrypt(byte[] plaintxt, byte[] psw, int lenk, int lent) {
		byte temp;
		int a, i, j;
		byte cipherby, k;
		byte result[] = new byte[lent];

		i = 0;
		j = 0;

		RC4Initialize(psw, lenk);

		for (a = 1; a <= lent; a++) {
			i = (i + 1) % 256;
			j = (j + (sbox[i] < 0 ? (int) 256 + sbox[i] : (int) sbox[i])) % 256;
			temp = sbox[i];
			sbox[i] = sbox[j];
			sbox[j] = temp;

			k = sbox[((sbox[i] < 0 ? (int) 256 + sbox[i] : (int) sbox[i]) + (sbox[j] < 0 ? (int) 256
					+ sbox[j]
					: (int) sbox[j])) % 256];

			cipherby = (byte) (plaintxt[a - 1] ^ k);
			result[a - 1] = cipherby;
		}
		return result;
	}

	public String EnCrypt(String login, String password) {
		int i;
		MessageDigest md;

		byte[] iniKey = { 0x05, 0x02, 0x02, 0x04, 0x43, 0x26, 0x32, 0x03, 0x5A,
				0x7D };

		String iniSkey = new String(iniKey);
		iniSkey += password;

		byte[] data = iniSkey.getBytes();
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			return null;
		}
		md.update(data);
		byte[] hash = md.digest();

		for (i = 5; i < 16; i++) {
			hash[i] = 0;
		}

		byte[] clearText = new byte[32];

		for (i = 0; i < 32; i++) {
			if (i < login.length()) {
				clearText[i] = (byte) login.charAt(i);
			} else {
				clearText[i] = ' ';
			}
		}

		byte[] result = EnDeCrypt(clearText, hash, 16, 32);
		String res = "";

		for (i = 0; i < 32; i++) {
			int temp;
			String dig;

			temp = (result[i] < 0 ? 256 + result[i] : result[i]);
			dig = Integer.toHexString(temp);
			if (dig.length() == 1)
				dig = "0" + dig;
			res += dig;
		}

		return res.toUpperCase();

	}

	public static void main(String[] args) throws NoSuchFieldException {
		

		String str;
		
		CobisCryptTest cp = new CobisCryptTest();
		str = cp.EnCrypt("testCTS", "1234567890");
		System.out.println(str);

//		CobisCryptTest cp = new CobisCryptTest();
//		str = cp.EnCrypt("50769480428", "65099503");
//		System.out.println("java  : " + str);
//		
//		init();
//		String nativeStr = cobisCrypt.enCrypt("50769480428", "65099503");
//		System.out.println("nativo: " + nativeStr);
//		
//		if(str.endsWith("68475EBABEB07B449921D91507E24FB3BC91E9B033A7C4DC9DACBAFBF1CD617D"))
//		{
//			System.out.println("Son iguales algoritmo Java");
//		}
//		
//		if(nativeStr.endsWith("68475EBABEB07B449921D91507E24FB3BC91E9B033A7C4DC9DACBAFBF1CD617D"))
//		{
//			System.out.println("Son iguales algoritmo Nativo");
//		}
		
		/*Map<String, Class<?>> systemNativeLibraries = new NativeLibraries().getSystemNativeLibraries();
		for (String string : systemNativeLibraries.keySet()) {
			System.out.println(string);
		}*/
//		new NativeLibraries().getDeclaredFileds();
	}

	private static ICobisCrypt cobisCrypt;

	private static void init() {
		cobisCrypt = new NativeCobisCryptImpl();
	}

}
