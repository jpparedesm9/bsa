package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Person types supported
 * Created by mnaunay on 28/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@IntDef({PersonType.CUSTOMER, PersonType.PROSPECT, PersonType.UNKNOWN})
public @interface PersonType {
    int CUSTOMER = 1;
    int PROSPECT = 2;
    int UNKNOWN = -1;
}
