package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 16/06/2017.
 */

@Retention(RetentionPolicy.SOURCE)
@StringDef({PositionGroup.PRESIDENT,PositionGroup.SECRETARY,PositionGroup.TREASURER,PositionGroup.MEMBER})
public @interface PositionGroup {
    String PRESIDENT = "P";
    String SECRETARY = "S";
    String TREASURER = "T";
    String MEMBER = "M";
}
