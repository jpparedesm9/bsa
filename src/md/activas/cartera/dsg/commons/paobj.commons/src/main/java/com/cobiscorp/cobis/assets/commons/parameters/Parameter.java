package com.cobiscorp.cobis.assets.commons.parameters;

public abstract class Parameter {

	public static final String PROCESS_QUERYPRODUCTLIST = "";

	public static final String DATEFORMAT = "dd/MM/yyyy";
	public static final int CODEDATEFORMAT = 103;
	public static final int VALIDATIONYEAR = 1900;

	public static final String DATEFORMATDB = "yyyy/MM/dd";
	public static final int CODEDATEFORMATDB = 111;

	public static final String EMPTY = "";
	public static final String EMPTY_VALUE = "";
	public static final Integer NUM_REG_TR_MON = 0;
	public static final Integer NUM_REGISTRO = 0;

	public static final char QUERYTYPEA = 'A';
	public static final Integer QUERYTYPE1 = 1;

	public static final String OPERATIONI = "I";
	public static final String OPERATIONQ = "Q";
	public static final String OPERATIONA = "A";
	public static final String OPERATIONB = "B";
	public static final String OPERATIONH = "H";
	public static final String OPERATIOND = "D";
	public static final String OPERATIONV = "V";
	public static final String OPERATIONC = "C";

	public static final String STRING_V = "V";

	public static final String MODEA = "A";
	public static final String MODEB = "B";
	public static final Integer MODE0 = 0;

	public static final String YES = "SI";
	public static final String NO = "NO";

	public static final String DATEFORMATMMDDYYYY = "MM/dd/yyyy";

	public enum TYPEEXECUTION {
		UPDATE, DELETE, SEARCH
	}

	public enum TYPEDATEFORMAT {
		DDMMYYYY, YYYYMMDD, MMDDYYYY
	}

	public enum LEVELDEBUG {
		ERROR, DEBUG, INFO
	}

	public enum AMORTIZATION_STATUS {
		CANCELADO, VENCIDO, VIGENTE, NO_VIGENTE, OTHER;

		public static AMORTIZATION_STATUS getValue(String value) {
			for (AMORTIZATION_STATUS status : AMORTIZATION_STATUS.values()) {
				if (status.name().equals(value)) {
					return valueOf(value);
				}
			}
			return AMORTIZATION_STATUS.OTHER;
		}
	}

	public enum ARREARS_CODES {
		CAP, INT, IMO, OTHER;

		public static ARREARS_CODES getValue(String value) {
			for (ARREARS_CODES arrear : ARREARS_CODES.values()) {
				if (arrear.name().equals(value)) {
					return valueOf(value);
				}
			}
			return ARREARS_CODES.OTHER;
		}
	}

	public static final int REGISTERS_FOR_PAGE = 20;
	public static final int REGISTERS_PAYMENT = 17;

	public static final int REGISTERS_FOR_CATALOG = 0;
	public static final int DIVIDEND = 0;

	public static final String MESSAGESERVERLIST = "MESSAGESERVERLIST";
	public static final String MESSAGEVALIDATIONLIST = "MESSAGEVALIDATIONLIST";
	public static final String RESULTLIST = "RESULTLIST";
	public static final String RESULTLISTCATALOG = "RESULTLISTCATALOG";

	public static final String SUCCESSFUL_TRANSACTION = "CSTMR.LBL_CSTMR_LATRANSZA_43084";
	public static final String MISSING_RECORDS = "CSTMR.LBL_CSTMR_NOEXISTSN_20137";
}
