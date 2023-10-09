package com.cobiscorp.ecobis.cobiscloudbiometric.util.constants;

public class Parameter {
	
	private Parameter() {
	    throw new IllegalStateException("Utility class");
	  }

	
	public static final String POST_METHOD = "POST";
	public static final String UTF_8 = "utf-8";
	public static final String JSON = "application/json";
	public static final String VALUE = "value";
	public static final String BLANCK_SPACE = " ";
	public static final String DATE_FORMAT_1 = "yyyyMMddhhmmssSSS";
	public static final String BIOCHECK_NOK = "EVD05";
	public static final String BIOCHECK_OK = "OK0000";
	public static final String N_FLAG = "N";
		
	//Servicios SG
	public static final String QUERY_EQUIVALENCES = "SystemConfiguration.EquivalenceManagement.QueryEquivalences";
	
	//Outputs
	public static final String OUTPUT = "com.cobiscorp.cobis.cts.service.response.output";
	public static final String OUT_VALOR_EQUIV = "@o_valor_equiv";
	
	public static final String OUT_RESULTADO = "@o_resultado1";

	//Catalogos
	public static final String CATALOG_CURP = "ENT_CURP";
	public static final String CATALOG_FED = "ENT_FED";
	
	public static final String RENAPO_FLAG = "RENAPO";

}
