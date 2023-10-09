package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 10/08/2017.
 */
@StringDef({SimulationType.GROUP,SimulationType.INDIVIDUAL,SimulationType.INTERCYCLE})
@Retention(RetentionPolicy.SOURCE)
public @interface SimulationType {
    String GROUP = "GRUPAL";
    String INDIVIDUAL = "INDIVIDUAL";
    String INTERCYCLE = "INTERCICLO";
}
