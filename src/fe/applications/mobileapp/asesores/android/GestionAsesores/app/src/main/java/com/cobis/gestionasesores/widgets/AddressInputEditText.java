package com.cobis.gestionasesores.widgets;

import android.content.Context;
import android.content.res.TypedArray;
import android.support.annotation.AttrRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.graphics.drawable.VectorDrawableCompat;
import android.util.AttributeSet;

import com.cobis.gestionasesores.R;

/**
 * Created by bqtdesa02 on 6/30/2017.
 */

public class AddressInputEditText extends TextInputEditText {

    public AddressInputEditText(@NonNull Context context) {
        super(context);
        init(null, 0);
    }

    public AddressInputEditText(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public AddressInputEditText(@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(attrs, defStyleAttr);
    }

    private void init(AttributeSet attrs, int defStyleAttr) {
        TypedArray styledAttributes = getContext().getTheme().obtainStyledAttributes(attrs, R.styleable.AddressInputEditText, defStyleAttr, 0);
        VectorDrawableCompat icon;
        try {
            icon = VectorDrawableCompat.create(getResources(), styledAttributes.getResourceId(R.styleable.AddressInputEditText_ai_icon, R.drawable.ic_address), null);
        } finally {
            styledAttributes.recycle();
        }

        setCompoundDrawablesWithIntrinsicBounds(icon, null, null, null);
        setFocusable(false);
        setFocusableInTouchMode(false);
    }
}
