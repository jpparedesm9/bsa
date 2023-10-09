package com.cobis.tuiiob2c.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.SOURCE)
@StringDef({NeedOtpType.YES, NeedOtpType.NO})
public @interface NeedOtpType {
    String YES = "S";
    String NO = "N";
}
