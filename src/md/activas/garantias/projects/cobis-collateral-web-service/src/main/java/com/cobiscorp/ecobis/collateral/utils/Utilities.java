package com.cobiscorp.ecobis.collateral.utils;

import java.util.HashMap;
import java.util.Map;

import com.cobiscorp.ecobis.collateral.constants.Constants;

public class Utilities {
	private final static HashMap<Character, Character> UNICODE_CHARS = new HashMap<Character, Character>();

	public static String replace(String word) {
		for (Map.Entry<Character, Character> pair : getUnicodeChars().entrySet()) {
			word = word.replace(pair.getKey().charValue(), pair.getValue().charValue());
			word = word.replaceAll(" ", "");

		}
		return word;
	}

	final static HashMap<Character, Character> getUnicodeChars() {

		UNICODE_CHARS.put(Constants.UNICODE_a, 'a');
		UNICODE_CHARS.put(Constants.UNICODE_e, 'e');
		UNICODE_CHARS.put(Constants.UNICODE_i, 'i');
		UNICODE_CHARS.put(Constants.UNICODE_o, 'o');
		UNICODE_CHARS.put(Constants.UNICODE_u, 'u');

		UNICODE_CHARS.put(Constants.UNICODE_A, 'A');
		UNICODE_CHARS.put(Constants.UNICODE_E, 'E');
		UNICODE_CHARS.put(Constants.UNICODE_I, 'I');
		UNICODE_CHARS.put(Constants.UNICODE_O, 'O');
		UNICODE_CHARS.put(Constants.UNICODE_U, 'U');

		UNICODE_CHARS.put(Constants.UNICODE_n_, 'n');
		UNICODE_CHARS.put(Constants.UNICODE_N_, 'N');

		return UNICODE_CHARS;
	}

}
