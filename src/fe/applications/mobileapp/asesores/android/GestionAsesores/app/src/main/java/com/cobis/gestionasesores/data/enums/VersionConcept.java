package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by Miguel on 18/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({VersionConcept.CATALOGS,VersionConcept.POSTAL_CODES})
public @interface VersionConcept {
    String CATALOGS = "CA";
    String POSTAL_CODES = "CP";
}
