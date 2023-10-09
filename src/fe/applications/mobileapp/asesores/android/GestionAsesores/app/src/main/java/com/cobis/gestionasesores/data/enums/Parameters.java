package com.cobis.gestionasesores.data.enums;

import android.support.annotation.StringDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * List of the parameters keys
 * Created by mnaunay on 26/06/2017.
 */

@Retention(RetentionPolicy.SOURCE)
@StringDef({Parameters.AMOUNT_REQUEST_APP,
        Parameters.WARRANTY_LIQUID,
        Parameters.MIN_MEMBER,
        Parameters.MAX_MEMBER,
        Parameters.MAX_MEMBERS_GROUP_CREDIT,
        Parameters.MIN_MEMBERS_GROUP_CREDIT,
        Parameters.WHOLE_NUMBER_AMOUNT,
        Parameters.DECIMAL_AMOUNT,
        Parameters.DEFAULT_COUNTRY,
        Parameters.MAX_DOCUMENT_WIDTH,
        Parameters.MAX_DOCUMENT_HEIGHT,
        Parameters.DOCUMENT_COMPRESSION_QUALITY,
        Parameters.MIN_REFERENCES,
        Parameters.MAX_REFERENCES,
        Parameters.VERSION_CATALOGS,
        Parameters.VERSION_POSTAL_CODES,
        Parameters.MIN_ECONOMIC_DEPENDENTS,
        Parameters.MAX_ECONOMIC_DEPENDENTS,
        Parameters.IVA,
        Parameters.CITY_MAX_LENGTH,
        Parameters.MIN_AGE,
        Parameters.MAX_AGE,
        Parameters.MAX_LENGTH_ALIAS,
        Parameters.MIN_LENGTH_ALIAS,
        Parameters.CODE_REMOVED_USER,
        Parameters.DEFAULT_IMAGE_EXTENSION,
        Parameters.DOCUMENT_COUNT,
        Parameters.ALLOWEDDISTANCE
    })

public @interface Parameters {
    String AMOUNT_REQUEST_APP = "AMOUNT_REQUEST_APP";
    String WARRANTY_LIQUID = "WARRANTY_LIQUID";
    String MIN_MEMBER = "MIN_MEMBER";
    String MAX_MEMBER = "MAX_MEMBER";
    String MIN_MEMBERS_GROUP_CREDIT = "MIN_MEMBERS_GROUP_CREDIT";
    String MAX_MEMBERS_GROUP_CREDIT = "MAX_MEMBERS_GROUP_CREDIT";
    String WHOLE_NUMBER_AMOUNT = "WHOLE_NUMBER_AMOUNT";
    String DECIMAL_AMOUNT = "DECIMAL_AMOUNT";
    String DEFAULT_COUNTRY = "DEFAULT_COUNTRY";
    String MAX_DOCUMENT_WIDTH = "MAX_DOCUMENT_WIDTH";
    String MAX_DOCUMENT_HEIGHT = "MAX_DOCUMENT_HEIGHT";
    String DOCUMENT_COMPRESSION_QUALITY = "DOCUMENT_COMPRESSION_QUALITY";
    String MIN_REFERENCES = "MIN_REFERENCES";
    String MAX_REFERENCES = "MAX_REFERENCES";
    String VERSION_CATALOGS = "VERSION_CATALOGS";
    String VERSION_POSTAL_CODES = "VERSION_POSTAL_CODES";
    String MIN_ECONOMIC_DEPENDENTS= "MIN_ECONOMIC_DEPENDENTS";
    String MAX_ECONOMIC_DEPENDENTS= "MAX_ECONOMIC_DEPENDENTS";
    String IVA= "IVA";
    String CITY_MAX_LENGTH = "CITY_MAX_LENGTH";
    String MIN_AGE = "MIN_AGE";
    String MAX_AGE = "MAX_AGE";
    String MAX_LENGTH_ALIAS = "MAX_LENGTH_ALIAS";
    String MIN_LENGTH_ALIAS = "MIN_LENGTH_ALIAS";
    String CODE_REMOVED_USER = "CODE_REMOVED_USER";
    String DEFAULT_IMAGE_EXTENSION = "DEFAULT_IMAGE_EXTENSION";
    String DOCUMENT_COUNT = "DOCUMENT_COUNT";
    String ALLOWEDDISTANCE = "ALLOWEDDISTANCE";
}
