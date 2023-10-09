package com.cobis.gestionasesores.data.enums;

import android.support.annotation.IntDef;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.cobis.gestionasesores.data.enums.Catalog.CAT_ACTIVITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_BUSINESS_TYPE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CIVIL_STATUS;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CONTINENT;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_COUNTRY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CREDIT_DESTINATION;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CREDIT_FREQUENCY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CREDIT_PAY_RES;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CREDIT_TERM_MONTHS;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CREDIT_TYPE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CR_DESTINATION;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CURRENCY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_DATA_STATE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_DAY_OF_WEEK;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_DOCUMENT_TYPES;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_EDUCATION_LEVEL;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_FAMILY_RELATIONSHIP;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_HOUSING_TYPE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_INCOME_SOURCE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_JOB_TITLE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_MEETING_LOCATION;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_NATIONALITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_OCCUPATION;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_OFFICE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PARISH;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PEP_RELATIONSHIP;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_POSITION;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PRODUCT;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PROVINCE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_QUANTITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_QUESTIONS_GROUP;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_QUESTIONS_INDIVIDUAL;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_SEX;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_SIMULATOR_TERM;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_SUBSIDIARY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_TECHNICAL_DEGREE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_TURNAROUND;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_ZONE;

/**
 * Created by bqtdesa02 on 6/6/2017.
 * 1      Actividad
 * 2      Cargo
 * 3      Sexo
 * 4      Dias de la Semana
 * 5      Continentes
 * 6      Estado de Datos
 * 7      Filiales
 * 8      Oficinas
 * 9      Monedas
 * 10     Zonas de Direccion
 * 11     Productos Cobis
 * 12     Paises
 * 13     Provincias
 * 14     Distritos
 * 15     Corregimientosa
 */

@Retention(RetentionPolicy.SOURCE)
@IntDef({CAT_ACTIVITY,
        CAT_JOB_TITLE,
        CAT_SEX,
        CAT_DAY_OF_WEEK,
        CAT_CONTINENT,
        CAT_DATA_STATE,
        CAT_SUBSIDIARY,
        CAT_OFFICE,
        CAT_CURRENCY,
        CAT_ZONE,
        CAT_PRODUCT,
        CAT_COUNTRY,
        CAT_PROVINCE,
        CAT_CITY,
        CAT_PARISH,
        CAT_CIVIL_STATUS,
        CAT_EDUCATION_LEVEL,
        CAT_TECHNICAL_DEGREE,
        CAT_INCOME_SOURCE,
        CAT_PEP_RELATIONSHIP,
        CAT_OCCUPATION,
        CAT_NATIONALITY,
        CAT_TURNAROUND,
        CAT_HOUSING_TYPE,
        CAT_QUANTITY,
        CAT_BUSINESS_TYPE,
        CAT_CREDIT_DESTINATION,
        CAT_CREDIT_PAY_RES,
        CAT_DOCUMENT_TYPES,
        CAT_FAMILY_RELATIONSHIP,
        CAT_MEETING_LOCATION,
        CAT_POSITION,
        CAT_CREDIT_TERM_MONTHS,
        CAT_CREDIT_FREQUENCY,
        CAT_CREDIT_TYPE,
        CAT_QUESTIONS_INDIVIDUAL,
        CAT_QUESTIONS_GROUP,
        CAT_CR_DESTINATION,
        CAT_SIMULATOR_TERM})
public @interface Catalog {
    char CAT_ACTIVITY = 1;
    char CAT_JOB_TITLE = 2;
    char CAT_SEX = 3;
    char CAT_DAY_OF_WEEK = 4;
    char CAT_CONTINENT = 5;
    char CAT_DATA_STATE = 6;
    char CAT_SUBSIDIARY = 7;
    char CAT_OFFICE = 8;
    char CAT_CURRENCY = 9;
    char CAT_ZONE = 10;
    char CAT_PRODUCT = 11;
    char CAT_COUNTRY = 12;
    char CAT_PROVINCE = 13;
    char CAT_CITY = 14;
    char CAT_PARISH = 15;
    char CAT_CIVIL_STATUS = 17;
    char CAT_EDUCATION_LEVEL = 18;
    char CAT_TECHNICAL_DEGREE = 19;
    char CAT_INCOME_SOURCE = 20;
    char CAT_PEP_RELATIONSHIP = 21;
    char CAT_OCCUPATION = 22;
    char CAT_NATIONALITY = 23;
    char CAT_TURNAROUND = 24;
    char CAT_HOUSING_TYPE = 26;
    char CAT_QUANTITY = 27;
    char CAT_BUSINESS_TYPE = 28;
    char CAT_CREDIT_DESTINATION = 29;
    char CAT_CREDIT_PAY_RES = 30;
    char CAT_DOCUMENT_TYPES = 31;
    char CAT_FAMILY_RELATIONSHIP = 32;
    char CAT_MEETING_LOCATION = 33;
    char CAT_POSITION = 34;
    char CAT_CREDIT_TERM_MONTHS = 35;
    char CAT_CREDIT_FREQUENCY = 36;
    char CAT_CREDIT_TYPE = 37;
    char CAT_QUESTIONS_INDIVIDUAL = 38;
    char CAT_QUESTIONS_GROUP = 39;
    char CAT_CR_DESTINATION = 40;
    char CAT_SIMULATOR_TERM = 41;
}
