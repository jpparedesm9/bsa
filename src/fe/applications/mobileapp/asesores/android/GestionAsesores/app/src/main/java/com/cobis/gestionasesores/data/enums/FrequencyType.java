package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by User on 09/08/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({FrequencyType.WEEKLY,FrequencyType.BIWEEKLY,FrequencyType.MONTHLY})

public @interface FrequencyType {
    String MONTHLY = "M";
    String BIWEEKLY = "Q";
    String WEEKLY = "W";

}
