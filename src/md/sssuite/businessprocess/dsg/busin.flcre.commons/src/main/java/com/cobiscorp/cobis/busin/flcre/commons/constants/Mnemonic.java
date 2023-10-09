package com.cobiscorp.cobis.busin.flcre.commons.constants;

public interface Mnemonic {
	final String STRING_SPACE = " ";
	final String DEBTOR = "D";
	final String DEBTOR_GRUPAL = "G";
	final String COSIGNER = "C";
	final String CAPITALFIXED = "ALEMANA";
	final String QUOTAFIXED = "FRANCESA";
	final String MANUAL = "MANUAL";
	final String OPERTATIONTYPE = "CRE";
	final String PRODUCT = "CRE";
	final char CHAR_SPACE = ' ';
	final char CHAR_S = 'S';
	final char CHAR_N = 'N';
	final char CHAR_0 = '0';
	final char CHAR_1 = '1';
	final char CHAR_2 = '2';
	final char CHAR_3 = '3';
	final char CHAR_4 = '4';
	final char CHAR_5 = '5';
	final char CHAR_6 = '6';
	final char CHAR_O = 'O';
	final char CHAR_I = 'I';
	final char CHAR_D = 'D';
	final char CHAR_X = 'X';
	final char CHAR_G = 'G';
	final char CHAR_T = 'T';
	final char CHAR_L = 'L';

	final String STRING_0 = "0";
	final String STRING_1 = "1";
	final String STRING_2 = "2";
	final String STRING_3 = "3";
	final String STRING_4 = "4";
	final String STRING_S = "S";
	final String STRING_N = "N";
	final String STRING_O = "O";
	final String STRING_L = "L";
	final String STRING_C = "C";
	final String STRING_F = "F";
	final String STRING_D = "D";
	final String STRING_I = "I";
	final String STRING_R = "R";
	final String STRING_A = "A";
	final String STRING_E = "E";
	final String CONCEPT = "INT";
	final String ORIGINALREQUEST = "O";
	final String LINEREQUEST = "L";
	final String MODIFICATIONLINEREQUEST = "P";
	final String EXPROMISSIONREQUEST = "R";
	final String REFINANCINGREQUEST = "R";
	final String RESCHEDULEREQUEST = "E";
	final String WARRANTYMODIFYREQUEST = "G";
	final String CUMPLE = "CUMPLE";
	final String EXCEPCION = "EXCEPCION";
	final String STAGEANALIYSIS = "ANALISIS";
	final String STAGEENTRY = "INGRESO";
	final String STAGEPRINTINGDOCUMENTS = "IMPRESION_DOCUMENTOS";
	final String STAGEANALISISOFICIAL = "ANALISIS_OFICIAL";
	final String STAGECUOTABALANCE = "CUOTA_SALDO_DISPONIBLE";
	final String STAGEASIGNACION_OFICIAL = "ASIGNACION_OFICIAL";
	final String STAGE_PAYMENT_PLAN = "PLANPAGO";
	final String STAGE_PAYMENT_PLAN_RECALCULATION = "RECALCULO";
	final String REQUESTNAME_WARRANTYMODIFY = "WARRANTYMODIFY";
	final String SOCIALHOUSING = "V";
	final String ARREARS = "M";
	final String CAPITAL = "CAP";
	final String INTEREST = "INT";
	final String PENALIZATION = "C";
	final String TYPECUSTOMERACTIVITY = "S";
	final String OFFICERTYPE_CREDITANALYST = "AC";
	final String OFFICERTYPE_INBOX = "IN";
	final String BONUSPROCESSNAME = "APROBACION BONO EJECUTIVO";
	final String APROBATION = "A";
	final String UPDATE = "U";
	final String INSERT = "I";
	final String APROVAL = "APROBACION";
	final String SPECIAL = "ESP";
	final String NORMAL = "NOR";
	final String TS_ADICION = "ABG";
	final String TS_SUSTITUCION = "CJE";
	final String TS_ELIMINACION = "LEV";
	final String TYPEREQUEST = "TRAMITE";
	final String STAGE = "ETAPA";
	final String TYPEREQUESTGUARANTEESTICKETE = "GUARANTEESTICKET";
	final String TYPEREQUESTORIGINAL = "ORIGINAL";
	final String TYPEREQUESTEXPROMISSION = "EXPROMISION";
	final String TYPEREQUEST_MODLC_MONTO_PLAZO = "MODLC_MONTO_PLAZO";
	final String TYPEREQUEST_MODLCPLAZO = "MODLCPLAZO";
	final String DISBURSEMENTCREDITLINEPROCESSNAME = "DESEMBOLSO_LC";
	final String TYPEREQUEST_CREDIT_CARD = "CREDIT_CARD";
	final String CAPITALOPERACION = "OBCRE";
	final String CAPITALINVERSION = "OBCICR";
	final String LIBREDISPONIBILIDAD = "OCLD";
	final String VIVIENDA = "OBCVIV";
	final String CONSUMO = "OBCONS";
	final String PARAMETER_MLO = "MLO";
	final String PARAMETER_FPREF = "FPREF";
	final String BOLETAGAR = "BOLGAR";
	final String String_Si = "Si";
	final String String_No = "No";
	final String VARIABLE_NAME_RESULT_POLICY = "M-Resultado Politica";
	final String VARIABLE_NAME_RESULT_ESTADO = "Máximo Número de Impresiones";
	final String RENOVATIONREQUEST = "R";

	/* Modules */
	final String PRODUCT_ADMIN = "ADM";
	final String MODULE = "CRE";
	final String MODULECCA = "CCA";
	final String COMEXT = "CEX";
	final String TYPE_PRODUCT_GRB = "GRB";

	/* catalogos */
	final String CATALOG_SIZE_INDEX = "cr_tamano_indice";
	final String CATALOG_SIZE_COMPANY = "cr_tamano_empresa";
	final String CATALOG_ACTIVITY = "cl_actividad_ec";
	final String CATALOG_SECTOR = "cc_sector";
	final String CATALOG_PAYMENTFRECUENCY = "ca_tdividendo";
	final String SCORETYPE_BUSINESSMANUAL = "MEM";

	/* Parametros Generales APF */
	final String PLAZO = "Plazo";
	final String TIPO_CUOTA = "Tipo de cuota";

	/* Parametros Generales */
	final String PG_CAPITAL = "CAPITAL";
	final String PG_INTERES = "INTERES";
	final String PG_INTERES_PENAL = "INTERES PENAL";
	final String PG_INTERES_MORA = "INTERES MORA";
	final String PG_TOTAL = "TOTAL";
	final String PG_OTROS = "OTROS";

	/* Cache key */
	final String CACHE_KEY = "BusinessProcessCache";
	
	/*Para sp*/
	final static String TRN = "@t_trn";
	final static String OPERACION = "@i_operacion";
	final static String TIPO = "@i_tipo";
	final static String TIPO_H = "@i_tipo_h";
	final static String MODO = "@i_modo";
	final static String ROWCOUNT = "@i_rowcount";
	final static String DISTRITO = "@i_distrito";
	final static String PROVINCIA = "@i_provincia";
	final static String CIUDAD = "@i_ciudad";
	final static String PAIS = "@i_pais";
	final static String CANTON = "@i_canton";
	final static String FILTRO = "@i_filtro";
	final static String PRODUCTO = "@i_producto";
	final static String IDREQUESTED = "@i_tramite";
	final static String OPERACION_H = "H";
	final static String OPERACION_S = "S";
	final static String OPERACION_Q = "Q";
	final static String TIPO_A = "A";
	final static String TIPO_P = "P";
	final static String CERO = "0";
	final static String TIPO_B = "B";
	final static String POSTAL = "@i_cod_postal";

	/* FILIAL y BRANCH */
	final int FILIAL = 1;
	final int BRANCHOFFICE = 1;
	
	/*Tipo de Prestamos*/
	final static String PRESTAMO_EMERGENTE = "INTCLGRP";
	final static String PRESTAMO_GRUPAL = "GRUPAL";
	final static String PRESTAMO_INDIVIDUAL = "INDIVIDUAL"; //Normal
	final static String PRESTAMO_INTERCICLO = "INTERCICLO";
	final static String VAR_NUMERO_CICLOS = "Número de Ciclos Préstamo Emergente";
	final static String VAR_MONTO_MIN_EMERGENTE = "Monto Mínimo Préstamo Emergente";
	final static String VAR_MONTO_MAX_EMERGENTE = "Monto Máximo Préstamo Emergente";

}
