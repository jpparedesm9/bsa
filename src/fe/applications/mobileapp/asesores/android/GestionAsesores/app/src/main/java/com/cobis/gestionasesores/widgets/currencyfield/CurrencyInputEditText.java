package com.cobis.gestionasesores.widgets.currencyfield;

import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.support.design.widget.TextInputEditText;
import android.text.InputType;
import android.util.AttributeSet;

import com.cobis.gestionasesores.R;

import java.util.Currency;
import java.util.Locale;

/**
 * Currency input text is a custom view for handler currency values.
 * The original implementation was forked from https://github.com/BlacKCaT27/CurrencyEditText
 * Created by mnaunay on 30/06/2017.
 */
public class CurrencyInputEditText extends TextInputEditText {
    private Locale mLocale;
    private Currency mCurrency;
    private CurrencyTextWatcher mTextWatcher;
    private boolean mDefaultHintEnabled = false;
    private boolean mAllowNegativeValues = false;
    private long mValueInLowestDenom = 0L;

    public CurrencyInputEditText(Context context) {
        super(context);
        initSettings(context,null);
    }

    public CurrencyInputEditText(Context context, AttributeSet attrs) {
        super(context, attrs);
        initSettings(context,attrs);
    }

    public CurrencyInputEditText(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initSettings(context,attrs);
    }

    private void initSettings(Context context, AttributeSet attrs){
        this.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL | InputType.TYPE_NUMBER_FLAG_SIGNED);
        TypedArray a = context.getTheme().obtainStyledAttributes(attrs, R.styleable.CurrencyInputEditText, 0, 0);
        try {
            mDefaultHintEnabled = a.getBoolean(R.styleable.CurrencyInputEditText_cit_hint, false);
        }finally {
            a.recycle();
        }
        mLocale = getDefaultLocale();
        invalidateSettings();
        updateHint();
    }


    private void invalidateSettings() {
        initCurrency();
        initCurrencyTextWatcher();
    }

    private Locale getDefaultLocale() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            return getContext().getResources().getConfiguration().getLocales().get(0);
        } else {
            return getContext().getResources().getConfiguration().locale;
        }
    }

    private void initCurrencyTextWatcher() {
        if (mTextWatcher != null) {
            this.removeTextChangedListener(mTextWatcher);
        }
        mTextWatcher = new CurrencyTextWatcher(this, mLocale);
        this.addTextChangedListener(mTextWatcher);
    }

    private void initCurrency() {
        try {
            mCurrency = Currency.getInstance(mLocale);
        } catch (IllegalArgumentException e) {
            mCurrency = Currency.getInstance(getDefaultLocale());
        }
    }

    /**
     * Determine whether or not the default hint is currently enabled for this view.
     *
     * @return true if the default hint is enabled, false if it is not.
     */
    public boolean getDefaultHintEnabled() {
        return this.mDefaultHintEnabled;
    }

    /**
     * Sets whether or or not the Default Hint (users local mCurrency symbol) will be shown in the textbox when no value has yet been entered.
     *
     * @param useDefaultHint - true to enable default hint, false to disable
     */
    public void setDefaultHintEnabled(boolean useDefaultHint) {
        this.mDefaultHintEnabled = useDefaultHint;
    }

    /**
     * Enable the user to input negative values
     */
    public void setAllowNegativeValues(boolean negativeValuesAllowed) {
        mAllowNegativeValues = negativeValuesAllowed;
    }

    /**
     * Returns whether or not negative values have been allowed for this CurrencyEditText field
     */
    public boolean areNegativeValuesAllowed() {
        return mAllowNegativeValues;
    }

    /**
     * Retrieve the raw value that was input by the user in their currencies lowest denomination (e.g. pennies).
     * <p>
     * IMPORTANT: Remember that the location of the decimal varies by mCurrency/Locale. This method
     * returns the raw given value, and does not account for locality of the user. It is up to the
     * calling application to handle that level of conversion.
     * For example, if the text of the field is $13.37, this method will return a long with a
     * value of 1337, as penny is the lowest denomination for USD. It will be up to the calling
     * application to know that it needs to handle this value as pennies and not some other denomination.
     *
     * @return The raw value that was input by the user, in the lowest denomination of that users
     * mLocale.
     */
    public long getRawValue() {
        return mValueInLowestDenom;
    }

    /**
     * Convenience method to retrieve the users Locale object. The same as calling
     * getResources().getConfiguration().mLocale
     *
     * @return the Locale object for the given users configuration
     */
    public Locale getLocale() {
        return mLocale;
    }

    /**
     * Override the mLocale used by CurrencyEditText (which is the users device mLocale by default).
     * WARNING: If this method is used to set the mLocale to one not supported by ISO 3166,
     * formatting the text will throw an exception. Also keep in mind that calling this method
     * will set the hint based on the specified mLocale, which will override any previous hint value.
     *
     * @param locale The mLocale to set the CurrencyEditText box to adhere to.
     */
    public void setLocale(Locale locale) {
        this.mLocale = locale;
        invalidateSettings();
        updateHint();
    }

    public void setCurrency(Currency currency, Locale locale) {
        this.mCurrency = currency;
        this.mLocale = locale;

        invalidateSettings();
        updateHint();
    }

    public Currency getCurrency() {
        return mCurrency;
    }

    public void setCurrency(Currency currency) {
        this.mCurrency = currency;

        invalidateSettings();
        updateHint();
    }

    private void updateHint() {
        if (mDefaultHintEnabled) {
            setHint(getDefaultHintValue());
        }
    }

    /**
     * Pass in a value to have it formatted using the same rules used during data entry.
     *
     * @param val A string which represents the value you'd like formatted. It is expected that this string will be in the same format returned by the getRawValue() method (i.e. a series of digits, such as
     *            "1000" to represent "$10.00"). Note that formatCuurrency will take in ANY string, and will first strip any non-digit characters before working on that string. If the result of that processing
     *            reveals an empty string, or a string whose number of digits is greater than the max number of digits, an exception will be thrown.
     * @return A mLocale-formatted string of the passed in value, represented as mCurrency.
     */
    public String formatCurrency(String val) {
        return CurrencyTextFormatter.formatText(val, mCurrency, mLocale, getDefaultLocale());
    }

    /**
     * Pass in a value to have it formatted using the same rules used during data entry.
     *
     * @param rawVal A long which represents the value you'd like formatted. It is expected that this value will be in the same format returned by the getRawValue() method (i.e. a series of digits, such as
     *               "1000" to represent "$10.00").
     * @return A mLocale-formatted string of the passed in value, represented as mCurrency.
     */
    public String formatCurrency(long rawVal) {
        return CurrencyTextFormatter.formatText(String.valueOf(rawVal), mCurrency, mLocale, getDefaultLocale());
    }


    public double getCurrencyValue() {
        return CurrencyTextFormatter.formatDouble(String.valueOf(mValueInLowestDenom), mCurrency, mLocale, getDefaultLocale());
    }

    public void setCurrencyValue(double currency) {
        String stringValue = CurrencyTextFormatter.formatText(currency, mLocale, getDefaultLocale());
        setText(stringValue);
    }

    protected void setValueInLowestDenom(Long mValueInLowestDenom) {
        this.mValueInLowestDenom = mValueInLowestDenom;
    }

    private String getDefaultHintValue() {
        return mCurrency.getSymbol();
    }
}
