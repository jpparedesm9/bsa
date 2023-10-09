package com.cobis.gestionasesores.widgets;

import android.content.Context;
import android.content.res.TypedArray;
import android.support.annotation.AttrRes;
import android.support.annotation.IntDef;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.cobis.gestionasesores.R;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.cobis.gestionasesores.widgets.BooleanQuestionView.CheckOption.NEGATIVE;
import static com.cobis.gestionasesores.widgets.BooleanQuestionView.CheckOption.NONE;
import static com.cobis.gestionasesores.widgets.BooleanQuestionView.CheckOption.POSITIVE;

/**
 * Created by Jose on 8/16/2017.
 */

public class BooleanQuestionView extends FrameLayout {

    @Retention(RetentionPolicy.SOURCE)
    @IntDef({NONE, POSITIVE, NEGATIVE})
    public @interface CheckOption {
        int NONE = 0;
        int POSITIVE = 1;
        int NEGATIVE = 2;
    }

    private TextView mQuestionText;
    private RadioGroup mRadioGroup;
    private RadioButton mPositiveRadioBtn;
    private RadioButton mNegativeRadioBtn;

    private String mQuestion;
    private String mPositiveText;
    private String mNegativeText;

    private OnOptionCheckListener mListener;

    public BooleanQuestionView(@NonNull Context context) {
        super(context);
        init(null, 0);
    }

    public BooleanQuestionView(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(attrs, 0);
    }

    public BooleanQuestionView(@NonNull Context context, @Nullable AttributeSet attrs, @AttrRes int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(attrs, defStyleAttr);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        mQuestionText = (TextView) findViewById(R.id.text_question);
        mRadioGroup = (RadioGroup) findViewById(R.id.radio_group);
        mPositiveRadioBtn = (RadioButton) findViewById(R.id.radio_button_positive);
        mNegativeRadioBtn = (RadioButton) findViewById(R.id.radio_button_negative);

        mQuestionText.setText(mQuestion);

        mPositiveRadioBtn.setText(mPositiveText == null ? getContext().getString(R.string.boolean_question_view_default_positive) : mPositiveText);
        mNegativeRadioBtn.setText(mNegativeText == null ? getContext().getString(R.string.boolean_question_view_default_negative) : mNegativeText);

        mPositiveRadioBtn.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mListener == null) return;
                mListener.onCheck(POSITIVE);
            }
        });

        mNegativeRadioBtn.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mListener == null) return;
                mListener.onCheck(NEGATIVE);
            }
        });
    }

    private void init(AttributeSet attrs, int defStyleAttr) {
        TypedArray styledAttributes = getContext().getTheme().obtainStyledAttributes(attrs, R.styleable.BooleanQuestionView, defStyleAttr, 0);
        try {
            mQuestion = styledAttributes.getString(R.styleable.BooleanQuestionView_bqv_question);
            mPositiveText = styledAttributes.getString(R.styleable.BooleanQuestionView_bqv_positive_text);
            mNegativeText = styledAttributes.getString(R.styleable.BooleanQuestionView_bqv_negative_text);
        } finally {
            styledAttributes.recycle();
        }

        inflate(getContext(), R.layout.layout_boolean_question, this);
    }

    @Nullable
    public Boolean getResponse() {
        int checkedId = mRadioGroup.getCheckedRadioButtonId();
        if (checkedId == -1) return null;
        return checkedId == R.id.radio_button_positive;
    }

    public void checkOption(Boolean option) {
        if (option == null) {
            mRadioGroup.clearCheck();
        } else if (option) {
            mRadioGroup.check(R.id.radio_button_positive);
        } else {
            mRadioGroup.check(R.id.radio_button_negative);
        }
    }

    public void setOptionCheckListener(OnOptionCheckListener listener) {
        mListener = null;
        mListener = listener;
    }

    public void showError(@StringRes int error) {
        mQuestionText.setError(getContext().getString(error));
    }

    public void clearError() {
        mQuestionText.setError(null);
    }

    public void setEnabled(boolean enable) {
        mRadioGroup.setEnabled(enable);
    }

    public void setInteractiv (boolean interactive){
        mPositiveRadioBtn.setTextColor(interactive ? getResources().getColor(R.color.colorFabItemLabel)  : getResources().getColor(R.color.colorAccent));
        mPositiveRadioBtn.setClickable(interactive);
        mNegativeRadioBtn.setTextColor(interactive ? getResources().getColor(R.color.colorFabItemLabel)  : getResources().getColor(R.color.colorAccent));
        mNegativeRadioBtn.setClickable(interactive);
    }

    public void setQuestion(String question) {
        mQuestion = question;
        mQuestionText.setText(question);
    }

    public interface OnOptionCheckListener {
        void onCheck(@CheckOption int checkedOption);
    }
}
