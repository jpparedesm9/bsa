package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 21/06/2017.
 */

@Retention(RetentionPolicy.SOURCE)
@StringDef({TerritorialOrganization.STATE,TerritorialOrganization.TOWN,TerritorialOrganization.VILLAGE})
public @interface TerritorialOrganization {
    String STATE    = "EST";
    String TOWN     = "MUN";
    String VILLAGE  = "COL";
}
