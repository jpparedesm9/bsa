package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.cobis.gestionasesores.data.enums.TaskType.GROUP_VERIFICATION;
import static com.cobis.gestionasesores.data.enums.TaskType.INDIVIDUAL_VERIFICATION;
import static com.cobis.gestionasesores.data.enums.TaskType.SOLIDARITY_PAYMENT;
import static com.cobis.gestionasesores.data.enums.TaskType.UNKNOWN;

@Retention(RetentionPolicy.SOURCE)
@StringDef({SOLIDARITY_PAYMENT, GROUP_VERIFICATION, INDIVIDUAL_VERIFICATION, UNKNOWN})
public @interface TaskType {
    String UNKNOWN = "";
    String SOLIDARITY_PAYMENT = "1";
    String GROUP_VERIFICATION = "2";
    String INDIVIDUAL_VERIFICATION = "3";
}
