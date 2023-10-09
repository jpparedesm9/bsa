package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Created by mnaunay on 06/06/2017.
 */
@Retention(RetentionPolicy.SOURCE)
@StringDef({SectionCode.CUSTOMER_DATA, SectionCode.CUSTOMER_ADDRESS, SectionCode.PARTNER_DATA, SectionCode.PARTNER_WORK, SectionCode.CUSTOMER_BUSINESS, SectionCode.CUSTOMER_REFERENCES, SectionCode.CUSTOMER_PAYMENTS, SectionCode.CUSTOMER_DOCUMENTS, SectionCode.PROSPECT_DATA, SectionCode.COMPLEMENTARY_DATA})
public @interface SectionCode {
    String CUSTOMER_DATA = "CUS_DAT";
    String CUSTOMER_ADDRESS = "CUS_ADR";
    String PARTNER_DATA = "PAR_DAT";
    String PARTNER_WORK = "PAR_WOR";
    String CUSTOMER_BUSINESS = "CUS_BUS";
    String CUSTOMER_REFERENCES = "CUS_REF";
    String CUSTOMER_PAYMENTS = "CUS_PAY";
    String CUSTOMER_DOCUMENTS = "CUS_DOC";
    String PROSPECT_DATA = "PRO_DAT";
    String COMPLEMENTARY_DATA = "CUS_COM";
}