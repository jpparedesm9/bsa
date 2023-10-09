package com.cobis.gestionasesores.utils;

import java.util.regex.Pattern;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class ValidationUtils {

    private static final Pattern TELEPHONE_PATTERN = Pattern.compile("^[0-9]{10}$");

    public static boolean isValidTelephone(String telephone) {
        return telephone != null && TELEPHONE_PATTERN.matcher(telephone).matches();
    }

    public static boolean isValidCellphone(String cellphone){
        return isValidTelephone(cellphone);
    }
}
