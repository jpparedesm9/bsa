package com.cobis.tuiiob2c.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.SOURCE)
@StringDef({NotificationType.OK, NotificationType.YESORNO})
public @interface NotificationType {
    String OK = "OK";
    String YESORNO = "SN";
}
