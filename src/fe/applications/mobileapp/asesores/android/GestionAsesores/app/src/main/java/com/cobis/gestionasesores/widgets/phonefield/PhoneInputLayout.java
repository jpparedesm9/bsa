package com.cobis.gestionasesores.widgets.phonefield;

import android.content.Context;
import android.content.res.TypedArray;
import android.support.design.widget.TextInputLayout;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Spinner;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.utils.Util;
import com.google.i18n.phonenumbers.NumberParseException;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;

/**
 * PhoneInputLayout is a custom view for phone numbers with the corresponding country flag.
 * The original implementation was forked from https://github.com/lamudi-gmbh/android-phone-field
 * <p>
 */
public class PhoneInputLayout extends LinearLayout {
    private String mHint;

    private Spinner mSpinner;

    private EditText mEditText;

    private Country mCountry;

    private TextInputLayout mTextInputLayout;

    private PhoneNumberUtil mPhoneUtil = PhoneNumberUtil.getInstance();

    private int mDefaultCountryPosition = 0;

    /**
     * Instantiates a new Phone field.
     *
     * @param context the context
     */
    public PhoneInputLayout(Context context) {
        this(context, null);
    }

    /**
     * Instantiates a new Phone field.
     *
     * @param context the context
     * @param attrs   the attrs
     */
    public PhoneInputLayout(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    /**
     * Instantiates a new Phone field.
     *
     * @param context      the context
     * @param attrs        the attrs
     * @param defStyleAttr the def style attr
     */
    public PhoneInputLayout(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        TypedArray styledAttributes = getContext().getTheme().obtainStyledAttributes(attrs, R.styleable.PhoneInputLayout, defStyleAttr, 0);
        try {
            mHint = styledAttributes.getString(R.styleable.PhoneInputLayout_pf_hint);
        } finally {
            styledAttributes.recycle();
        }

        inflate(getContext(), R.layout.pf_text_input_layout, this);
    }


    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        updateLayoutAttributes();
        mSpinner = (Spinner) findViewById(R.id.pf_spinner_phone);
        mEditText = (EditText) findViewById(R.id.pf_text_input_phone);
        mTextInputLayout = (TextInputLayout) findViewById(R.id.pf_text_layout_phone);
        mTextInputLayout.setHint(mHint);

        if (mSpinner == null || mEditText == null) {
            throw new IllegalStateException("Please provide a valid xml layout");
        }

        final CountriesAdapter adapter = new CountriesAdapter(getContext(), Countries.COUNTRIES);
        mSpinner.setOnTouchListener(new OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                hideKeyboard();
                return false;
            }
        });

        final TextWatcher textWatcher = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                String rawNumber = s.toString();
                if (rawNumber.isEmpty()) {
                    mSpinner.setSelection(mDefaultCountryPosition);
                } else {
                    if (rawNumber.startsWith("00")) {
                        rawNumber = rawNumber.replaceFirst("00", "+");
                        mEditText.removeTextChangedListener(this);
                        mEditText.setText(rawNumber);
                        mEditText.addTextChangedListener(this);
                        mEditText.setSelection(rawNumber.length());
                    }
                    try {
                        Phonenumber.PhoneNumber number = parsePhoneNumber(rawNumber);
                        if (mCountry == null || mCountry.getDialCode() != number.getCountryCode()) {
                            selectCountry(number.getCountryCode());
                        }
                    } catch (NumberParseException ignored) {
                    }
                }
            }
        };

        mEditText.addTextChangedListener(textWatcher);

        mSpinner.setAdapter(adapter);
        mSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mCountry = adapter.getItem(position);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                mCountry = null;
            }
        });
    }

    /**
     * Gets spinner.
     *
     * @return the spinner
     */
    public Spinner getSpinner() {
        return mSpinner;
    }

    /**
     * Gets edit text.
     *
     * @return the edit text
     */
    public EditText getEditText() {
        return mEditText;
    }

    /**
     * Checks whether the entered phone number is valid or not.
     *
     * @return a boolean that indicates whether the number is of a valid pattern
     */
    public boolean isValid() {
        try {
            return mPhoneUtil.isValidNumber(parsePhoneNumber(getRawInput()));
        } catch (NumberParseException e) {
            return false;
        }
    }

    private Phonenumber.PhoneNumber parsePhoneNumber(String number) throws NumberParseException {
        String defaultRegion = mCountry != null ? mCountry.getCode().toUpperCase() : "";
        return mPhoneUtil.parseAndKeepRawInput(number, defaultRegion);
    }

    /**
     * Gets complete phone number. Example: +521234567890
     *
     * @return the phone number
     */
    public String getPhoneNumber() {
        return Util.formatRawNumber(getRawInput(), null);
    }


    /**
     * Sets default country.
     *
     * @param countryCode the country code
     */
    public void setDefaultCountry(String countryCode) {
        for (int i = 0; i < Countries.COUNTRIES.size(); i++) {
            Country country = Countries.COUNTRIES.get(i);
            if (country.getCode().equalsIgnoreCase(countryCode)) {
                mCountry = country;
                mDefaultCountryPosition = i;
                mSpinner.setSelection(i);
            }
        }
    }

    private void selectCountry(int dialCode) {
        for (int i = 0; i < Countries.COUNTRIES.size(); i++) {
            Country country = Countries.COUNTRIES.get(i);
            if (country.getDialCode() == dialCode) {
                mCountry = country;
                mSpinner.setSelection(i);
            }
        }
    }

    /**
     * Sets phone number.
     *
     * @param rawNumber the raw number
     */
    public void setPhoneNumber(String rawNumber) {
        try {
            Phonenumber.PhoneNumber number = parsePhoneNumber(rawNumber);
            if (mCountry == null || mCountry.getDialCode() != number.getCountryCode()) {
                selectCountry(number.getCountryCode());
            }
            String phoneNumber = Util.formatPhone(rawNumber,String.valueOf(Countries.COUNTRIES.get(0).getDialCode()));
            mEditText.setText(phoneNumber);
        } catch (NumberParseException ignored) {
        }
    }

    private void hideKeyboard() {
        ((InputMethodManager) getContext().getSystemService(
                Context.INPUT_METHOD_SERVICE)).hideSoftInputFromWindow(mEditText.getWindowToken(), 0);
    }

    protected void updateLayoutAttributes() {
        setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        setGravity(Gravity.TOP);
        setOrientation(HORIZONTAL);
    }


    /**
     * Sets hint.
     *
     * @param resId the res id
     */
    public void setHint(int resId) {
        mTextInputLayout.setHint(getContext().getString(resId));
    }

    /**
     * Gets raw input.
     *
     * @return the raw input
     */
    public String getRawInput() {
        return mEditText.getText().toString();
    }

    /**
     * Sets error.
     *
     * @param error the error
     */
    public void setError(String error) {
        if (error == null || error.length() == 0) {
            mTextInputLayout.setErrorEnabled(false);
        } else {
            mTextInputLayout.setErrorEnabled(true);
        }
        mTextInputLayout.setError(error);
    }

    /**
     * Sets text color.
     *
     * @param resId the res id
     */
    public void setTextColor(int resId) {
        mEditText.setTextColor(resId);
    }

}
