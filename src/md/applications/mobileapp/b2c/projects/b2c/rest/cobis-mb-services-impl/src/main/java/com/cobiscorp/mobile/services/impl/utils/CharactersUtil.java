package com.cobiscorp.mobile.services.impl.utils;

public class CharactersUtil {

	public CharactersUtil() {
	}

	private static final String specialCharacter1 = "Ã‘";

	public String replaceSpecialCharacters(String word) {

		if (word != null)
			if (word.contains(this.specialCharacter1)) {
				word = word.replace(this.specialCharacter1, "Ñ");
			}

		return word;
	}
}
