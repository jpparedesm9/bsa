package com.ibm.test.impl;

import org.junit.Ignore;

import com.ibm.test.NativeInvoke;
@Ignore
public class NativeCode{

	static{
		System.loadLibrary("JNITestProject");
		System.out.println("JNITestProject.dll");
	  }     
	
	public int sum(Integer a, Integer b) {
		return NativeInvoke.sum(a.intValue(), b.intValue());
	}

	public double sum(double a, double b) {
		return NativeInvoke.sum(a, b);
	}

	public double sum(double[] a) {
		return NativeInvoke.sum(a);
	}

	public double[] twice(double[] a) {
		return NativeInvoke.twice(a);
	}

	public static void main(String[] args) {
		NativeCode n = new NativeCode();
		
		System.out.println(n.sum(4,7));
	}
}
