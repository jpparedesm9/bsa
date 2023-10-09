package com.ibm.test;

import org.junit.Ignore;

@Ignore
public class NativeInvoke {
    public static native int  sum(int a, int b);
    public static native double sum(double a, double b);
    public static native double sum(double[] a);
    public static native double[] twice(double[] a);
}
