package com.cobiscorp.ecobis.cloud.service.common;

/**
 * @author Cesar Loachamin
 */
public class DataTypeTool {

    private DataTypeTool() {
    }

    public static boolean isNullOrEmpty(String value) {
        return value == null || "".equals(value);
    }

    public static int toInt(String value) {
        return isNullOrEmpty(value) ? 0 : Integer.parseInt(value);
    }

    public static Integer toInteger(String value) {
        return toInt(value);
    }

    @SuppressWarnings("unchecked")
    public static <T> T convertType(String value, Class<T> clazz) {
        if (clazz == String.class) {
            return (T) value;
        } else if (clazz == Integer.class) {
            return (T)toInteger(value);
        } else {
            return clazz.cast(value);
        }
    }
}
