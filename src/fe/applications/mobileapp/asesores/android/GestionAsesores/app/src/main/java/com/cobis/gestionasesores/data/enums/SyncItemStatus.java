package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 15/08/2017.
 */
@StringDef({SyncItemStatus.PENDING, SyncItemStatus.ERROR, SyncItemStatus.SYNCED_ERROR, SyncItemStatus.DOWNLOADED, SyncItemStatus.SUCCESS})
@Retention(RetentionPolicy.SOURCE)
public @interface SyncItemStatus {
    String PENDING = "P";
    String ERROR = "E";
    String SYNCED_ERROR = "F"; //This state is used to indicate that an item with error was acknowledged by the app so the server doesn't send it again
    String DOWNLOADED = "D";
    String SUCCESS = "S";

}
