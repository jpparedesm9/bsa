package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by Jose on 8/16/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@IntDef({QuestionType.BOOLEAN, QuestionType.SINGLE_CHOICE, QuestionType.HEADER})
public @interface QuestionType {
    int BOOLEAN = 1;
    int SINGLE_CHOICE = 2;
    int HEADER = 3;
}
