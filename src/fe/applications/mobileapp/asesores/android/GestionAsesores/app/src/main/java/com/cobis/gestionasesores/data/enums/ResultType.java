package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 26/07/2017.
 */

@Retention(RetentionPolicy.SOURCE)
@IntDef({ResultType.SUCCESS,ResultType.FAILURE, ResultType.FAILURE_LOCAL})
public @interface ResultType {
    int SUCCESS = 0;
    int FAILURE = 1;
    int FAILURE_LOCAL = 2;
}
