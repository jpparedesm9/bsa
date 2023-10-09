package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by Miguel on 18/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef
public @interface MeetingLocation {
    String HOME = "RE";
    String WORK = "AE";
}