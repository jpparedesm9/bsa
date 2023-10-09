package com.cobis.gestionasesores.utils;

import org.junit.Test;

import java.io.File;
import java.io.FileOutputStream;


/**
 * Created by bqtdesa02 on 10/27/2017.
 */

public class PublicKey {

    @Test
    public void generateKey() throws Exception {
        String publicKey = "";
        byte[] bytesKey = hexStringToByteArray(publicKey);
        File file = new File("");
        if(file.exists()){
            file.delete();
        }
        try( FileOutputStream keyfos = new FileOutputStream(file)) {
            keyfos.write(bytesKey);
        }catch (Exception ex){
            System.out.println("Error writing files!");
        }
    }

    public static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                    + Character.digit(s.charAt(i + 1), 16));
        }
        return data;
    }
}
