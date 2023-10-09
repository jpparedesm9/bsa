package com.cobiscorp.ecobis.business.commons.platform.services.utils;

import java.text.Normalizer;

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

	public String removeDiacritics(String word) {
		word = word.replace('ñ', '\001');
		word = word.replace('Ñ', '\002');
		word = Normalizer.normalize(word, Normalizer.Form.NFD);
		word = word.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");
		word = word.replace('\001', 'ñ');
		word = word.replace('\002', 'Ñ');
		return word;
	}
}
