package com.cobis.gestionasesores.widgets;

import android.content.Context;
import android.content.res.TypedArray;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.cobis.gestionasesores.R;

import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by JosueOrtiz on 21/08/2017.
 */

public class PinView extends LinearLayout {

    private static final int PIN_LENGTH_FALLBACK = 4;

    private int maxPinLength;
    private String mPin = "";

    private LinearLayout digitView;
    private PinListener mListener;

    public void setListener(PinListener mListener) {
        this.mListener = mListener;
    }

    public PinView(Context context) {
        super(context);
        init(null, 0);
    }

    public PinView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public PinView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(attrs, defStyleAttr);
    }

    private void init(@Nullable AttributeSet attrs, int defStyleAttr) {
        TypedArray styledAttributes = getContext().getTheme().obtainStyledAttributes(attrs, R.styleable.PinView, defStyleAttr, 0);
        try {
            maxPinLength = styledAttributes.getInt(R.styleable.PinView_pv_pin_length, PIN_LENGTH_FALLBACK);
        } finally {
            styledAttributes.recycle();
        }

        inflate(getContext(), R.layout.view_pin, this);
        ButterKnife.bind(this);
    }

    @OnClick({R.id.btn_number_0,
            R.id.btn_number_1,
            R.id.btn_number_2,
            R.id.btn_number_3,
            R.id.btn_number_4,
            R.id.btn_number_5,
            R.id.btn_number_6,
            R.id.btn_number_7,
            R.id.btn_number_8,
            R.id.btn_number_9})
    public void onClickButton(View view) {
        switch (view.getId()) {
            case R.id.btn_number_0:
                mPin += 0;
                mListener.onNumberPressed("0");
                break;
            case R.id.btn_number_1:
                mPin += 1;
                mListener.onNumberPressed("1");
                break;
            case R.id.btn_number_2:
                mPin += 2;
                mListener.onNumberPressed("2");
                break;
            case R.id.btn_number_3:
                mPin += 3;
                mListener.onNumberPressed("3");
                break;
            case R.id.btn_number_4:
                mPin += 4;
                mListener.onNumberPressed("4");
                break;
            case R.id.btn_number_5:
                mPin += 5;
                mListener.onNumberPressed("5");
                break;
            case R.id.btn_number_6:
                mPin += 6;
                mListener.onNumberPressed("6");
                break;
            case R.id.btn_number_7:
                mPin += 7;
                mListener.onNumberPressed("7");
                break;
            case R.id.btn_number_8:
                mPin += 8;
                mListener.onNumberPressed("8");
                break;
            case R.id.btn_number_9:
                mPin += 9;
                mListener.onNumberPressed("9");
                break;
        }

        if (mPin.length() <= maxPinLength) {
            ImageView img = (ImageView) digitView.findViewById(mPin.length()-1);
            if (img != null) {
                img.setImageResource(R.drawable.bg_pin_digit_on);
            }
        }

        if (mPin.length() == maxPinLength) {
            mListener.onComplete(mPin);
        }
    }

    @OnClick(R.id.btn_clear)
    public void onClearButtonPressed() {
        mPin = "";
        mListener.onDeleteAll();
        for (int i = 0; i < maxPinLength; i++) {
            ImageView img = (ImageView) digitView.findViewById(i);
            if (img != null) {
                img.setImageResource(R.drawable.bg_pin_digit_off);
            }
        }
    }

    @OnClick(R.id.btn_backspace)
    public void onBackSpaceButtonPressed() {
        if (mPin.length() > 0) {
            mPin = mPin.substring(0, mPin.length() - 1);
            ImageView img = (ImageView) digitView.findViewById(mPin.length());
            if (img != null) {
                img.setImageResource(R.drawable.bg_pin_digit_off);
            }
            mListener.onDelete(mPin);
        }
    }

    public void setDigitView(LinearLayout digitView) {
        this.digitView = digitView;
        for (int i = 0; i < maxPinLength; i++) {
            ImageView itemPin;
            itemPin = (ImageView) LayoutInflater.from(getContext()).inflate(R.layout.digit_pin_view, digitView, false);
            itemPin.setId(i);
            this.digitView.addView(itemPin);
        }
    }

    public interface PinListener {
        void onComplete(String pin);

        void onNumberPressed(String key);

        void onDeleteAll();

        void onDelete(String actualPin);
    }
}
