package com.cobis.tuiiob2c.data.models;

import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

public class ViewQuestionModel {

    private TextView titleView;
    private EditText aswerView;
    private CheckBox booleanView;
    private Question question;

    public TextView getTitleView() {
        return titleView;
    }

    public ViewQuestionModel setTitleView(TextView titleView) {
        this.titleView = titleView;
        return this;
    }

    public EditText getAswerView() {
        return aswerView;
    }

    public ViewQuestionModel setAswerView(EditText aswerView) {
        this.aswerView = aswerView;
        return this;
    }

    public CheckBox getBooleanView() {
        return booleanView;
    }

    public ViewQuestionModel setBooleanView(CheckBox booleanView) {
        this.booleanView = booleanView;
        return this;
    }

    public Question getQuestion() {
        return question;
    }

    public ViewQuestionModel setQuestion(Question question) {
        this.question = question;
        return this;
    }
}
