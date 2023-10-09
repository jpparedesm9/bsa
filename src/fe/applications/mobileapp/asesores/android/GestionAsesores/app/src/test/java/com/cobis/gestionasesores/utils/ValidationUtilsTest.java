package com.cobis.gestionasesores.utils;

import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Created by bqtdesa02 on 6/15/2017.
 */
public class ValidationUtilsTest {
    @Test
    public void isValidTelephone() throws Exception {
        assertTrue(ValidationUtils.isValidTelephone("5529296848"));
        assertFalse(ValidationUtils.isValidTelephone("sdfsd"));
        assertFalse(ValidationUtils.isValidTelephone("15"));
        assertFalse(ValidationUtils.isValidTelephone(""));
        assertFalse(ValidationUtils.isValidTelephone(null));
    }

}