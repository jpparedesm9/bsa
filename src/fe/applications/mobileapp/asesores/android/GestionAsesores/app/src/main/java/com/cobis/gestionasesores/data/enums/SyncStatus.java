package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.cobis.gestionasesores.data.enums.SyncStatus.ERROR;
import static com.cobis.gestionasesores.data.enums.SyncStatus.SYNCED;

@Retention(RetentionPolicy.SOURCE)
@IntDef({SyncStatus.DRAFT, SyncStatus.PENDING, SyncStatus.UNKNOWN, SYNCED, ERROR})
public @interface SyncStatus {
    int UNKNOWN = -1;
    int DRAFT = 0;
    int PENDING = 1;
    int SYNCED = 2;
    int ERROR = 3;
}