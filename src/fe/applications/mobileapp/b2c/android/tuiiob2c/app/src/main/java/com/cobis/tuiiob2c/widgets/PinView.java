//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.cobis.tuiiob2c.widgets;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.cobis.tuiiob2c.R;

public class PinView extends LinearLayout {
    private static final int PIN_LENGTH_FALLBACK = 4;
    private int maxPinLength;
    private String mPin = "";
    private LinearLayout digitView;
    private PinView.PinListener mListener;
    private OnClickListener onClickNumber = new OnClickListener() {
        public void onClick(View v) {
            int i = v.getId();
            if (i == R.id.btn_number_0) {
                PinView.this.mPin = PinView.this.mPin + 0;
                PinView.this.mListener.onNumberPressed("0");
            } else if (i == R.id.btn_number_1) {
                PinView.this.mPin = PinView.this.mPin + 1;
                PinView.this.mListener.onNumberPressed("1");
            } else if (i == R.id.btn_number_2) {
                PinView.this.mPin = PinView.this.mPin + 2;
                PinView.this.mListener.onNumberPressed("2");
            } else if (i == R.id.btn_number_3) {
                PinView.this.mPin = PinView.this.mPin + 3;
                PinView.this.mListener.onNumberPressed("3");
            } else if (i == R.id.btn_number_4) {
                PinView.this.mPin = PinView.this.mPin + 4;
                PinView.this.mListener.onNumberPressed("4");
            } else if (i == R.id.btn_number_5) {
                PinView.this.mPin = PinView.this.mPin + 5;
                PinView.this.mListener.onNumberPressed("5");
            } else if (i == R.id.btn_number_6) {
                PinView.this.mPin = PinView.this.mPin + 6;
                PinView.this.mListener.onNumberPressed("6");
            } else if (i == R.id.btn_number_7) {
                PinView.this.mPin = PinView.this.mPin + 7;
                PinView.this.mListener.onNumberPressed("7");
            } else if (i == R.id.btn_number_8) {
                PinView.this.mPin = PinView.this.mPin + 8;
                PinView.this.mListener.onNumberPressed("8");
            } else if (i == R.id.btn_number_9) {
                PinView.this.mPin = PinView.this.mPin + 9;
                PinView.this.mListener.onNumberPressed("9");
            }

            if (PinView.this.mPin.length() <= PinView.this.maxPinLength) {
                ImageView img = (ImageView)PinView.this.digitView.findViewById(PinView.this.mPin.length() - 1);
                if (img != null) {
                    img.setImageResource(R.drawable.bg_pin_digit_on);
                }
            }

            if (PinView.this.mPin.length() == PinView.this.maxPinLength) {
                PinView.this.mListener.onComplete(PinView.this.mPin);
            }

        }
    };


    private OnClickListener mOnClickClear = new OnClickListener() {
        public void onClick(View v) {
            PinView.this.clear();
        }
    };
    private OnClickListener mOnClickBackspace = new OnClickListener() {
        public void onClick(View v) {
            if (PinView.this.mPin.length() > 0) {
                PinView.this.mPin = PinView.this.mPin.substring(0, PinView.this.mPin.length() - 1);
                ImageView img = (ImageView)PinView.this.digitView.findViewById(PinView.this.mPin.length());
                if (img != null) {
                    img.setImageResource(R.drawable.bg_pin_digit_off);
                }

                PinView.this.mListener.onDelete(PinView.this.mPin);
            }

        }
    };

    public void setListener(PinView.PinListener mListener) {
        this.mListener = mListener;
    }

    public PinView(Context context) {
        super(context);
        this.init((AttributeSet)null, 0);
    }

    public PinView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        this.init(attrs, 0);
    }

    public PinView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        this.init(attrs, defStyleAttr);
    }

    private void init(@Nullable AttributeSet attrs, int defStyleAttr) {
        TypedArray styledAttributes = this.getContext().getTheme().obtainStyledAttributes(attrs, R.styleable.PinView, defStyleAttr, 0);

        try {
            this.maxPinLength = styledAttributes.getInt(R.styleable.PinView_pv_pin_length, 4);
        } finally {
            styledAttributes.recycle();
        }

        inflate(this.getContext(), R.layout.view_pin, this);
    }

    protected void onFinishInflate() {
        super.onFinishInflate();
        setActive();
    }

    private void setActive(){
        Button btnNumber0 = (Button)this.findViewById(R.id.btn_number_0);
        Button btnNumber1 = (Button)this.findViewById(R.id.btn_number_1);
        Button btnNumber2 = (Button)this.findViewById(R.id.btn_number_2);
        Button btnNumber3 = (Button)this.findViewById(R.id.btn_number_3);
        Button btnNumber4 = (Button)this.findViewById(R.id.btn_number_4);
        Button btnNumber5 = (Button)this.findViewById(R.id.btn_number_5);
        Button btnNumber6 = (Button)this.findViewById(R.id.btn_number_6);
        Button btnNumber7 = (Button)this.findViewById(R.id.btn_number_7);
        Button btnNumber8 = (Button)this.findViewById(R.id.btn_number_8);
        Button btnNumber9 = (Button)this.findViewById(R.id.btn_number_9);
        btnNumber0.setOnClickListener(this.onClickNumber);
        btnNumber0.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber1.setOnClickListener(this.onClickNumber);
        btnNumber1.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber2.setOnClickListener(this.onClickNumber);
        btnNumber2.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber3.setOnClickListener(this.onClickNumber);
        btnNumber3.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber4.setOnClickListener(this.onClickNumber);
        btnNumber4.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber5.setOnClickListener(this.onClickNumber);
        btnNumber5.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber6.setOnClickListener(this.onClickNumber);
        btnNumber6.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber7.setOnClickListener(this.onClickNumber);
        btnNumber7.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber8.setOnClickListener(this.onClickNumber);
        btnNumber8.setTextColor(getResources().getColor(R.color.primaryText_icons));
        btnNumber9.setOnClickListener(this.onClickNumber);
        btnNumber9.setTextColor(getResources().getColor(R.color.primaryText_icons));
        ImageButton backSpaceBtn = (ImageButton)this.findViewById(R.id.btn_backspace);
        backSpaceBtn.setOnClickListener(this.mOnClickBackspace);
        backSpaceBtn.setColorFilter(Color.BLACK);
        ImageButton clearBtn = (ImageButton)this.findViewById(R.id.btn_clear);
        clearBtn.setOnClickListener(this.mOnClickClear);
        clearBtn .setColorFilter(Color.BLACK);
    }

    private void setUnactive(){
        Button btnNumber0 = (Button)this.findViewById(R.id.btn_number_0);
        Button btnNumber1 = (Button)this.findViewById(R.id.btn_number_1);
        Button btnNumber2 = (Button)this.findViewById(R.id.btn_number_2);
        Button btnNumber3 = (Button)this.findViewById(R.id.btn_number_3);
        Button btnNumber4 = (Button)this.findViewById(R.id.btn_number_4);
        Button btnNumber5 = (Button)this.findViewById(R.id.btn_number_5);
        Button btnNumber6 = (Button)this.findViewById(R.id.btn_number_6);
        Button btnNumber7 = (Button)this.findViewById(R.id.btn_number_7);
        Button btnNumber8 = (Button)this.findViewById(R.id.btn_number_8);
        Button btnNumber9 = (Button)this.findViewById(R.id.btn_number_9);
        btnNumber0.setOnClickListener(null);
        btnNumber0.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber1.setOnClickListener(null);
        btnNumber1.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber2.setOnClickListener(null);
        btnNumber2.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber3.setOnClickListener(null);
        btnNumber3.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber4.setOnClickListener(null);
        btnNumber4.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber5.setOnClickListener(null);
        btnNumber5.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber6.setOnClickListener(null);
        btnNumber6.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber7.setOnClickListener(null);
        btnNumber7.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber8.setOnClickListener(null);
        btnNumber8.setTextColor(getResources().getColor(R.color.secondaryText));
        btnNumber9.setOnClickListener(null);
        btnNumber9.setTextColor(getResources().getColor(R.color.secondaryText));

        ImageButton backSpaceBtn = (ImageButton)this.findViewById(R.id.btn_backspace);
        backSpaceBtn.setColorFilter(Color.GRAY);
        backSpaceBtn.setOnClickListener(null);
        ImageButton clearBtn = (ImageButton)this.findViewById(R.id.btn_clear);
        clearBtn.setColorFilter(Color.GRAY);
        clearBtn.setOnClickListener(null);
    }

    public void setDigitView(LinearLayout digitView) {
        this.digitView = digitView;

        for(int i = 0; i < this.maxPinLength; ++i) {
            //ImageView itemPin = (ImageView)LayoutInflater.from(this.getContext()).inflate(R.layout.digit_pin_view, digitView, false);
            View view = LayoutInflater.from(this.getContext()).inflate(R.layout.digit_pin_view, digitView, false);
            ImageView itemPin = view.findViewById(R.id.image);
            itemPin.setId(i);
            this.digitView.addView(view);
        }

    }

    public void clear() {
        this.mPin = "";
        this.mListener.onDeleteAll();

        for(int i = 0; i < this.maxPinLength; ++i) {
            ImageView img = (ImageView)this.digitView.findViewById(i);
            if (img != null) {
                img.setImageResource(R.drawable.bg_pin_digit_off);
            }
        }

    }

    public void setActive(Boolean b){
        if (b){
            setActive();
        }else{
            setUnactive();
        }
    }

    public interface PinListener {
        void onComplete(String var1);

        void onNumberPressed(String var1);

        void onDeleteAll();

        void onDelete(String var1);
    }
}
