package com.cobis.gestionasesores.utils;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * Created by bqtdesa02 on 10/11/2017.
 */
public class UtilTest {
    @Test
    public void formatRawNumber() throws Exception {
        assertEquals("0293846322",Util.formatRawNumber("029 384 6322", null));
        assertEquals("0293846322",Util.formatRawNumber("0293846322", null));
    }

    @Test
    public void formatPhone() throws Exception {
        assertEquals("029 384 6322",Util.formatPhone("0293846322", "52"));
        assertEquals("654 258 7534",Util.formatPhone("+526542587534", "52"));
        assertEquals("654 258 7534",Util.formatPhone("+526542587534", "+52"));
        assertEquals("029384322",Util.formatPhone("029384322", null));
    }

}