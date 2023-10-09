package com.cobiscorp.mobile.services.impl.utils;

public class PasswordUtils {
	private PasswordUtils() {
		throw new IllegalStateException("Utility class");
	}

	public static boolean validateComplexity(String code) {
		int numRepeat = 3;
		if (code != null) {
			String[] codeArray = code.split("");
			for (int i = 0; i < codeArray.length; i++) {
				int times = validatechar(codeArray[i], i + 1, codeArray);
				if (times >= numRepeat - 1) {
					return false;
				}
			}
			return true;
		}
		return false;
	}

	private static int validatechar(String string, int position, String[] codeArray) {
		int result = 0;		
		for (int i = position; i < codeArray.length; i++) {			
			if (string.equals(codeArray[i])) {
				result++;
			}			
		}
		return result;
	}
}
