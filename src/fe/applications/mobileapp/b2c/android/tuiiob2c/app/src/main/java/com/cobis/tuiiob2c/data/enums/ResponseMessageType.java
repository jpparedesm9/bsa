package com.cobis.tuiiob2c.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.SOURCE)
@StringDef({ResponseMessageType.SI, ResponseMessageType.NO, ResponseMessageType.OK})
public @interface ResponseMessageType {
    String SI = "SI";
    String NO = "NO";
    String OK = "OK";
}
