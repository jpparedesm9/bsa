package com.cobis.gestionasesores.utils;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.bayteq.libcore.logs.Log;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.zip.CRC32;

/**
 * Created by bqtdesa02 on 6/22/2017.
 */

public final class ChecksumUtils {
    private ChecksumUtils(){}

    @NonNull
    public static String crc32Checksum(Serializable object) {
        if (object == null) return "";

        long startTime = System.currentTimeMillis();

        byte[] objectBytes = getObjectBytes(object);

        if(objectBytes == null) return "";

        CRC32 crc = new CRC32();
        crc.update(objectBytes);
        String result = Long.toHexString(crc.getValue());

        Log.d("CRC-32 duration: " + (System.currentTimeMillis() - startTime));

        return result;
    }

    @Nullable
    private static byte[] getObjectBytes(Serializable object){
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutput out;
        try {
            out = new ObjectOutputStream(bos);
            out.writeObject(object);
            out.flush();
            return bos.toByteArray();
        }catch (IOException ex){
            Log.e("ChecksumUtils::getObjectBytes error! ", ex);
            return null;
        }finally {
            try {
                bos.close();
            } catch (IOException ex) {
                Log.e("ChecksumUtils::getObjectBytes close bos error! ", ex);
            }
        }
    }
}
