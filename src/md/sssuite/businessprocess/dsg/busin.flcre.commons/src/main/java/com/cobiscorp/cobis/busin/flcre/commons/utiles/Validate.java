package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;

public class Validate {

	public static boolean IsRefinancing(ApplicationResponse applicationResponseDTO) {
		return (applicationResponseDTO.getType().equals(Mnemonic.REFINANCINGREQUEST) && (applicationResponseDTO.getExpromission() == null || applicationResponseDTO.getExpromission().isEmpty()));
	}

	public static class Strings {
		public static boolean isNotNullOrEmpty(final String value) {
			return value != null && !value.isEmpty();
		}

		public static boolean isNotNullOrEmpty(final Object value) {
			return !(value != null && !value.equals(""));
		}

		public static boolean isNotNullOrEmptyOrWhiteSpace(final String value) {
			return value != null && !value.isEmpty() && !value.trim().isEmpty();
		}
	}

	public static class Integers {
		public static boolean isNotNull(final Integer value) {
			return value != null;
		}

		public static boolean isNotNullAndGreaterThanZero(final Integer value) {
			return (value != null && value > 0);
		}
	}
}
