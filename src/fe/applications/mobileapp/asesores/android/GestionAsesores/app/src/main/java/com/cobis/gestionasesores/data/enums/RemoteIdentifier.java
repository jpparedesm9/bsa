package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.cobis.gestionasesores.data.enums.RemoteIdentifier.PROSPECT_ADDRESS;

/**
 * Created by bqtdesa02 on 7/13/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@IntDef({PROSPECT_ADDRESS})
public @interface RemoteIdentifier {
    int PROSPECT_ADDRESS  = 1;
}
