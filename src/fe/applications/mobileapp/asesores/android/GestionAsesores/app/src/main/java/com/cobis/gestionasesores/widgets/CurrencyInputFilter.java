package com.cobis.gestionasesores.widgets;

import android.text.InputFilter;
import android.text.Spanned;

import com.bayteq.libcore.logs.Log;

/**
 * Created by bqtdesa02 on 6/21/2017.
 */

public class CurrencyInputFilter implements InputFilter {

    private String mCurrencySymbol;
    private int mBeforeDecimal = 6;
    private int mAfterDecimal = 2;

    public CurrencyInputFilter() {
        mCurrencySymbol = "$$";
    }

    @Override
    public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
        Log.d("filter() called with: source = [" + source + "], start = [" + start + "], end = [" + end + "], dest = [" + dest + "], dstart = [" + dstart + "], dend = [" + dend + "]");
        Log.d("Source length: " + source.length());

        if(source.length() == 0){
            return null;
        }

        Log.d("Dest length: " + dest.length());

        if(dest.length() == 0){
            if (source.equals(".")) {
                Log.d("Return: " + mCurrencySymbol + " 0.");
                return mCurrencySymbol + "0.";
            }else{
                Log.d("Return: " + mCurrencySymbol + " " + source);
                return "";
            }
        }
        return null;
    }
}
