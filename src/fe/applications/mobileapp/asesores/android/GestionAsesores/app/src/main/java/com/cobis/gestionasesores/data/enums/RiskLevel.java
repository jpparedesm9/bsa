package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Risk level options
 * Created by mnaunay on 27/06/2017.
 */

@Retention(RetentionPolicy.SOURCE)
@StringDef({RiskLevel.LOW,RiskLevel.MEDIUM,RiskLevel.HIGH})
public @interface RiskLevel {
    String LOW = "B";
    String MEDIUM = "M";
    String HIGH = "A";
}