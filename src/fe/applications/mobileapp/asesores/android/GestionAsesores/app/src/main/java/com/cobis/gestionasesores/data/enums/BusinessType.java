package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by bqtdesa02 on 6/19/2017.
 */

@Retention(RetentionPolicy.SOURCE)
@StringDef
public @interface BusinessType {
    String TYPE_SAME_ADDRESS = "3";
}
