package com.cobis.tuiiob2c;

import org.junit.Assert;
import org.junit.Test;

/**
 * Created by bqtdesa02 on 10/27/2017.
 */

public class ObfuscateTest {

    @Test
    public void obfuscateTest(){
        String original = "1D621A7528F91327DB198B1662B8E9DA1D76E797";

        String obfuscated = obfuscate(original);

        System.out.println("obfuscated:" + obfuscated);

        String unobfuscated = unobfuscate(obfuscated);

        Assert.assertEquals(unobfuscated,original);
    }

    private static final String key = "Zx" + Math.log(2) / 3;

    public static String obfuscate(String s) {
        char[] result = new char[s.length()];
        for (int i = 0; i < s.length(); i++) {
            result[i] = (char) (s.charAt(i) + key.charAt(i % key.length()));
        }

        return new String(result);
    }

    public static String unobfuscate(String s) {
        char[] result = new char[s.length()];
        for (int i = 0; i < s.length(); i++) {
            result[i] = (char) (s.charAt(i) - key.charAt(i % key.length()));
        }

        return new String(result);
    }

}
