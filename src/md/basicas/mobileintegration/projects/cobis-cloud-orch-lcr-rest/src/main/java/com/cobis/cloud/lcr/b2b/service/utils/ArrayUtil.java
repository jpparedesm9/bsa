package com.cobis.cloud.lcr.b2b.service.utils;

import java.lang.reflect.Array;

/**
 * @author Cesar Loachamin
 */
public class ArrayUtil {

    private ArrayUtil() {
    }

    public static <T> T find(T[] array, Predicate<T> predicate) {
        if (array == null) {
            return null;
        }
        for (T element : array) {
            if (predicate.test(element)) {
                return element;
            }
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    public static<T, V> V[] map(T[] array, Class<V> clazz,  Function<T, V> function) {
        if (array == null) {
            return null;
        }
        V[] result = (V[])  Array.newInstance(clazz, array.length);
        for (int i = 0; i < array.length; i++) {
            result[i] = function.call(array[i]);
        }
        return result;
    }

    public interface Predicate<T> {
        boolean test(T obj);
    }

    public interface Function<T, V> {
        V call(T obj);
    }
}