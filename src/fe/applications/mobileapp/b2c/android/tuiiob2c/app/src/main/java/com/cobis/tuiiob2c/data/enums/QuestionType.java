package com.cobis.tuiiob2c.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.SOURCE)
@StringDef({QuestionType.NUMBER, QuestionType.DATE, QuestionType.ALPHABET})
public @interface QuestionType {
    String NUMBER = "N";
    String DATE = "F";
    String ALPHABET = "A";
}
