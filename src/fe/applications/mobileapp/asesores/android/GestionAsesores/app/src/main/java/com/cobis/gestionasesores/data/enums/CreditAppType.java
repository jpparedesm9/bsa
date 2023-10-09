package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Credit application Types
 * Created by mnaunay on 22/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({CreditAppType.INDIVIDUAL, CreditAppType.GROUP, CreditAppType.UNKNOWN})
public @interface CreditAppType {
    String GROUP = "G";
    String INDIVIDUAL = "I";
    String UNKNOWN = "";
}