package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by Miguel on 15/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({DocumentType.FRONT_IDENTIFICATION, DocumentType.BACK_IDENTIFICATION, DocumentType.PROOF_ADDRESS, DocumentType.NOTICE_PRIVACY, DocumentType.AUTHORIZATION, DocumentType.SHORT_REQUEST})
public @interface DocumentType {
    String FRONT_IDENTIFICATION = "001";
    String BACK_IDENTIFICATION = "002";
    String PROOF_ADDRESS = "003";
    String NOTICE_PRIVACY = "004";
    String AUTHORIZATION = "005";
    String SHORT_REQUEST = "008";
}