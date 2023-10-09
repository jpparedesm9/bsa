package com.cobis.gestionasesores.utils;

import com.google.i18n.phonenumbers.NumberParseException;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;

import org.junit.Assert;
import org.junit.Test;

/**
 * Created by mnaunay on 02/08/2017.
 */

public class PhoneTest {

    @Test
    public void testRemoveCountryArea(){
        String phone = "+521234567890";
        String result = "";
        try {
            Phonenumber.PhoneNumber phoneNumber = PhoneNumberUtil.getInstance().parse(phone,"");
            result = String.valueOf(phoneNumber.getNationalNumber());
        } catch (NumberParseException e) {
            e.printStackTrace();
        }
        Assert.assertEquals("1234567890",result);
    }

    @Test
    public void testAddMxCountryCode(){
        String phone = "1234567890";
        String result = "";
        try {
            Phonenumber.PhoneNumber phoneNumber = PhoneNumberUtil.getInstance().parse(phone,"MX");
            result= PhoneNumberUtil.getInstance().format(phoneNumber, PhoneNumberUtil.PhoneNumberFormat.E164);
        } catch (NumberParseException e) {
            e.printStackTrace();
        }

        Assert.assertEquals("+521234567890",result);
    }
}
