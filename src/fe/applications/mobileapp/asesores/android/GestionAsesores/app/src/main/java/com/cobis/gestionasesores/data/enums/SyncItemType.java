package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@IntDef({SyncItemType.CUSTOMER, SyncItemType.PROSPECT, SyncItemType.GROUP, SyncItemType.INDIVIDUAL_APPLICATION, SyncItemType.GROUP_APPLICATION, SyncItemType.PAYMENT, SyncItemType.GROUP_VERIFICATION, SyncItemType.INDIVIDUAL_VERIFICATION})
@Retention(RetentionPolicy.SOURCE)
public @interface SyncItemType {
    int COBIS_CUSTOMER = 1;
    int COBIS_GROUP = 2;
    int COBIS_GROUP_CREDIT = 3;
    int COBIS_INDIVIDUAL_CREDIT = 4;
    int COBIS_PAYMENTS = 5;
    int COBIS_GROUP_VERIFICATION = 6;
    int COBIS_INDIVIDUAL_VERIFICATION = 7;

    int CUSTOMER = 0xB1;
    int PROSPECT = 0xB2;
    int GROUP = 0xB3;
    int INDIVIDUAL_APPLICATION = 0xB4;
    int GROUP_APPLICATION = 0xB5;
    int PAYMENT = 0xB6;
    int GROUP_VERIFICATION = 0xB7;
    int INDIVIDUAL_VERIFICATION = 0xB8;
}