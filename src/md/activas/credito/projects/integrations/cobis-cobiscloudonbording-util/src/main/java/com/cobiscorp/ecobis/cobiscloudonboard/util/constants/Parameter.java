package com.cobiscorp.ecobis.cobiscloudonboard.util.constants;

public class Parameter {
	
	private Parameter() {
	    throw new IllegalStateException("Utility class");
	  }

	public static final String FORM_URLENCOD = "application/x-www-form-urlencoded";
	public static final String OAUTH_TOKEN_MNG = "oauth-token-management_1.0.0";
	public static final String POST_METHOD = "POST";
	public static final String UTF_8 = "utf-8";
	
	public static final String JSON = "application/json";
	public static final String VALUE = "value";
	public static final String BLANCK_SPACE = " ";
	public static final char CHR_TO_FILL = '0';
	
	//Servicios SG
	public static final String QUERY_EQUIVALENCES = "SystemConfiguration.EquivalenceManagement.QueryEquivalences";
	
	//Outputs
	public static final String OUTPUT = "com.cobiscorp.cobis.cts.service.response.output";
	public static final String OUT_VALOR_EQUIV = "@o_valor_equiv";
	
	//Catalogos
	public static final String CATALOG_CURP = "ENT_CURP";
	public static final String CATALOG_FED = "ENT_FED";
	
	//Canales
	public static final String FINGER_CHANNEL = "FI";
	public static final String GRANTTYPE_CLICRED = "client_credentials";

}
