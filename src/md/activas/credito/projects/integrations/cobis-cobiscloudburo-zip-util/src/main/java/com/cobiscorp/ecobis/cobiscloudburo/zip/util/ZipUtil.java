package com.cobiscorp.ecobis.cobiscloudburo.zip.util;


import com.cobiscorp.cobis.commons.converters.ByteConverter;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class ZipUtil {
  private ZipUtil() {
    //added private build in order to avoid class instanciation because it is utility class
  }
    public static String compressToHex(String data) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        GZIPOutputStream gzip = new GZIPOutputStream(out);
        gzip.write(data.getBytes());
        gzip.close();
        return ByteConverter.tranformToHex(out.toByteArray());
    }

    public static String decompressFromHex(String dataHex) throws IOException {
        byte[] buffer = new byte[1024];
        ByteArrayInputStream in = new ByteArrayInputStream(ByteConverter.tranformFromHex(dataHex));
        GZIPInputStream gzip = new GZIPInputStream(in);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int len;
        while ((len = gzip.read(buffer)) > 0) {
            out.write(buffer, 0, len);
        }
        gzip.close();
        out.close();
        return out.toString();
    }

}
