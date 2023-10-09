package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by Miguel on 20/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({CivilStatus.SINGLE,CivilStatus.MARRIED,CivilStatus.COMMON_LAW_MARRIAGE})
public @interface CivilStatus {
    String SINGLE ="SO";
    String MARRIED = "CA";
    String COMMON_LAW_MARRIAGE = "UN";
}