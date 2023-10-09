package com.cobis.gestionasesores.utils;

import android.content.Context;
import android.content.res.XmlResourceParser;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.net.Uri;
import android.provider.MediaStore;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.io.FileUtils;
import com.bayteq.libcore.io.LibCoreIO;
import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.PositionGroup;

import org.xmlpull.v1.XmlPullParser;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Utilities operations
 * Created by mnaunay on 14/06/2017.
 */

public final class Util {
    private Util() {
    }

    /**
     * Allow rotate image with specific angle
     *
     * @param source Bitmap to rotate
     * @param angle  Rotation angle
     * @return Bitmap rotated
     */
    public static Bitmap rotateImage(Bitmap source, int angle) {
        Matrix matrix = new Matrix();
        matrix.postRotate(angle);
        return Bitmap.createBitmap(source, 0, 0, source.getWidth(), source.getHeight(), matrix, true);
    }

    /**
     * Allows get orientation of the image
     *
     * @param context  Android context
     * @param photoUri Uri of the photo
     * @return Orientation
     */
    public static int getOrientation(Context context, Uri photoUri) {
        try {
            Cursor cursor = context.getContentResolver().query(photoUri, new String[]{MediaStore.Images.ImageColumns.ORIENTATION}, null, null, null);

            if (cursor.getCount() != 1) {
                return -1;
            }

            cursor.moveToFirst();
            return cursor.getInt(0);
        } catch (Exception ex) {
            Log.e("Util::getOrientation: ", ex);
            return 0;
        }
    }

    /**
     * Allows convert a Bitmap to byte array
     *
     * @param image Bitmap
     * @return byte array
     */
    public static byte[] bitmapToBytes(Bitmap image) {
        byte[] result = null;
        try {
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            image.compress(Bitmap.CompressFormat.JPEG, 100, stream);
            result = stream.toByteArray();
            stream.close();
        } catch (Exception e) {
            Log.e("Util::bitmapToBytes:", e);
        }
        return result;
    }

    /**
     * Allows create Uri from path
     *
     * @param uri Uri path
     * @return Uri
     */
    public static Uri createUri(String uri) {
        Uri result;
        if (uri != null && uri.length() > 0) {
            if (uri.startsWith("htt") || uri.startsWith("https")) {
                result = Uri.parse(uri);
            } else if (FileUtils.exists(uri)) {
                result = Uri.fromFile(new File(uri));
            } else {
                result = null;
            }
        } else {
            result = null;
        }
        return result;
    }

    /**
     * Allows get position order
     *
     * @param positionGroup Position
     * @return Integer that represent position order
     */
    public static int getPositionGroupOrder(@PositionGroup String positionGroup) {
        switch (positionGroup) {
            case PositionGroup.PRESIDENT:
                return 3;
            case PositionGroup.SECRETARY:
                return 2;
            case PositionGroup.TREASURER:
                return 1;
            default:
                return -1;
        }
    }

    /**
     * Allows parse xml default configurations to Map
     *
     * @param parser XML resource parser
     * @return Map with default configurations
     */
    public static Map<String, String> parseParameters(XmlResourceParser parser) {
        Map<String, String> result = new HashMap<>();
        try {
            String key, value;
            while (parser.next() != XmlPullParser.END_DOCUMENT) {
                if (parser.getEventType() != XmlPullParser.START_TAG) {
                    continue;
                }
                key = parser.getAttributeValue(null, "name");
                value = parser.getAttributeValue(null, "value");

                Log.i(key + ": " + value);
                if (key != null && value != null) {
                    result.put(key, value);
                }
            }
            return result;
        } catch (Exception ex) {
            Log.e("Util::parseParameters: ", ex);
        }
        return result;
    }

    /**
     * Allows unzip file from stream
     * https://stackoverflow.com/questions/3382996/how-to-unzip-files-programmatically-in-android
     *
     * @param zipFile         Zip File stream
     * @param targetDirectory Directory where zip will be unzipped
     * @throws IOException
     */
    public static void unzip(InputStream zipFile, File targetDirectory) throws IOException {
        ZipInputStream zis = new ZipInputStream(new BufferedInputStream(zipFile));
        try {
            ZipEntry ze;
            int count;
            byte[] buffer = new byte[8192];
            while ((ze = zis.getNextEntry()) != null) {
                File file = new File(targetDirectory, ze.getName());
                File dir = ze.isDirectory() ? file : file.getParentFile();
                if (!dir.isDirectory() && !dir.mkdirs())
                    throw new FileNotFoundException("Failed to ensure directory: " + dir.getAbsolutePath());
                if (ze.isDirectory()) continue;
                FileOutputStream fout = new FileOutputStream(file);
                try {
                    while ((count = zis.read(buffer)) != -1) fout.write(buffer, 0, count);
                } finally {
                    fout.close();
                }
            }
        } finally {
            zis.close();
        }
    }

    /**
     * Checks whether Throwable is of kind of "Network" error
     *
     * @param t Throwable
     * @return
     */
    public static boolean isNetworkError(Throwable t) {
        return (t instanceof IOException);
    }

    /**
     * Allows toggle key board for the input view
     *
     * @param view View
     */
    public static void toggleSoftKeyboard(View view) {
        try {
            if (view != null) {
                InputMethodManager ex = (InputMethodManager) LibCore.getApplicationContext().getSystemService(Context.INPUT_METHOD_SERVICE);
                ex.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);
            }
        } catch (Exception var2) {
            Log.e("Util::toggleSoftKeyboard: ", var2);
        }
    }

    /**
     * Allows to convert Integer List to native int array
     *
     * @param integers Integer List
     * @return integer array
     */
    public static int[] convertIntegers(List<Integer> integers) {
        int[] ret = new int[integers.size()];
        for (int i = 0; i < ret.length; i++) {
            ret[i] = integers.get(i).intValue();
        }
        return ret;
    }

    public static String getDocumentPath(String docType, String extension) {

        String path = null;
        try {
            String documentsFolder = LibCoreIO.getAppDirectory() + "/documents";
            if (!FileUtils.exists(documentsFolder)) {
                FileUtils.createDirectory(documentsFolder);
            }
            path = documentsFolder + "/" + docType + "_" + getTimeStampString() + "." + extension;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return path;
    }

    public static String getTimeStampString() {
        return new SimpleDateFormat("yyyyMMddHHmmss", Locale.US).format(Calendar.getInstance().getTime());
    }

    public static String formatPhone(String rawPhone, String countryCode) {
        if (rawPhone == null || rawPhone.length() < 10) return rawPhone;
        StringBuilder builder = new StringBuilder(rawPhone);
        if (countryCode != null) {
            if (rawPhone.startsWith("+") && !countryCode.contains("+")) {
                countryCode = "+" + countryCode;
            }
            if (rawPhone.startsWith(countryCode) && builder.length() > 10) {
                builder.delete(0, countryCode.length());
            }
        }
        if (builder.length() == 10) {
            builder.insert(3, " ");
            builder.insert(7, " ");
        }
        return builder.toString();
    }

    public static String formatRawNumber(String number, String countryCode) {
        if (number == null) return null;
        if (number.contains(" ")) {
            number = number.replace(" ", "");
        }
        StringBuilder builder = new StringBuilder(number);
        if (countryCode != null && number.startsWith(countryCode)) {
            builder.delete(0, countryCode.length());
        }
        return builder.toString();
    }

    private final static char[] hexArray = "0123456789ABCDEF".toCharArray();

    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[j * 2 + 1] = hexArray[v & 0x0F];
        }
        return new String(hexChars);
    }
}