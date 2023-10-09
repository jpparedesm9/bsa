package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 17/08/2017.
 */
@StringDef({VerificationType.GROUP,VerificationType.INDIVIDUAL})
@Retention(RetentionPolicy.SOURCE)
public @interface VerificationType {
    String INDIVIDUAL = "IN";
    String GROUP = "GP";
}