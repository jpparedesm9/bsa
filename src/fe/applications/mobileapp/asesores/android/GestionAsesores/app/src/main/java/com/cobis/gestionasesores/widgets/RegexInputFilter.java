package com.cobis.gestionasesores.widgets;

import android.text.InputFilter;
import android.text.SpannableStringBuilder;
import android.text.Spanned;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by bqtdesa02 on 8/1/2017.
 */

public class RegexInputFilter implements InputFilter {

    public static final String REGEX_ONLY_LETTERS = "[a-zA-Z ]+";
    public static final String REGEX_FIRST_NAME = "[a-zñA-ZÑ ]+((?<=\\bMA)(\\.))?[a-zñA-ZÑ ]*";
    public static final String REGEX_NAMES = "[a-zñA-ZÑ ]+";
    public static final String REGEX_LETTERS_AND_NUMBERS = "[a-zA-Z0-9 ]+";
    public static final String REGEX_ALPHANUMERIC = "[a-zA-Z0-9ñÑ]+";

    private Pattern mPattern;
    private static final String CLASS_NAME = RegexInputFilter.class.getSimpleName();

    public RegexInputFilter(String pattern) {
        this(Pattern.compile(pattern));
    }

    public RegexInputFilter(Pattern pattern) {
        if (pattern == null) {
            throw new IllegalArgumentException(CLASS_NAME + " requires a regex.");
        }

        mPattern = pattern;
    }

    @Override
    public CharSequence filter(CharSequence source, int start, int end,
                               Spanned dest, int dstart, int dend) {
        SpannableStringBuilder builder = new SpannableStringBuilder(dest);
        builder.replace(dstart, dend, source.toString());
        Matcher matcher = mPattern.matcher(builder.toString());
        if (!matcher.matches()) {
            return "";
        }

        return null;
    }
}
