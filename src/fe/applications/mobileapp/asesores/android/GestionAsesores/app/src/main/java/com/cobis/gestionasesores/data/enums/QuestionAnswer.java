package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.cobis.gestionasesores.data.enums.QuestionAnswer.NO;
import static com.cobis.gestionasesores.data.enums.QuestionAnswer.YES;

/**
 * Created by bqtdesa02 on 8/18/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({YES,NO})
public @interface QuestionAnswer {
    String YES = "S";
    String NO = "N";
}
